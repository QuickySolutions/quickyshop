import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/models/Coupon.dart';
import 'package:quickyshop/providers/app/appProvider.dart';
import 'package:quickyshop/providers/coupons/coupon_provider.dart';
import 'package:quickyshop/providers/store/store_provider.dart';
import 'package:quickyshop/providers/survey/survey_provider.dart';
import 'package:quickyshop/utils/Colors.dart';
import 'package:quickyshop/widgets/buttons/quickyButton.dart';
import 'package:quickyshop/widgets/coupons/coupon_mini_card.dart';
import 'package:quickyshop/widgets/dialogs/QuickyAlertDialog.dart';
import 'package:quickyshop/widgets/inputs/quicky_textfield.dart';

class CouponSelectScreen extends StatefulWidget {
  const CouponSelectScreen({super.key});

  @override
  State<CouponSelectScreen> createState() => _CouponSelectScreenState();
}

class _CouponSelectScreenState extends State<CouponSelectScreen> {
  @override
  void initState() {
    final couponModel = Provider.of<CouponProvider>(context, listen: false);
    // Call getAll when the widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      couponModel.getAll();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final storeProvider = Provider.of<StoreProvider>(context);
    final surveyProvider = Provider.of<SurveyProvider>(context);

    return Scaffold(
      body: Consumer<CouponProvider>(
        builder: (context, couponModel, _) {
          return Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Cupones', style: TextStyle(fontSize: 18)),
                Text(
                  'Puedes crear un cupon o seleccionar uno de tu listado.',
                  style:
                      TextStyle(fontSize: 13, color: QuickyColors.borderColor),
                ),
                const SizedBox(height: 15),
                QuickyTextField(
                  hintText: 'Nombre del cupon',
                  onChanged: (value) {
                    couponModel.onChangeName(value);
                  },
                ),
                const SizedBox(height: 15),
                QuickyTextField(
                  keyboardType: TextInputType.number,
                  hintText: 'Costo/Valor del cupon',
                  onChanged: (value) {
                    couponModel.onChangeMonetization(double.parse(value));
                  },
                ),
                const SizedBox(height: 15),
                QuickyButton(
                  type: QuickyButtonTypes.tertiary,
                  onTap: () {
                    if (couponModel.isValidForm) {
                      Coupon couponItem = Coupon(
                          active: true,
                          brandId: appProvider.brandDefault.id,
                          name: couponModel.couponName,
                          monetization: couponModel.couponMonetization);
                      couponModel.create(couponItem, storeProvider);
                    } else {
                      const snackBar = SnackBar(
                        content: Text('Rellena los datos'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: couponModel.isLoading
                      ? const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(width: 10),
                            Text('Creando...')
                          ],
                        )
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '+',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Crear un cupón',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: couponModel.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Tus cupones'),
                            const Divider(),
                            const SizedBox(height: 15),
                            Expanded(
                                child: ListView.builder(
                              itemCount: couponModel.couponsList.length,
                              itemBuilder: (context, index) {
                                final coupon = couponModel.couponsList[index];
                                return Container(
                                  margin: const EdgeInsets.all(10),
                                  child: CouponMiniCard(
                                      isSelected: coupon.id ==
                                          surveyProvider.couponSelected.id,
                                      showImage: false,
                                      onTap: () {
                                        surveyProvider.selectCoupon(coupon);
                                      },
                                      coupon: coupon),
                                );
                              },
                            )),
                          ],
                        ),
                ),
                const SizedBox(height: 10),
                Container(
                  alignment: Alignment.center,
                  child: QuickyButton(
                      type: QuickyButtonTypes.primary,
                      onTap: surveyProvider.couponSelected.id!.isEmpty
                          ? null
                          : () {
                              surveyProvider.changePage();
                            },
                      child: const Text(
                        'Continuar',
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      )),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
