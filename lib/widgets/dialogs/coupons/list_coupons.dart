import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/providers/coupons/coupon_provider.dart';
import 'package:quickyshop/utils/Colors.dart';
import 'package:quickyshop/widgets/coupons/coupon_mini_card.dart';
import 'package:quickyshop/widgets/dialogs/QuickyAlertDialog.dart';

class CouponList extends StatefulWidget {
  @override
  State<CouponList> createState() => _CouponListState();
}

class _CouponListState extends State<CouponList> {
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
    final couponProvider = Provider.of<CouponProvider>(context);
    return Consumer<CouponProvider>(builder: (context, data, child) {
      return data.isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: QuickyColors.primaryColor,
              ),
            )
          : data.couponsList.isEmpty
              ? Center(
                  child: Text('No hay datos'),
                )
              : ListView.builder(
                  padding: EdgeInsets.only(top: 10, left: 5, right: 5),
                  itemCount: data.couponsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      margin: EdgeInsets.only(bottom: 20),
                      child: CouponMiniCard(
                          isSelected: couponProvider.selectedCoupon.id ==
                              data.couponsList[index].id,
                          showImage: false,
                          onTap: () {
                            couponProvider
                                .selectCoupon(data.couponsList[index]);

                            Navigator.pop(context);
                          },
                          coupon: data.couponsList[index]),
                    );
                  },
                );
    });
  }
}
