import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/firebase/authentication.dart';
import 'package:quickyshop/providers/signup/signup_provider.dart';

import '../../utils/Colors.dart';
import '../../widgets/scaffolds/authScaffold.dart';

class PrincipalScreen extends StatefulWidget {
  const PrincipalScreen({super.key});

  @override
  State<PrincipalScreen> createState() => _PrincipalScreenState();
}

class _PrincipalScreenState extends State<PrincipalScreen> {
  AuthenticationService _authenticationService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    final _signUpProvider = Provider.of<SignUpProvider>(context);
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
                    onTap: () async {
                      final response =
                          await _authenticationService.signInWithFacebook();
                    },
                    child: Image(
                        height: 40,
                        width: 40,
                        image: AssetImage('assets/icons/auth/facebook.png')),
                  ),
                  GestureDetector(
                    onTap: () async {
                      try {
                        final response =
                            await _authenticationService.signInWithGoogle();
                        _signUpProvider
                            .setNameStore(response.user!.displayName!);
                        _signUpProvider.setEmailStore(response.user!.email!);
                        _signUpProvider
                            .setPhotoProfile(response.user!.photoURL!);
                        _signUpProvider.setSignedWithSocialMedia(true);

                        Navigator.pushNamed(context, '/send-code');
                      } catch (e) {
                        _signUpProvider.setSignedWithSocialMedia(false);
                      }
                    },
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
