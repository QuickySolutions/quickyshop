import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/providers/coupons/coupon_provider.dart';
import 'package:quickyshop/providers/store/store_provider.dart';
import 'package:quickyshop/utils/Colors.dart';
import 'package:quickyshop/widgets/dialogs/stores/store_list.dart';
import 'package:quickyshop/widgets/inputs/quicky_textfield.dart';

class AddCouponForm extends StatelessWidget {
  AddCouponForm({super.key});

  @override
  Widget build(BuildContext context) {
    CouponProvider _couponProvider = Provider.of<CouponProvider>(context);
    StoreProvider storeProvider = Provider.of<StoreProvider>(context);
    return PageView(
      controller: _couponProvider.pageController,
      children: [
        Column(
          children: [
            Text(
              'Agrega un nuevo cupón',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                PickedFile? pickedFile = await ImagePicker().getImage(
                  source: ImageSource.gallery,
                  maxWidth: 1800,
                  maxHeight: 1800,
                );
                if (pickedFile != null) {
                  File imageFile = File(pickedFile.path);
                  _couponProvider.selectImage(imageFile);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    image: _couponProvider.selectedFile.path.isEmpty
                        ? DecorationImage(
                            image:
                                AssetImage('assets/images/not-available.png'))
                        : DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(_couponProvider.selectedFile))),
                height: 120,
              ),
            ),
            SizedBox(height: 20),
            QuickyTextField(
                hintText: 'Nombre del cupón',
                onChanged: (String value) {
                  _couponProvider.onChangeName(value);
                }),
            SizedBox(height: 15),
            QuickyTextField(
                keyboardType: TextInputType.number,
                onChanged: (String? value) {
                  if (value!.isEmpty) {
                    _couponProvider.onChangeMonetization(0.0);
                  } else {
                    double money = double.tryParse(value)!;
                    _couponProvider.onChangeMonetization(money);
                  }
                },
                hintText: 'Valor monetario del cupón'),
            SizedBox(height: 10),
            // Container(
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Transform.scale(
            //         scale: 1.2,
            //         child: Checkbox(
            //             checkColor: Colors.white,
            //             activeColor: QuickyColors.primaryColor,
            //             shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(5)),
            //             value: storeProvider.wantToSaveInAllStores,
            //             onChanged: (value) {
            //               storeProvider.onSaveInAllStores(value!);
            //             }),
            //       ),
            //       Expanded(child: Text('Enviar este cupon a tiendas'))
            //     ],
            //   ),
            // ),
          ],
        ),
        StoreList()
      ],
    );
  }
}
