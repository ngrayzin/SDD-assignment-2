import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flame/flame.dart'; // ADDED FLAME INTO DART FILE
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart'; // ADDED GOOGLE FONTS
import 'colours.dart' as colours;
import 'firebase_options.dart';

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
                  padding: const EdgeInsets.only(
                      left: 90, top: 10, right: 90, bottom: 20),
                  child: Image.asset("assets/images/logo.png"),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 50, top: 20, right: 50, bottom: 20),
                  child: Image.asset("assets/images/name.png"),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: SizedBox(
                    width: 275,
                    child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.all(15)),
                          foregroundColor: MaterialStateProperty.all<Color>(
                              colours.AppColor.background),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                          color: colours.AppColor.main,
                                          width: 3)))),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("START NEW GAME",
                            style: TextStyle(
                                fontSize: 32,
                                color: Colors.white,
                                fontFamily: 'StickNoBills')),
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
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.all(15)),
                          foregroundColor: MaterialStateProperty.all<Color>(
                              colours.AppColor.background),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                          color: colours.AppColor.main,
                                          width: 3)))),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("LOAD SAVE GAME",
                            style: TextStyle(
                                fontSize: 32,
                                color: Colors.white,
                                fontFamily: 'StickNoBills')),
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
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.all(15)),
                          foregroundColor: MaterialStateProperty.all<Color>(
                              colours.AppColor.background),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                          color: colours.AppColor.main,
                                          width: 3)))),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("LEADERBOARD",
                            style: TextStyle(
                                fontSize: 32,
                                color: Colors.white,
                                fontFamily: 'StickNoBills')),
                      ),
                    ),
                  ),
                ),
                // Original TextButton for EXIT GAME
                /*Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    width: 275,
                    child: TextButton(
                      onPressed: () {SystemNavigator.pop();},
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                          foregroundColor: MaterialStateProperty.all<Color>(colours.AppColor.background),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
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
                ),*/
                //Exit Game Button
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ExitGameDialog(),
                  ),
                ),
              ],
            ),
          ))),
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

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

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
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// Dialog Box for Exit Game
class ExitGameDialog extends StatelessWidget {
  const ExitGameDialog({super.key});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          padding:
              MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(15)),
          foregroundColor:
              MaterialStateProperty.all<Color>(colours.AppColor.background),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: colours.AppColor.main, width: 3)))),
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text(
            'EXIT GAME?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 50,
              fontFamily: 'StickNoBills',
              fontWeight: FontWeight.bold,
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            TextButton(
              onPressed: () => SystemNavigator.pop(),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(80, 50)),
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.all(5)),
                foregroundColor: MaterialStateProperty.all<Color>(
                    colours.AppColor.buttonBackground),
                backgroundColor:
                    MaterialStateProperty.all<Color>(colours.AppColor.main),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
              child: const Text('YES',
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'StickNoBills',
                      fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 25),
            TextButton(
                onPressed: () => Navigator.pop(context, 'NO'),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(80, 20)),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(5)),
                  foregroundColor: MaterialStateProperty.all<Color>(
                      colours.AppColor.buttonBackground),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(colours.AppColor.main),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
                child: const Text('NO',
                    style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'StickNoBills',
                        fontWeight: FontWeight.bold))),
          ],
        ),
      ),
      child: const SizedBox(
        width: 240,
        height: 40,
        child: Text("EXIT GAME",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              color: Colors.white,
              fontFamily: 'StickNoBills',
            )),
      ),
    );
  }
}
