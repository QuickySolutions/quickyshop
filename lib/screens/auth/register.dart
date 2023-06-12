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
              TextField(
                onChanged: (value) {
                  signUpProvider.setEmailStore(value);
                },
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.black),
                  prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: getCustomIconToTextFieldInPrefx(
                          'assets/icons/usability/mail.png')),
                  hintText: 'Correo electrónico',
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                obscureText: wantToSeePassword ? false : true,
                onChanged: (value) {
                  signUpProvider.setPasswordStore(value);
                },
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.black),
                  prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: getCustomIconToTextFieldInPrefx(
                          'assets/icons/usability/key.png')),
                  suffixIcon: !wantToSeePassword
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              wantToSeePassword = !wantToSeePassword;
                            });
                          },
                          child: Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Icon(Icons.remove_red_eye)),
                        )
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              wantToSeePassword = !wantToSeePassword;
                            });
                          },
                          child: Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Icon(Icons.visibility_off)),
                        ),
                  hintText: 'Contraseña',
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              SizedBox(height: 15),
              // TextField(
              //   obscureText: wantToSeePassword2 ? false : true,
              //   onChanged: (value) {
              //     setState(() {
              //       _secondPassword = value;
              //     });
              //   },
              //   decoration: InputDecoration(
              //     hintStyle: TextStyle(color: Colors.black),
              //     prefixIcon: Padding(
              //         padding: EdgeInsets.only(left: 10),
              //         child: getCustomIconToTextFieldInPrefx(
              //             'assets/icons/usability/key.png')),
              //     suffixIcon: !wantToSeePassword2
              //         ? GestureDetector(
              //             onTap: () {
              //               setState(() {
              //                 wantToSeePassword2 = !wantToSeePassword2;
              //               });
              //             },
              //             child: Padding(
              //                 padding: EdgeInsets.only(right: 10),
              //                 child: Icon(Icons.remove_red_eye)),
              //           )
              //         : GestureDetector(
              //             onTap: () {},
              //             child: Padding(
              //                 padding: EdgeInsets.only(right: 10),
              //                 child: Icon(Icons.visibility_off)),
              //           ),
              //     hintText: 'Confirmar contraseña',
              //     filled: true,
              //     border: OutlineInputBorder(
              //       borderSide: BorderSide.none,
              //       borderRadius: BorderRadius.circular(50),
              //     ),
              //   ),
              // ),
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
