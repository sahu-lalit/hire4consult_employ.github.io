// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyC4sMQy_T0NNsTVkd2mQItnioruTnN2ubc',
    appId: '1:263738459240:web:9fde3fa3405273116427dd',
    messagingSenderId: '263738459240',
    projectId: 'hire4consult-97b13',
    authDomain: 'hire4consult-97b13.firebaseapp.com',
    storageBucket: 'hire4consult-97b13.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAqNegZBvkJ5xr04ZXGRS_yUtihMrOO9IQ',
    appId: '1:263738459240:android:af6b78dcda73e5716427dd',
    messagingSenderId: '263738459240',
    projectId: 'hire4consult-97b13',
    storageBucket: 'hire4consult-97b13.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAK7Ts-q_exf6ufLnS6MW3QUOEvz9YJPvc',
    appId: '1:263738459240:ios:ae55c8c9dd8dffdd6427dd',
    messagingSenderId: '263738459240',
    projectId: 'hire4consult-97b13',
    storageBucket: 'hire4consult-97b13.firebasestorage.app',
    iosClientId: '263738459240-rotghps4au8l1ge2tspu3qd5o8v4cob7.apps.googleusercontent.com',
    iosBundleId: 'com.example.hire4consultEmploy',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAK7Ts-q_exf6ufLnS6MW3QUOEvz9YJPvc',
    appId: '1:263738459240:ios:ae55c8c9dd8dffdd6427dd',
    messagingSenderId: '263738459240',
    projectId: 'hire4consult-97b13',
    storageBucket: 'hire4consult-97b13.firebasestorage.app',
    iosClientId: '263738459240-rotghps4au8l1ge2tspu3qd5o8v4cob7.apps.googleusercontent.com',
    iosBundleId: 'com.example.hire4consultEmploy',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCU9ej8E2r0Czynap307wkhOIBNEJFPKgM',
    appId: '1:263738459240:web:52eaef8021e68a2e6427dd',
    messagingSenderId: '263738459240',
    projectId: 'hire4consult-97b13',
    authDomain: 'hire4consult-97b13.firebaseapp.com',
    storageBucket: 'hire4consult-97b13.firebasestorage.app',
  );
}
