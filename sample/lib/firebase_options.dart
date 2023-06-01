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
    apiKey: 'AIzaSyCI3Khb65mxrmPXcSwrpUHhoT2yZK3I5sY',
    appId: '1:577481271816:web:1ce114f7053d72a0f73fbd',
    messagingSenderId: '577481271816',
    projectId: 'hao-are-you',
    authDomain: 'hao-are-you.firebaseapp.com',
    storageBucket: 'hao-are-you.appspot.com',
    measurementId: 'G-FKC30L6TR4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAvdluvpX6jtUnzhg8DV-wiLMfqN6DBfBs',
    appId: '1:577481271816:android:d833b0058d35d98bf73fbd',
    messagingSenderId: '577481271816',
    projectId: 'hao-are-you',
    storageBucket: 'hao-are-you.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDZLJd_fO-jGl0wT2nw24bETmSe0wDtBGM',
    appId: '1:577481271816:ios:e8a41cbd1d8a81c7f73fbd',
    messagingSenderId: '577481271816',
    projectId: 'hao-are-you',
    storageBucket: 'hao-are-you.appspot.com',
    iosClientId: '577481271816-n4bjffjcbab7rflu4nb28f26v034onma.apps.googleusercontent.com',
    iosBundleId: 'com.example.sample',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDZLJd_fO-jGl0wT2nw24bETmSe0wDtBGM',
    appId: '1:577481271816:ios:91465f3265a48574f73fbd',
    messagingSenderId: '577481271816',
    projectId: 'hao-are-you',
    storageBucket: 'hao-are-you.appspot.com',
    iosClientId: '577481271816-in4hri5l7sktul70sf82e7nmhlotfk7q.apps.googleusercontent.com',
    iosBundleId: 'com.example.sample.RunnerTests',
  );
}