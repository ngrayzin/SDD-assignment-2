import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flame/flame.dart'; // ADDED FLAME INTO DART FILE
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart'; // ADDED GOOGLE FONTS
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sdd_assignment_2/Player.dart';
import 'Login.dart';
import 'MainMenu.dart';
import 'colours.dart' as colours;
import 'Firebase_options.dart';
import 'package:flutter/services.dart';
//import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "sdd-assignment-2",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
  //WidgetsFlutterBinding.ensureInitialized();
  /*SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive,
      overlays: [SystemUiOverlay.bottom]);*/
}

class MyApp extends StatelessWidget {
  static var currentUser = FirebaseAuth.instance.currentUser;
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //primarySwatch: Colors.blue,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      home: landingPage() ? const MainMenu() : const Login(),
    );
  }
}

bool landingPage(){
  if (MyApp.currentUser != null) {
    print(MyApp.currentUser?.uid);
    print("fuck");
    return true;
  }
  else{
    print("fuckfuck");
    return false;
  }
}

/*Future<void> _handleStartScreen() async {
  Auth _auth = Auth();
  if (await _auth.isLoggedIn()) {
    Navigator.of(context).pushReplacementNamed("/chat");
  }
  else {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LoginScreen(auth: _auth,)));
  }
}*/



