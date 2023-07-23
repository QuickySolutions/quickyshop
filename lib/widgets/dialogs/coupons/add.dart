import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/providers/coupons/coupon_provider.dart';
import 'package:quickyshop/widgets/inputs/searchfield.dart';

class AddCouponForm extends StatelessWidget {
  AddCouponForm({super.key});

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
            hintText: 'Nombre del cupón',
            onChanged: (String value) {
              _couponProvider.onChangeName(value);
            }),
        SizedBox(height: 15),
        QuickyTextField(
            isNumeric: true,
            onChanged: (dynamic value) {
              double money = double.tryParse(value)!;
              _couponProvider.onChangeMonetization(money);
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
