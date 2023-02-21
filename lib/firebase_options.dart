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
    apiKey: 'AIzaSyCZ8Uj-VAQxAAYt7MmnT4lG3kWMxojPfGg',
    appId: '1:967796727639:web:79cfa2c4765e0647366812',
    messagingSenderId: '967796727639',
    projectId: 'selleramigo',
    authDomain: 'selleramigo.firebaseapp.com',
    storageBucket: 'selleramigo.appspot.com',
    measurementId: 'G-W7ZZYSNE54',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDJo9TLye6I9d6BUP6B3b0uDnKRQHguiHw',
    appId: '1:967796727639:android:82d6ed0e7fecfdde366812',
    messagingSenderId: '967796727639',
    projectId: 'selleramigo',
    storageBucket: 'selleramigo.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCa_XGshedvPMXyrFsTSDWEW-KPJG7hGm4',
    appId: '1:967796727639:ios:f949649ce4e55bf9366812',
    messagingSenderId: '967796727639',
    projectId: 'selleramigo',
    storageBucket: 'selleramigo.appspot.com',
    iosClientId: '967796727639-22akpj78gs1ino36sft46kncti5d4jgs.apps.googleusercontent.com',
    iosBundleId: 'com.example.selllerAmigoApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCa_XGshedvPMXyrFsTSDWEW-KPJG7hGm4',
    appId: '1:967796727639:ios:f949649ce4e55bf9366812',
    messagingSenderId: '967796727639',
    projectId: 'selleramigo',
    storageBucket: 'selleramigo.appspot.com',
    iosClientId: '967796727639-22akpj78gs1ino36sft46kncti5d4jgs.apps.googleusercontent.com',
    iosBundleId: 'com.example.selllerAmigoApp',
  );
}
