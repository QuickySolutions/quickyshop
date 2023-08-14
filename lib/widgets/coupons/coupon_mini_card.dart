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
        // width: MediaQuery.of(context).size.width,
        // padding: EdgeInsets.all(10),
        // decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(10),
        //     color: Colors.white,
        //     boxShadow: [
        //       isSelected
        //           ? BoxShadow(
        //               color: QuickyColors.primaryColor,
        //               spreadRadius: 1,
        //               blurRadius: 1,
        //               offset: Offset(0, 1),
        //             )
        //           : BoxShadow(
        //               color: Colors.grey.withOpacity(0.5),
        //               spreadRadius: 1,
        //               blurRadius: 1,
        //               offset: Offset(0, 1),
        //             )
        //     ]),
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     showImage
        //         ? Container(
        //             width: MediaQuery.of(context).size.width * 0.25,
        //             child: ClipRRect(
        //               borderRadius: BorderRadius.circular(10),
        //               child: Image(
        //                   height: 100,
        //                   width: 100,
        //                   fit: BoxFit.cover,
        //                   image: NetworkImage(
        //                       'https://images.prismic.io/getcircuit/e7817724-dae2-4ff5-937d-a789e8249bff_Header+%2867%29.jpg?auto=compress,format')),
        //             ),
        //           )
        //         : Container(),
        //     SizedBox(width: 5),
        //     Expanded(
        //       child: Container(
        //         padding: EdgeInsets.only(top: 10),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Text(
        //               coupon.name,
        //               overflow: TextOverflow.ellipsis,
        //               style: TextStyle(fontWeight: FontWeight.w700),
        //             ),
        //           ],
        //         ),
        //       ),
        //     )
        //   ],
        // ),
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
                image: NetworkImage(
                    'https://images.prismic.io/getcircuit/e7817724-dae2-4ff5-937d-a789e8249bff_Header+%2867%29.jpg?auto=compress,format')),
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
