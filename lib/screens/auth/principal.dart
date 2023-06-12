import 'package:flutter/material.dart';

import '../../utils/Colors.dart';
import '../../widgets/scaffolds/authScaffold.dart';

class PrincipalScreen extends StatefulWidget {
  const PrincipalScreen({super.key});

  @override
  State<PrincipalScreen> createState() => _PrincipalScreenState();
}

class _PrincipalScreenState extends State<PrincipalScreen> {
  @override
  Widget build(BuildContext context) {
    return QuickyAuthScaffold(
      currentScreenType: 'principal',
      contentScreen: Container(
        margin: EdgeInsets.only(
          top: 40,
        ),
        width: double.infinity,
        padding: EdgeInsets.only(top: 70, left: 30, right: 30),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 80),
              child: Image(
                height: 180,
                width: 180,
                image: AssetImage('assets/icons/brand/quiky.png'),
              ),
            ),
            Text(
              'COMERCIO',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            Container(
              height: 65,
              width: MediaQuery.of(context).size.width * 0.65,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: QuickyColors.secondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/send-code');
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
              height: 65,
              width: MediaQuery.of(context).size.width * 0.65,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text(
                    'Iniciar sesión',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  )),
            ),
            SizedBox(height: 20),
            Image(
                width: MediaQuery.of(context).size.width * 0.65,
                image: AssetImage('assets/utils/borderPrincipal.png')),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Image(
                        height: 40,
                        width: 40,
                        image: AssetImage('assets/icons/auth/facebook.png')),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Image(
                        height: 40,
                        width: 40,
                        image: AssetImage('assets/icons/auth/google.png')),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Image(
                        height: 40,
                        width: 40,
                        image: AssetImage('assets/icons/auth/twitter.png')),
                  ),
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
                        text: ' términos de servicio y política de privacidad',
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
    );
  }
}
