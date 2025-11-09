import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
      if (kIsWeb) {
          return FirebaseOptions(
              apiKey: "AIzaSyBJFuRSeK5AAcWXxC0xZLhOCYCMe7Nh6NU",
              authDomain: "rpg-builder-b95b4.firebaseapp.com",
              projectId: "rpg-builder-b95b4",
              storageBucket: "rpg-builder-b95b4.firebasestorage.app",
              messagingSenderId: "164452977417",
              appId: "1:164452977417:web:85b9dac333220c8e2d21d8"
          );
      }

      switch (defaultTargetPlatform) {
          case TargetPlatform.android:
              return FirebaseOptions(
                  apiKey: 'AIzaSyBJFuRSeK5AAcWXxC0xZLhOCYCMe7Nh6NU',
                  appId: '1:164452977417:web:85b9dac333220c8e2d21d8',
                  messagingSenderId: '164452977417',
                  projectId: 'rpg-builder-b95b4',
              );
          case TargetPlatform.iOS:
              return FirebaseOptions(
                  apiKey: 'AIzaSyBJFuRSeK5AAcWXxC0xZLhOCYCMe7Nh6NU',
                  appId: '1:164452977417:web:85b9dac333220c8e2d21d8',
                  messagingSenderId: '164452977417',
                  projectId: 'rpg-builder-b95b4',
              );
          default: 
              return FirebaseOptions (
                  apiKey: 'AIzaSyBJFuRSeK5AAcWXxC0xZLhOCYCMe7Nh6NU',
                  appId: '1:164452977417:web:85b9dac333220c8e2d21d8',
                  messagingSenderId: '164452977417',
                  projectId: 'rpg-builder-b95b4',
              );
        }
        
  }
  
}
