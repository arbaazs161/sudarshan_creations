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
    apiKey: 'AIzaSyAyaiEjqyMKniCXtQQznVVoPw0hiBh4eQo',
    appId: '1:972816679519:web:fb2102c58b575f886d11ea',
    messagingSenderId: '972816679519',
    projectId: 'sudarshan-creations-c8748',
    authDomain: 'sudarshan-creations-c8748.firebaseapp.com',
    storageBucket: 'sudarshan-creations-c8748.appspot.com',
    measurementId: 'G-YGT89JWH1W',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAOw5uSqXpG5ODqMant-Ka5O5wylaCdPRk',
    appId: '1:972816679519:android:a585e14ceef3c8de6d11ea',
    messagingSenderId: '972816679519',
    projectId: 'sudarshan-creations-c8748',
    storageBucket: 'sudarshan-creations-c8748.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCShdgEOqMoZSmkAAzZYtQ2ANEfi8e7khU',
    appId: '1:972816679519:ios:dd20461e56baef4f6d11ea',
    messagingSenderId: '972816679519',
    projectId: 'sudarshan-creations-c8748',
    storageBucket: 'sudarshan-creations-c8748.appspot.com',
    iosBundleId: 'com.example.sudarshanCreations',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCShdgEOqMoZSmkAAzZYtQ2ANEfi8e7khU',
    appId: '1:972816679519:ios:dd20461e56baef4f6d11ea',
    messagingSenderId: '972816679519',
    projectId: 'sudarshan-creations-c8748',
    storageBucket: 'sudarshan-creations-c8748.appspot.com',
    iosBundleId: 'com.example.sudarshanCreations',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAyaiEjqyMKniCXtQQznVVoPw0hiBh4eQo',
    appId: '1:972816679519:web:2772339fa71f5a3e6d11ea',
    messagingSenderId: '972816679519',
    projectId: 'sudarshan-creations-c8748',
    authDomain: 'sudarshan-creations-c8748.firebaseapp.com',
    storageBucket: 'sudarshan-creations-c8748.appspot.com',
    measurementId: 'G-DDZTGGWYNJ',
  );
}