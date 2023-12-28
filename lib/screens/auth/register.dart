import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/providers/app/appProvider.dart';

import '../../providers/signup/signup_provider.dart';
import '../../utils/Colors.dart';
import '../../utils/general_methods.dart';
import '../../widgets/inputs/quicky_textfield.dart';
import '../../widgets/scaffolds/authScaffold.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool wantToSeePassword = false;
  bool wantToSeePassword2 = false;

  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);

    return QuickyAuthScaffold(
      currentScreenType: 'register',
      contentScreen: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 120, left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image(
                  height: 180,
                  width: 180,
                  image: AssetImage('assets/icons/brand/logo-quicky.png'),
                ),
              ),
              SizedBox(height: 40),
              QuickyTextField(
                defaultValue: signUpProvider.storeName,
                hintText: 'Nombre de Tienda',
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: getCustomIconToTextFieldInPrefx(
                      'assets/icons/usability/person.png'),
                ),
                onChanged: (String value) {
                  signUpProvider.setNameStore(value);
                },
              ),
              SizedBox(height: 15),
              QuickyTextField(
                hintText: 'Correo de Tienda',
                defaultValue: signUpProvider.emailStore,
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: getCustomIconToTextFieldInPrefx(
                      'assets/icons/usability/mail.png'),
                ),
                onChanged: (String value) {
                  signUpProvider.setEmailStore(value);
                },
              ),
              SizedBox(height: 15),
              QuickyTextField(
                hintText: 'Ubicación',
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: getCustomIconToTextFieldInPrefx(
                      'assets/icons/usability/home.png'),
                ),
                onChanged: (String value) {
                  signUpProvider.setLocation(value);
                },
              ),
              SizedBox(height: 15),
              !signUpProvider.isSignedWithSocialMedia
                  ? Column(
                      children: [
                        QuickyTextField(
                          hintText: 'Contraseña',
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: getCustomIconToTextFieldInPrefx(
                                'assets/icons/usability/key.png'),
                          ),
                          hideText: true,
                          onChanged: (String value) {
                            signUpProvider.setPasswordStore(value);
                          },
                        ),
                        SizedBox(height: 15),
                        QuickyTextField(
                          hintText: 'Confirmar contraseña',
                          hideText: true,
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: getCustomIconToTextFieldInPrefx(
                                'assets/icons/usability/key.png'),
                          ),
                          onChanged: (String value) {
                            signUpProvider.setPasswordConfirmStore(value);
                          },
                        ),
                      ],
                    )
                  : Container(),
              appProvider.wantToAddNewStore
                  ? Column(
                      children: [
                        QuickyTextField(
                          hintText: 'Contraseña',
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: getCustomIconToTextFieldInPrefx(
                                'assets/icons/usability/key.png'),
                          ),
                          hideText: true,
                          onChanged: (String value) {
                            signUpProvider.setPasswordStore(value);
                          },
                        ),
                        SizedBox(height: 15),
                        QuickyTextField(
                          hintText: 'Confirmar contraseña',
                          hideText: true,
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: getCustomIconToTextFieldInPrefx(
                                'assets/icons/usability/key.png'),
                          ),
                          onChanged: (String value) {
                            signUpProvider.setPasswordConfirmStore(value);
                          },
                        ),
                      ],
                    )
                  : Container(),
              SizedBox(height: 30),
              Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: QuickyColors.secondaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          onPressed: () async {
                            if (appProvider.wantToAddNewStore) {
                              Navigator.pushNamed(context, '/select/photo');
                            } else {
                              Navigator.pushNamed(context, '/select/category');
                            }
                          },
                          child: Text(
                            'Registrarse',
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          )),
                    ),
                    SizedBox(height: 20),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: GestureDetector(
                          onTap: () async {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Atras',
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          )),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                          text: 'Al registrarte aceptas nuestros',
                          style: TextStyle(color: Colors.black, fontSize: 12)),
                      TextSpan(
                          text:
                              ' términos de servicio y política de privacidad',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline))
                    ]),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
