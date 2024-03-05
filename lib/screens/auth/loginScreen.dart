import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/models/Brand.dart';
import 'package:quickyshop/preferences/appPreferences.dart';
import 'package:quickyshop/providers/app/appProvider.dart';
import 'package:quickyshop/providers/auth/loginProvider.dart';
import '../../utils/Colors.dart';
import '../../utils/general_methods.dart';
import '../../widgets/inputs/quicky_textfield.dart';
import '../../widgets/scaffolds/authScaffold.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);
    return QuickyAuthScaffold(
        currentScreenType: 'register',
        contentScreen: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
                child: Column(
              children: [
                Image(
                  height: 150,
                  width: 150,
                  image: AssetImage('assets/icons/brand/logo-quicky.png'),
                ),
                SizedBox(height: 40),
                QuickyTextField(
                  onChanged: (value) {
                    loginProvider.onChangeEmail(value);
                  },
                  hintText: 'Ingrese email',
                  prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: getCustomIconToTextFieldInPrefx(
                          'assets/icons/usability/mail.png')),
                ),
                SizedBox(height: 20),
                QuickyTextField(
                  onChanged: (value) {
                    loginProvider.onChangePassword(value);
                  },
                  hintText: 'Ingrese contraseña',
                  hideText: true,
                  prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: getCustomIconToTextFieldInPrefx(
                          'assets/icons/usability/key.png')),
                ),
                SizedBox(height: 20),
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: QuickyColors.secondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      onPressed: loginProvider.isValidForm
                          ? () async {
                              var responseLogin = await loginProvider.login();

                              if (responseLogin.from == 'brand') {
                                AppPreferences()
                                    .setIdBrand(responseLogin.data['_id']);
                                //set providers to brand
                                appProvider.setDefaultBrand(responseLogin.data);

                                Navigator.pushNamedAndRemoveUntil(
                                    context, "/base", (r) => false);
                              } else {
                                AppPreferences()
                                    .setIdStore(responseLogin.data['_id']);

                                appProvider.setDefaultStore(responseLogin.data);

                                Navigator.pushNamedAndRemoveUntil(
                                    context, "/base", (r) => false);
                              }
                            }
                          : null,
                      child: Text(
                        'Iniciar sesión',
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      )),
                ),
              ],
            ))));
  }
}
