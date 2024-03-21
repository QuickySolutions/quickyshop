import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/providers/app/appProvider.dart';
import 'package:quickyshop/providers/auth/profileProvider.dart';
import 'package:quickyshop/utils/Colors.dart';
import 'package:quickyshop/widgets/inputs/quicky_textfield.dart';

class ChangePasswordForm extends StatelessWidget {
  const ChangePasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        GestureDetector(
          onTap: () {
            profileProvider.showChangePassword(false);
          },
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: QuickyColors.borderColor,
                borderRadius: BorderRadius.circular(50)),
            child: Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 20),
        QuickyTextField(
          defaultValue: appProvider.storeSelected.name,
          hintText: 'Nueva contraseña',
          onChanged: (String value) {
            profileProvider.onChangeName(value);
          },
        ),
      ]),
    );
  }
}
