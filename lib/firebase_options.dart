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
    apiKey: 'AIzaSyBU_QX1-WbXLThw3VA2FNSyrNh6AXg-Jrc',
    appId: '1:638839410015:web:fcb59075236f8011befaea',
    messagingSenderId: '638839410015',
    projectId: 'tokobuku-project',
    authDomain: 'tokobuku-project.firebaseapp.com',
    storageBucket: 'tokobuku-project.firebasestorage.app',
    measurementId: 'G-2Q52JGPBFN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB5-rZbbM27c2qBJFOXHa9UD3m9AidaVT0',
    appId: '1:638839410015:android:a5d597fe16588f04befaea',
    messagingSenderId: '638839410015',
    projectId: 'tokobuku-project',
    storageBucket: 'tokobuku-project.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAutD0l6RWd066vo_pc3YxuzfJR7CK2c0s',
    appId: '1:638839410015:ios:4a17c06724228807befaea',
    messagingSenderId: '638839410015',
    projectId: 'tokobuku-project',
    storageBucket: 'tokobuku-project.firebasestorage.app',
    iosBundleId: 'com.example.tokobukuonlineApk',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAutD0l6RWd066vo_pc3YxuzfJR7CK2c0s',
    appId: '1:638839410015:ios:4a17c06724228807befaea',
    messagingSenderId: '638839410015',
    projectId: 'tokobuku-project',
    storageBucket: 'tokobuku-project.firebasestorage.app',
    iosBundleId: 'com.example.tokobukuonlineApk',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBU_QX1-WbXLThw3VA2FNSyrNh6AXg-Jrc',
    appId: '1:638839410015:web:fddfdbac94525b52befaea',
    messagingSenderId: '638839410015',
    projectId: 'tokobuku-project',
    authDomain: 'tokobuku-project.firebaseapp.com',
    storageBucket: 'tokobuku-project.firebasestorage.app',
    measurementId: 'G-Q2SWVMJ5W0',
  );
}
