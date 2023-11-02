import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/firebase_options.dart';
import 'package:quickyshop/preferences/appPreferences.dart';
import 'package:quickyshop/providers/app/appProvider.dart';
import 'package:quickyshop/providers/auth/loginProvider.dart';
import 'package:quickyshop/providers/auth/profileProvider.dart';
import 'package:quickyshop/providers/coupons/coupon_provider.dart';
import 'package:quickyshop/providers/statistics/statisticsProvider.dart';
import 'package:quickyshop/providers/survey/survey_provider.dart';
import 'package:quickyshop/screens/QR/QR_view.dart';
import 'package:quickyshop/screens/coupons/coupons-list.dart';
import 'package:quickyshop/screens/home/base.dart';
import 'package:quickyshop/screens/profile/profile.dart';
import 'package:quickyshop/screens/statistics/statisticsScreen.dart';
import 'package:quickyshop/screens/statistics/surveyStatistic.dart';
import 'package:quickyshop/screens/surveys/create_survey_screen.dart';
import 'package:quickyshop/screens/surveys/survey_list_screen.dart';

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
  await AppPreferences().initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");
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
        ChangeNotifierProvider(create: (_) => StoreProvider()),
        ChangeNotifierProvider(create: (_) => CouponProvider()),
        ChangeNotifierProvider(create: (_) => SurveyProvider()),
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => StatisticProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: AppPreferences().brandId.isNotEmpty ||
                AppPreferences().storeId.isNotEmpty
            ? '/base'
            : '/',
        routes: {
          '/': (context) => const PrincipalScreen(),
          '/send-code': (context) => SendCodeScreen(),
          '/confirm-code': (context) => VerifyCodeScreen(),
          '/register': (context) => const RegisterScreen(),
          '/select/category': (context) => DefineCategoryScreen(),
          '/select/photo': (context) => DefinePhotoCommerceScreen(),
          '/login': (context) => const LoginScreen(),
          '/base': (context) => BaseHomePage(),
          '/home': (context) => HomePage(),
          '/coupons': (context) => CouponsListScreeen(),
          '/profile': (context) => ProfileScreen(),
          '/profile/statistics': (context) => StatisticsScreen(),
          '/survey/stadistic': (context) => SurveyStatistic(),
          '/surveys': (context) => SurveyListScreen(),
          '/create/survey': (context) => CreateSurveyScreen(),
          '/qr': (context) => QRViewScreen(),
        },
      ),
    );
  }
}
