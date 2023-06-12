import 'package:flutter/material.dart';

import '../../services/storeService.dart';
import '../../utils/Colors.dart';
import '../../utils/general_methods.dart';
import '../../widgets/inputs/searchfield.dart';
import '../../widgets/scaffolds/authScaffold.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  StoreService _storeService = StoreService();
  @override
  Widget build(BuildContext context) {
    return QuickyAuthScaffold(
        currentScreenType: 'register',
        contentScreen: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
                padding: EdgeInsets.only(top: 120, left: 30, right: 30),
                child: Column(
                  children: [
                    Image(
                      height: 150,
                      width: 150,
                      image: AssetImage('assets/icons/brand/logo-quicky.png'),
                    ),
                    SizedBox(height: 40),
                    QuickyTextField(
                      isNumeric: true,
                      onChanged: (value) {},
                      hintText: 'Ingrese email',
                      prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: getCustomIconToTextFieldInPrefx(
                              'assets/icons/usability/mail.png')),
                    ),
                    SizedBox(height: 20),
                    QuickyTextField(
                      isNumeric: true,
                      onChanged: (value) {},
                      hintText: 'Ingrese email',
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
                          onPressed: () {
                            //_storeService.
                          },
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
