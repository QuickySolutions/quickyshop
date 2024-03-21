import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/firebase/authentication.dart';
import 'package:quickyshop/preferences/appPreferences.dart';
import 'package:quickyshop/providers/signup/signup_provider.dart';
import 'package:quickyshop/services/authService.dart';

import '../../utils/Colors.dart';
import '../../widgets/scaffolds/authScaffold.dart';

class PrincipalScreen extends StatefulWidget {
  const PrincipalScreen({super.key});

  @override
  State<PrincipalScreen> createState() => _PrincipalScreenState();
}

class _PrincipalScreenState extends State<PrincipalScreen> {
  final AuthenticationService _authenticationService = AuthenticationService();
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpProvider>(context);
    return QuickyAuthScaffold(
      currentScreenType: 'principal',
      contentScreen: Container(
        padding: const EdgeInsets.only(top: 120),
        width: double.infinity,
        child: Column(
          children: [
            Image(
              height: 200,
              width: 200,
              image: AssetImage('assets/icons/brand/quiky.png'),
            ),
            Text(
              'COMERCIO',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
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
            SizedBox(height: 15),
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
            SizedBox(height: 15),
            Image(
                width: MediaQuery.of(context).size.width * 0.65,
                image: AssetImage('assets/utils/borderPrincipal.png')),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      final googleResponse =
                          await _authenticationService.signInWithGoogle();

                      try {
                        AuthResponse response = await _authService.login(
                            email: googleResponse.user!.email);
                        if (response.from == 'brand') {
                          AppPreferences().setIdBrand(response.data['_id']);
                        } else {
                          AppPreferences().setIdStore(response.data['_id']);
                        }

                        Navigator.pushReplacementNamed(context, '/base');
                      } catch (e) {
                        signUpProvider
                            .setNameStore(googleResponse.user!.displayName!);
                        signUpProvider
                            .setEmailStore(googleResponse.user!.email!);
                        signUpProvider
                            .setPhotoProfile(googleResponse.user!.photoURL!);
                        signUpProvider.setSignedWithSocialMedia(true);
                        Navigator.pushNamed(context, '/send-code');
                      }
                    },
                    child: Image(
                        height: 40,
                        width: 40,
                        image: AssetImage('assets/icons/auth/google.png')),
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
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
