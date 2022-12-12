import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flame/flame.dart'; // ADDED FLAME INTO DART FILE
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart'; // ADDED GOOGLE FONTS
import 'package:sdd_assignment_2/About.dart';
import 'package:sdd_assignment_2/GamePage.dart';
import 'package:sdd_assignment_2/LoadGame.dart';
import 'package:sdd_assignment_2/PopUpMessage.dart';
import 'colours.dart' as colours;
import 'Firebase_options.dart';
import 'LeaderboardPage.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colours.AppColor.background,
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      child: Image.asset("assets/images/Logo.png"),
                      width: 200,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Image.asset(
                      "assets/images/Name.png",
                      width: MediaQuery.of(context).size.width * 0.85,
                      //fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 10),
                    child: SizedBox(
                      width: 275,
                      child: TextButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return const GamePage();
                        })),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.fromLTRB(0, 16.0, 0, 16.0)),
                            foregroundColor: MaterialStateProperty.all<Color>(
                                colours.AppColor.background),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(

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
                  width: 275,
                  child: TextButton(
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const LoadGame();
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
                  width: 275,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LeaderBoardPage(),
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
                  width: 275,
                  child: TextButton(
                    onPressed: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => PopUpMessage()),
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