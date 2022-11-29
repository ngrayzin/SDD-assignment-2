import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flame/flame.dart'; // ADDED FLAME INTO DART FILE
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart'; // ADDED GOOGLE FONTS
import 'colours.dart' as colours;
import 'firebase_options.dart';
import 'leaderboard.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: colours.AppColor.background,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 80, top:10, right: 80, bottom: 20),
                  child: Image.asset("assets/images/logo.png"),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 45, top:20, right: 45, bottom: 20),
                  child: Image.asset("assets/images/name.png"),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: SizedBox(
                    width: 275,
                    child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(12)),
                          foregroundColor: MaterialStateProperty.all<Color>(colours.AppColor.background),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  side: BorderSide(color: colours.AppColor.main,width: 3)
                              )
                          )
                      ),

                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("START NEW GAME", style: TextStyle(fontSize: 32, color: Colors.white, fontFamily: 'StickNoBills')),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: SizedBox(
                    width: 275,
                    child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(12)),
                          foregroundColor: MaterialStateProperty.all<Color>(colours.AppColor.background),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  side: BorderSide(color: colours.AppColor.main,width: 3)
                              )
                          )
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("LOAD SAVE GAME", style: TextStyle(fontSize: 32, color: Colors.white, fontFamily: 'StickNoBills')),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: SizedBox(
                    width: 275,
                    child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(12)),
                          foregroundColor: MaterialStateProperty.all<Color>(colours.AppColor.background),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  side: BorderSide(color: colours.AppColor.main,width: 3)
                              )
                          )
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("LEADERBOARD", style: TextStyle(fontSize: 32, color: Colors.white, fontFamily: 'StickNoBills')),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    width: 275,
                    child: TextButton(
                      onPressed: () {SystemNavigator.pop();},
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(12)),
                          foregroundColor: MaterialStateProperty.all<Color>(colours.AppColor.background),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  side: BorderSide(color: colours.AppColor.main,width: 3)
                              )
                          )
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("EXIT GAME", style: TextStyle(fontSize: 32, color: Colors.white, fontFamily: 'StickNoBills')),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        )
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
          child: ElevatedButton(
        child: const Text('Open Route'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LeaderBoard()),
          );
        },
      )),
    );
  }
}
