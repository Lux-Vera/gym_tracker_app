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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAdVE9QwvJdU4gepJ50-LfOu65xrcZ1R_c',
    appId: '1:310248746121:web:efaf1e929f98c75f1d6a58',
    messagingSenderId: '310248746121',
    projectId: 'gym-tracker-app-2ac61',
    authDomain: 'gym-tracker-app-2ac61.firebaseapp.com',
    databaseURL: 'https://gym-tracker-app-2ac61-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'gym-tracker-app-2ac61.appspot.com',
    measurementId: 'G-Q47EBX5FNX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDRmxtta0em8L9MrQpWTLaDsXjun7xIe7U',
    appId: '1:310248746121:android:b460b122ec37e3b81d6a58',
    messagingSenderId: '310248746121',
    projectId: 'gym-tracker-app-2ac61',
    databaseURL: 'https://gym-tracker-app-2ac61-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'gym-tracker-app-2ac61.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCSRCuprCOAPS7pNW6YZMNSMddxaJAI_Ec',
    appId: '1:310248746121:ios:c6bdc53dbfb599e71d6a58',
    messagingSenderId: '310248746121',
    projectId: 'gym-tracker-app-2ac61',
    databaseURL: 'https://gym-tracker-app-2ac61-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'gym-tracker-app-2ac61.appspot.com',
    iosBundleId: 'com.example.gymTrackerApp',
  );
}
