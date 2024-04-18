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
    apiKey: 'AIzaSyDmiqt0qcRDRUt_w8H93YP1qWVprI8uaz8',
    appId: '1:1082039586801:web:9b1009ad2d24f966327e50',
    messagingSenderId: '1082039586801',
    projectId: 'dreamsaver-project',
    authDomain: 'dreamsaver-project.firebaseapp.com',
    storageBucket: 'dreamsaver-project.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDim8sebqGKzMD_97N4_X7v_3bwSbejA2I',
    appId: '1:1082039586801:android:52146d260817e22c327e50',
    messagingSenderId: '1082039586801',
    projectId: 'dreamsaver-project',
    storageBucket: 'dreamsaver-project.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCGFuGtOyAjHj3PTddTWFM4xtXTux0QeXM',
    appId: '1:1082039586801:ios:2ce3d8374c51f366327e50',
    messagingSenderId: '1082039586801',
    projectId: 'dreamsaver-project',
    storageBucket: 'dreamsaver-project.appspot.com',
    iosBundleId: 'com.example.dreamsaver',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCGFuGtOyAjHj3PTddTWFM4xtXTux0QeXM',
    appId: '1:1082039586801:ios:2ce3d8374c51f366327e50',
    messagingSenderId: '1082039586801',
    projectId: 'dreamsaver-project',
    storageBucket: 'dreamsaver-project.appspot.com',
    iosBundleId: 'com.example.dreamsaver',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDmiqt0qcRDRUt_w8H93YP1qWVprI8uaz8',
    appId: '1:1082039586801:web:4aaf3dfa979a1103327e50',
    messagingSenderId: '1082039586801',
    projectId: 'dreamsaver-project',
    authDomain: 'dreamsaver-project.firebaseapp.com',
    storageBucket: 'dreamsaver-project.appspot.com',
  );
}
