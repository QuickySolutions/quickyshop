import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/signup/signup_provider.dart';
import '../../utils/Colors.dart';
import '../../utils/general_methods.dart';
import '../../widgets/inputs/searchfield.dart';
import '../../widgets/scaffolds/authScaffold.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //String _secondPassword = "";
  bool wantToSeePassword = false;
  bool wantToSeePassword2 = false;

  final TextEditingController _nameStoreController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpProvider>(context);

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
                hintText: 'Nombre completo',
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
                defaultValue: signUpProvider.emailStore,
                hintText: 'Correo Electronico',
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: getCustomIconToTextFieldInPrefx(
                      'assets/icons/usability/mail.png'),
                ),
                onChanged: (String value) {
                  signUpProvider.setNameStore(value);
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
                          onChanged: (String value) {},
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
                          onChanged: (String value) {},
                        ),
                      ],
                    )
                  : Container(),
              SizedBox(height: 30),
              Center(
                child: Container(
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
                        Navigator.pushNamed(context, '/select/category');
                      },
                      child: Text(
                        'Registrarse',
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      )),
                ),
              ),
              SizedBox(height: 30),
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
