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
    apiKey: 'AIzaSyDwGXDF5XZFnYdpW5MeOvrtorwLZrVXF04',
    appId: '1:350419762712:web:51985df7e6b2aa0ab28d6d',
    messagingSenderId: '350419762712',
    projectId: 'route-search-3976b',
    authDomain: 'route-search-3976b.firebaseapp.com',
    databaseURL: 'https://route-search-3976b-default-rtdb.firebaseio.com',
    storageBucket: 'route-search-3976b.appspot.com',
    measurementId: 'G-W0M907Q8K6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBRDOt-SIyu8PjrFVukJEyrmhk6m_-InbQ',
    appId: '1:350419762712:android:961e9d3cef87675ab28d6d',
    messagingSenderId: '350419762712',
    projectId: 'route-search-3976b',
    databaseURL: 'https://route-search-3976b-default-rtdb.firebaseio.com',
    storageBucket: 'route-search-3976b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCeMY0p5nRmTgqvmYx7zawYZnoGa6zZKQw',
    appId: '1:350419762712:ios:7c060c2c1c492c9ab28d6d',
    messagingSenderId: '350419762712',
    projectId: 'route-search-3976b',
    databaseURL: 'https://route-search-3976b-default-rtdb.firebaseio.com',
    storageBucket: 'route-search-3976b.appspot.com',
    iosBundleId: 'com.example.routeSearch',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCeMY0p5nRmTgqvmYx7zawYZnoGa6zZKQw',
    appId: '1:350419762712:ios:7c060c2c1c492c9ab28d6d',
    messagingSenderId: '350419762712',
    projectId: 'route-search-3976b',
    databaseURL: 'https://route-search-3976b-default-rtdb.firebaseio.com',
    storageBucket: 'route-search-3976b.appspot.com',
    iosBundleId: 'com.example.routeSearch',
  );
}