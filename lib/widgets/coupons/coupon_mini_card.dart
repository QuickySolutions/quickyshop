import 'package:flutter/material.dart';
import 'package:quickyshop/models/Coupon.dart';
import 'package:quickyshop/models/Store.dart';

import '../../utils/Colors.dart';

class CouponMiniCard extends StatelessWidget {
  final bool isSelected;
  final bool showImage;
  final Coupon coupon;
  final void Function()? onTap;
  const CouponMiniCard(
      {super.key,
      required this.showImage,
      required this.onTap,
      this.isSelected = false,
      required this.coupon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          isSelected
              ? BoxShadow(
                  color: QuickyColors.primaryColor,
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 1),
                )
              : BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 1),
                )
        ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
                errorBuilder: (context, error, stackTrace) {
                  return Image(
                      image: AssetImage('assets/images/not-available.png'));
                },
                image: NetworkImage(
                    'https://fingerprint.com/static/e972d7a2b37a5ca2e40f47af17c3abf3/45e84/what-is-coupon-glittering-how-can-it-harm-your-business_.jpg')),
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${coupon.name}'),
                  SizedBox(height: 8),
                  Text("\$${coupon.monetization.toDouble()}")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
