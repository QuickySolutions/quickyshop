import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/providers/app/appProvider.dart';
import 'package:quickyshop/providers/auth/profileProvider.dart';
import 'package:quickyshop/utils/Colors.dart';
import 'package:quickyshop/widgets/inputs/quicky_textfield.dart';

class EditProfileForm extends StatelessWidget {
  const EditProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Container(
      child: appProvider.hasSelectedBrand
          ? Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Rellene los campos',
                        style: TextStyle(fontSize: 20),
                      ),
                      GestureDetector(
                        onTap: () {
                          profileProvider.showFormProfile(false);
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
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                QuickyTextField(
                  defaultValue: appProvider.brandDefault.name,
                  hintText: 'Nombre de subtienda',
                  onChanged: (String value) {
                    profileProvider.onChangeName(value);
                  },
                ),
                SizedBox(height: 20),
                QuickyTextField(
                  defaultValue: appProvider.brandDefault.email,
                  hintText: 'Correo de subtienda',
                  onChanged: (String value) {
                    profileProvider.onChangeEmail(value);
                  },
                ),
                SizedBox(height: 20),
                QuickyTextField(
                  defaultValue: appProvider.brandDefault.cellphone,
                  hintText: 'Telefono de subtienda',
                  onChanged: (String value) {
                    profileProvider.onChangeCellPhone(value);
                  },
                )
              ],
            )
          : Column(
              children: [
                QuickyTextField(
                  defaultValue: appProvider.storeSelected.name,
                  hintText: 'Nombre de tienda',
                  onChanged: (String value) {
                    profileProvider.onChangeName(value);
                  },
                ),
                SizedBox(height: 20),
                QuickyTextField(
                  defaultValue: appProvider.storeSelected.location,
                  hintText: 'Ubicación de tienda',
                  onChanged: (String value) {
                    profileProvider.onChangeLocation(value);
                  },
                ),
                SizedBox(height: 20),
                QuickyTextField(
                  defaultValue: appProvider.storeSelected.email,
                  hintText: 'Correo de tienda',
                  onChanged: (String value) {
                    profileProvider.onChangeEmail(value);
                  },
                )
              ],
            ),
    );
  }
}
