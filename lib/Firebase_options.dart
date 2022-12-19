// TODO Implement this library.
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'firebase_options.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
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
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAFBzqqUDBSicgCViM1PzCRjX8Y739eBUI',
    appId: '1:797884859033:android:352af6d6c140f45f71ae08',
    messagingSenderId: '797884859033',
    projectId: 'sdd-assignment-2',
  );
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAFBzqqUDBSicgCViM1PzCRjX8Y739eBUI',
    appId: '1:797884859033:ios:600da01a783a495371ae08',
    messagingSenderId: '797884859033',
    projectId: 'sdd-assignment-2',
    iosBundleId: 'org.sddassignment.firebase',
  );
}