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
    apiKey: 'AIzaSyBp58rvj7QtKwHIb0Z-z-njYVyxo_h6s24',
    appId: '1:79433948811:web:97925f77675933f9567e8e',
    messagingSenderId: '79433948811',
    projectId: 'e-com-f7e81',
    authDomain: 'e-com-f7e81.firebaseapp.com',
    storageBucket: 'e-com-f7e81.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBlnjkuxvqE4u6GAhO9jXDVsK3PVBSknO0',
    appId: '1:79433948811:android:de1bf8e400adbb00567e8e',
    messagingSenderId: '79433948811',
    projectId: 'e-com-f7e81',
    storageBucket: 'e-com-f7e81.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDSbUIq2rJqvxDh-h7Mv3Jwargl7IU2F9A',
    appId: '1:79433948811:ios:f05ce2d39f4366a2567e8e',
    messagingSenderId: '79433948811',
    projectId: 'e-com-f7e81',
    storageBucket: 'e-com-f7e81.appspot.com',
    iosBundleId: 'com.example.ecom',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDSbUIq2rJqvxDh-h7Mv3Jwargl7IU2F9A',
    appId: '1:79433948811:ios:b87d1c12c1e26624567e8e',
    messagingSenderId: '79433948811',
    projectId: 'e-com-f7e81',
    storageBucket: 'e-com-f7e81.appspot.com',
    iosBundleId: 'com.example.ecom.RunnerTests',
  );
}