import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/firebase/authentication.dart';
import 'package:quickyshop/firebase_options.dart';

import 'providers/photo/photo_provider.dart';
import 'providers/signup/signup_provider.dart';
import 'providers/store/store_provider.dart';
import 'screens/auth/defineCategory.dart';
import 'screens/auth/loginScreen.dart';
import 'screens/auth/photoCommerce.dart';
import 'screens/auth/principal.dart';
import 'screens/auth/register.dart';
import 'screens/auth/sendCode.dart';
import 'screens/auth/verifyCode.dart';
import 'screens/home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignUpProvider()),
        ChangeNotifierProvider(create: (_) => PhotoProvider()),
        ChangeNotifierProvider(create: (_) => StoreProvider())
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const PrincipalScreen(),
          '/send-code': (context) => SendCodeScreen(),
          '/confirm-code': (context) => VerifyCodeScreen(),
          '/register': (context) => const RegisterScreen(),
          '/select/category': (context) => DefineCategoryScreen(),
          '/select/photo': (context) => DefinePhotoCommerceScreen(),
          '/login': (context) => const LoginScreen(),
          '/home': (context) => HomePage()
        },
      ),
    );
  }
}
