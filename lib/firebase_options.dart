// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBHWqefbNZtqajxnG9N1VDNnm6ywLitMaU',
    appId: '1:151057766591:web:dfe9fbf4d7023da2860e0a',
    messagingSenderId: '151057766591',
    projectId: 'quickyshop-7be38',
    authDomain: 'quickyshop-7be38.firebaseapp.com',
    storageBucket: 'quickyshop-7be38.appspot.com',
    measurementId: 'G-RGWBNCCQWM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCDbJ9DiZ8OJNT6taVvgzaaA0hlK1S_tT4',
    appId: '1:151057766591:android:f044ab25e72054a2860e0a',
    messagingSenderId: '151057766591',
    projectId: 'quickyshop-7be38',
    storageBucket: 'quickyshop-7be38.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBC2ZzvoMYojP0qHVtmXPp3pQB5-piFmqI',
    appId: '1:151057766591:ios:8cd3e5f32a409d57860e0a',
    messagingSenderId: '151057766591',
    projectId: 'quickyshop-7be38',
    storageBucket: 'quickyshop-7be38.appspot.com',
    iosClientId: '151057766591-ucqh61r6738dcpi2cahbkcdb9vm1nshr.apps.googleusercontent.com',
    iosBundleId: 'com.example.quickyshop',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBC2ZzvoMYojP0qHVtmXPp3pQB5-piFmqI',
    appId: '1:151057766591:ios:26bcb2281f267e17860e0a',
    messagingSenderId: '151057766591',
    projectId: 'quickyshop-7be38',
    storageBucket: 'quickyshop-7be38.appspot.com',
    iosClientId: '151057766591-2t84dfia9dp5e2qajoj160v1qbfov1s7.apps.googleusercontent.com',
    iosBundleId: 'com.example.quickyshop.RunnerTests',
  );
}
