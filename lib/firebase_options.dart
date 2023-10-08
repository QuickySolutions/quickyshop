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
    apiKey: 'AIzaSyA_B_5geLZKqm46Nm6vMNlthrQRhzO6beU',
    appId: '1:359622514274:web:e93649e93e4136e71ba33b',
    messagingSenderId: '359622514274',
    projectId: 'quicky-398020',
    authDomain: 'quicky-398020.firebaseapp.com',
    storageBucket: 'quicky-398020.appspot.com',
    measurementId: 'G-1XRZ66DC2S',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCJNQunn2dzN_62P8JarXRVC9XdwTUY2To',
    appId: '1:359622514274:android:a7de630124a999171ba33b',
    messagingSenderId: '359622514274',
    projectId: 'quicky-398020',
    storageBucket: 'quicky-398020.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB4KJ_gRIuPTrwZrT8mISrmjH-GC0M4XpI',
    appId: '1:359622514274:ios:a60c3d1a13373d3e1ba33b',
    messagingSenderId: '359622514274',
    projectId: 'quicky-398020',
    storageBucket: 'quicky-398020.appspot.com',
    iosClientId: '359622514274-0sbf2pnp1t8k36b1f4nanbs9a1i07957.apps.googleusercontent.com',
    iosBundleId: 'quickyshop.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB4KJ_gRIuPTrwZrT8mISrmjH-GC0M4XpI',
    appId: '1:359622514274:ios:bf959ead0e633b9e1ba33b',
    messagingSenderId: '359622514274',
    projectId: 'quicky-398020',
    storageBucket: 'quicky-398020.appspot.com',
    iosClientId: '359622514274-o07bm21qopsnf255er8okhgr9r5smr7e.apps.googleusercontent.com',
    iosBundleId: 'com.example.quickyshop.RunnerTests',
  );
}
