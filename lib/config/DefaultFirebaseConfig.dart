import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions? get platformOptions {
    
      // Web
      return const FirebaseOptions(
        apiKey: 'AIzaSyDkEqS1F77hH40AjpojIEvj5Is13pGoQjI',
        authDomain: 'topcontent-355516.firebaseapp.com',
        projectId: 'topcontent-355516',
        storageBucket: 'topcontent-355516.appspot.com',
        messagingSenderId: '750161154738',
        appId: '1:750161154738:web:07aaae8ef9524c8875afab',
        measurementId: 'G-KGCF548KCF',
      );
    } 
    }
  
