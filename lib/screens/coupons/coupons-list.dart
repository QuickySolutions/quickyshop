import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/models/Coupon.dart';
import 'package:quickyshop/preferences/appPreferences.dart';
import 'package:quickyshop/providers/coupons/coupon_provider.dart';
import 'package:quickyshop/providers/store/store_provider.dart';
import 'package:quickyshop/utils/Colors.dart';
import 'package:quickyshop/widgets/coupons/coupon-card.dart';
import 'package:quickyshop/widgets/dialogs/QuickyAlertDialog.dart';
import 'package:quickyshop/widgets/dialogs/coupons/content_alert_coupon.dart';

class CouponsListScreeen extends StatefulWidget {
  const CouponsListScreeen({super.key});

  @override
  State<CouponsListScreeen> createState() => _CouponsListScreeenState();
}

class _CouponsListScreeenState extends State<CouponsListScreeen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CouponProvider>(context, listen: false).getAll();
    });
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CouponProvider couponProvider = Provider.of<CouponProvider>(context);
    StoreProvider storeProvider = Provider.of<StoreProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: QuickyColors.primaryColor,
        onPressed: () => addNewCoupon(couponProvider, storeProvider),
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(top: 70, bottom: 20, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Mis cupones',
                    style: TextStyle(fontSize: 25),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image(
                        height: 60,
                        image: AssetImage('assets/images/go-back.png')),
                  )
                ],
              ),
              SizedBox(height: 20),
              Consumer<CouponProvider>(builder: (context, data, child) {
                return data.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: QuickyColors.primaryColor,
                        ),
                      )
                    : data.couponsList.length == 0
                        ? Center(
                            child: Text('No hay datos'),
                          )
                        : Column(
                            children: data.couponsList
                                .map((e) => CouponCard(coupon: e))
                                .toList(),
                          );
              })
            ],
          ),
        ),
      ),
    );
  }

  void addNewCoupon(
      CouponProvider couponProvider, StoreProvider storeProvider) {
    showDialog(
        context: context,
        builder: (context) {
          return QuickyAlertDialog(
              onNextClick: () {
                if (couponProvider.isValidForm &&
                    !storeProvider.wantToSaveInAllStores) {
                  Coupon couponItem = Coupon(
                      active: true,
                      brandId: AppPreferences().brandId,
                      name: couponProvider.couponName,
                      monetization: couponProvider.couponMonetization);

                  couponProvider.create(couponItem);
                  Navigator.pop(context);
                } else if (couponProvider.isValidForm &&
                    storeProvider.wantToSaveInAllStores) {
                  couponProvider.changePageContent();
                } else {
                  const snackBar = SnackBar(
                    content: Text('Rellena los datos'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              showNextButton: true,
              size: 'md',
              childContent: PageView(
                onPageChanged: (value) {
                  couponProvider.setPage(value);
                },
                controller: couponProvider.pageController,
                children: [
                  ContentAlertCoupon(
                    operationType: OperationType.add,
                  ),
                  ContentAlertCoupon(
                    operationType: OperationType.storeslist,
                  ),
                ],
              ));
        });
  }
}
