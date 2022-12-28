import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flame/flame.dart'; // ADDED FLAME INTO DART FILE
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart'; // ADDED GOOGLE FONTS
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sdd_assignment_2/About.dart';
import 'package:sdd_assignment_2/GameLevel.dart';
import 'package:sdd_assignment_2/GamePage.dart';
import 'package:sdd_assignment_2/LoadGame.dart';
import 'package:sdd_assignment_2/PopUpMessage.dart';
import 'Player.dart';
import 'colours.dart' as colours;
import 'Firebase_options.dart';
import "Leaderboard.dart";

/*final GoogleSignIn _googleSignIn = GoogleSignIn(
  signInOption: SignInOption.games,
  scopes: ['email'],
);*/

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
  static int value = 0;
}

class _MainMenuState extends State<MainMenu> {
/*  GoogleSignInAccount? _currentUser;
  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) async {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        await FirebaseAuth.instance.signInAnonymously();
      }
    });
    _googleSignIn.signInSilently();
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colours.AppColor.background,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.07,
              MediaQuery.of(context).size.height * 0.025,
              MediaQuery.of(context).size.width * 0.07,
              MediaQuery.of(context).size.height * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SizedBox(
                  child: Image.asset("assets/images/App_logo.png"),
                  width: 200,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 0),
                child: Image.asset(
                  "assets/images/App_name.png",
                  width: MediaQuery.of(context).size.width * 0.8,
                  //fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: TextButton(
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const GameLevel();
                    })),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.fromLTRB(0, 16.0, 0, 16.0)),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            colours.AppColor.background),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    side: BorderSide(
                                        color: colours.AppColor.main,
                                        width: 3)))),
                    child: Text("START NEW GAME",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontFamily: 'StickNoBills')),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: TextButton(
                    onPressed: () async {
                      final ref = FirebaseDatabase.instance.ref();
                      var currentUser = FirebaseAuth.instance.currentUser;
                      await ref.child('players/${currentUser?.uid}/saveGame').get()
                          .then((snapshot){
                            if (snapshot.exists) {
                              var list = [];
                              for (var item in snapshot.children) {
                                print(item.value);
                                list.add(item.value);
                              }
                              Player player = Player(currentUser?.displayName, [], list[4], list[0]);
                              player.stringMap = list[2];
                              player.deserializeMap();
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return LoadGame(player: player, coin: list[0], level: list[1], point: list[3],);
                                  }));
                            }
                            else {
                              Fluttertoast.showToast(
                                  msg: "No previous saved game",
                                  toastLength: Toast.LENGTH_SHORT,
                                  timeInSecForIosWeb: 1,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            }
                        });
                      /*Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const LoadGame();
                    }));*/
                    },
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.fromLTRB(0, 16.0, 0, 16.0)),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            colours.AppColor.background),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    side: BorderSide(
                                        color: colours.AppColor.main,
                                        width: 3)))),
                    child: Text("LOAD SAVE GAME",
                        style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontFamily: 'StickNoBills')),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LeaderBoard(),
                          ));
                    },
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.fromLTRB(0, 16.0, 0, 16.0)),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            colours.AppColor.background),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    side: BorderSide(
                                        color: colours.AppColor.main,
                                        width: 3)))),
                    child: Text("LEADERBOARD",
                        style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontFamily: 'StickNoBills')),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: TextButton(
                    onPressed: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => PopUpMessage(
                              value: MainMenu.value,
                            )),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.fromLTRB(0, 16.0, 0, 16.0)),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            colours.AppColor.background),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    side: BorderSide(
                                        color: colours.AppColor.main,
                                        width: 3)))),
                    child: Text("EXIT GAME",
                        style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontFamily: 'StickNoBills')),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

}
