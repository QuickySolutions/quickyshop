import 'package:flutter/material.dart';
import 'package:quickyshop/widgets/dialogs/QuickyAlertDialog.dart';

void showErrorMessage(String error, BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return QuickyAlertDialog(
          size: 'xs-small',
          childContent: Column(
            children: [
              Text(error,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w800))
            ],
          ),
        );
      });
}
