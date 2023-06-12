import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../utils/Colors.dart';
import '../../widgets/scaffolds/authScaffold.dart';

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({super.key});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  int code = 0;
  @override
  Widget build(BuildContext context) {
    return QuickyAuthScaffold(
        currentScreenType: 'verify-code',
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
                    SizedBox(height: 40),
                    PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 4,
                      obscureText: true,
                      obscuringCharacter: '*',
                      blinkWhenObscuring: true,
                      enableActiveFill: true,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        activeColor: Colors.white,
                        selectedFillColor: Colors.white,
                        selectedColor: QuickyColors.primaryColor,
                        inactiveFillColor: Colors.grey.shade300,
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 70,
                        fieldWidth: 70,
                        activeFillColor: Colors.white,
                      ),
                      cursorColor: Colors.black,
                      validator: (v) {
                        if (v!.length < 3) {
                          return "I'm from validator";
                        } else {
                          return null;
                        }
                      },
                      animationDuration: const Duration(milliseconds: 300),
                      keyboardType: TextInputType.number,
                      boxShadows: const [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],
                      onCompleted: (v) {
                        debugPrint("Completed");
                      },
                      onChanged: (value) {
                        debugPrint(value);
                      },
                      beforeTextPaste: (text) {
                        debugPrint("Allowing to paste $text");
                        return true;
                      },
                    ),
                    SizedBox(height: 30),
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
                          onPressed: () {},
                          child: Text(
                            'Enviar codigo otra vez',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w700),
                          )),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: QuickyColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: Text(
                            'Continuar',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w700),
                          )),
                    ),
                  ],
                ))));
  }
}
