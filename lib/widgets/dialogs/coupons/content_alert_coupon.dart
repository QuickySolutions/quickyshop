import 'package:flutter/material.dart';
import 'package:quickyshop/widgets/dialogs/coupons/add.dart';
import 'package:quickyshop/widgets/dialogs/coupons/edit.dart';
import 'package:quickyshop/widgets/dialogs/stores/store_list.dart';

enum OperationType { add, edit, storeslist }

class ContentAlertCoupon extends StatelessWidget {
  final OperationType operationType;

  const ContentAlertCoupon({super.key, required this.operationType});

  @override
  Widget build(BuildContext context) {
    return renderContent();
  }

  Widget renderContent() {
    switch (operationType) {
      case OperationType.add:
        return AddCouponForm();
      case OperationType.edit:
        return EditCouponForm();
      case OperationType.storeslist:
        return StoreList();
      default:
        {
          return Container();
        }
    }
  }
}
