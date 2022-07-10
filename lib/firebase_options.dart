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
    apiKey: 'AIzaSyDkEqS1F77hH40AjpojIEvj5Is13pGoQjI',
    appId: '1:750161154738:web:b91e350e13855b3175afab',
    messagingSenderId: '750161154738',
    projectId: 'topcontent-355516',
    authDomain: 'topcontent-355516.firebaseapp.com',
    storageBucket: 'topcontent-355516.appspot.com',
    measurementId: 'G-K8015ZYZB6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCxJcdNCyqOK456rfMYb6zWmUSTs-0pWJ0',
    appId: '1:750161154738:android:efdb97d30efbefc475afab',
    messagingSenderId: '750161154738',
    projectId: 'topcontent-355516',
    storageBucket: 'topcontent-355516.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA0IYlY28l3IZTeYkqCBohpzRzEse3gwkA',
    appId: '1:750161154738:ios:2dc201692408151175afab',
    messagingSenderId: '750161154738',
    projectId: 'topcontent-355516',
    storageBucket: 'topcontent-355516.appspot.com',
    iosClientId: '750161154738-ss3ejugfn0sk26m2h2o6vqfkci5g3chg.apps.googleusercontent.com',
    iosBundleId: 'com.example.topcontent',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA0IYlY28l3IZTeYkqCBohpzRzEse3gwkA',
    appId: '1:750161154738:ios:2dc201692408151175afab',
    messagingSenderId: '750161154738',
    projectId: 'topcontent-355516',
    storageBucket: 'topcontent-355516.appspot.com',
    iosClientId: '750161154738-ss3ejugfn0sk26m2h2o6vqfkci5g3chg.apps.googleusercontent.com',
    iosBundleId: 'com.example.topcontent',
  );
}
