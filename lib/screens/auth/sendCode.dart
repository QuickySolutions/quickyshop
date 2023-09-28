import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/signup/signup_provider.dart';
import '../../services/storeService.dart';
import '../../utils/Colors.dart';
import '../../utils/general_methods.dart';
import '../../widgets/inputs/quicky_textfield.dart';
import '../../widgets/scaffolds/authScaffold.dart';

class SendCodeScreen extends StatefulWidget {
  const SendCodeScreen({super.key});

  @override
  State<SendCodeScreen> createState() => _SendCodeScreenState();
}

class _SendCodeScreenState extends State<SendCodeScreen> {
  late String numericPhone = "";
  StoreService _storeService = StoreService();
  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpProvider>(context);
    return QuickyAuthScaffold(
        currentScreenType: 'send-code',
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Text(
                        'Escribe tu número de teléfono, enviaremos un código de 4 dígitos para confirmar tu número telefónico.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 30),
                    QuickyTextField(
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        setState(() {
                          numericPhone = value;
                        });
                      },
                      hintText: 'Escribe numero telefonico',
                      prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: getCustomIconToTextFieldInPrefx(
                              'assets/icons/usability/cellphone.png')),
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
                          onPressed: () async {
                            // int min = 1000;
                            // int max = 9999;
                            // var randomizer = new Random();
                            // var code = min + randomizer.nextInt(max - min);

                            // var data = {
                            //   'cellphone': numericPhone,
                            //   'code': code
                            // };
                            // Map<String, dynamic> response = await _storeService
                            //     .verifyNumberStoreToSendSMS(data);

                            // if (!response['exist']) {
                            //   signUpProvider.setNumberCellPhone(numericPhone);
                            //   Navigator.pushNamed(context, '/confirm-code',
                            //       arguments: {'code': code});
                            // } else {
                            //   print('existe');
                            // }
                            Navigator.pushNamed(context, '/confirm-code',
                                arguments: {'code': 1234});
                          },
                          child: Text(
                            'Enviarme un codigo SMS',
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
