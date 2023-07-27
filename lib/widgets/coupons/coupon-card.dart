import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/models/Coupon.dart';
import 'package:quickyshop/providers/coupons/coupon_provider.dart';
import 'package:quickyshop/widgets/dialogs/QuickyAlertDialog.dart';
import 'package:quickyshop/widgets/dialogs/coupons/content_alert_coupon.dart';

class CouponCard extends StatelessWidget {
  Coupon coupon;

  CouponCard({required this.coupon});

  @override
  Widget build(BuildContext context) {
    CouponProvider couponProvider = Provider.of<CouponProvider>(context);
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                      height: 130,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://fingerprint.com/static/e972d7a2b37a5ca2e40f47af17c3abf3/45e84/what-is-coupon-glittering-how-can-it-harm-your-business_.jpg')),
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(coupon.name),
                      Text("\$${coupon.monetization.toDouble()}")
                    ],
                  ),
                ),
              ],
            ),
          )),
          SizedBox(width: 20),
          Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey.withOpacity(0.1),
                radius: 30,
                child: GestureDetector(
                  onTap: () {
                    couponProvider.selectCouponToEdit(coupon);
                    editCoupon(couponProvider, context);
                  },
                  child: Image(
                      height: 20,
                      image: AssetImage('assets/icons/usability/edit.png')),
                ),
              ),
              SizedBox(height: 10),
              CircleAvatar(
                backgroundColor: Colors.grey.withOpacity(0.1),
                radius: 30,
                child: GestureDetector(
                  onTap: () {
                    couponProvider.delete(coupon.id!);
                  },
                  child: Image(
                      height: 20,
                      image:
                          AssetImage('assets/icons/usability/close-icon.png')),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void editCoupon(CouponProvider couponProvider, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return QuickyAlertDialog(
              onNextClick: () {
                if (couponProvider.isValidForm) {
                  Coupon couponItem = Coupon(
                      id: couponProvider.selectedCoupon.id,
                      active: true,
                      brandId: '64989445c41230ffd2539f89',
                      name: couponProvider.couponName,
                      monetization: couponProvider.couponMonetization);
                  couponProvider.update(couponItem);
                  Navigator.pop(context);
                } else {
                  const snackBar = SnackBar(
                    content: Text('Rellena los datos'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              showNextButton: true,
              size: 'md',
              childContent: ContentAlertCoupon(
                operationType: OperationType.edit,
              ));
        });
  }
}
