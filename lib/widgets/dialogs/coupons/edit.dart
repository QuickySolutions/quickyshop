import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/providers/coupons/coupon_provider.dart';
import 'package:quickyshop/widgets/inputs/quicky_textfield.dart';

class EditCouponForm extends StatelessWidget {
  EditCouponForm({super.key});

  @override
  Widget build(BuildContext context) {
    CouponProvider _couponProvider = Provider.of<CouponProvider>(context);
    return Column(
      children: [
        Text(
          'Editar un cupón',
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
                        image: AssetImage('assets/images/not-available.png'))
                    : DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(_couponProvider.selectedFile))),
            height: 120,
          ),
        ),
        SizedBox(height: 20),
        QuickyTextField(
            defaultValue: _couponProvider.couponName,
            hintText: 'Nombre del cupón',
            onChanged: (String value) {
              _couponProvider.onChangeName(value);
            }),
        SizedBox(height: 15),
        QuickyTextField(
            defaultValue: _couponProvider.couponMonetization.toString(),
            keyboardType: TextInputType.number,
            onChanged: (String value) {
              if (value.isNotEmpty) {
                double money = double.tryParse(value)!;
                _couponProvider.onChangeMonetization(money);
              }
            },
            hintText: 'Valor monetario del cupón'),
      ],
    );
  }
}
