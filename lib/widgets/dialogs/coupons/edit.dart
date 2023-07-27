import 'package:flutter/material.dart';
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
          'Agrega un nuevo cupón',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
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
            isNumeric: true,
            onChanged: (String value) {
              if (value.isNotEmpty) {
                double money = double.tryParse(value)!;
                _couponProvider.onChangeMonetization(money);
              }
            },
            hintText: 'Valor monetario del cupón'),
        SizedBox(height: 25),
        Text('Añadir a todas las subtiendas'),
        SizedBox(height: 5),
        Row(
          children: [
            Row(
              children: [
                Radio(
                    value: 0,
                    groupValue: _couponProvider.addToStores,
                    onChanged: (value) {
                      _couponProvider.addToStoresSelection(value!);
                    }),
                Text('Si')
              ],
            ),
            Row(
              children: [
                Radio(
                    value: 1,
                    groupValue: _couponProvider.addToStores,
                    onChanged: (value) {
                      _couponProvider.addToStoresSelection(value!);
                    }),
                Text('No')
              ],
            ),
          ],
        ),
      ],
    );
  }
}
