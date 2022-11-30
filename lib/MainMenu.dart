import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flame/flame.dart'; // ADDED FLAME INTO DART FILE
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart'; // ADDED GOOGLE FONTS
import 'package:sdd_assignment_2/GamePage.dart';
import 'package:sdd_assignment_2/PopUpMessage.dart';
import 'colours.dart' as colours;
import 'firebase_options.dart';
import "Leaderboard.dart";

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
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(
                        left: 80, top: 10, right: 80, bottom: 20),
                    child: Image.asset(
                      "assets/images/logo.png",
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 45, top: 20, right: 45, bottom: 20),
                    child: Image.asset(
                      "assets/images/name.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: SizedBox(
                      width: 275,
                      child: TextButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return const GamePage();
                        })),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.all(12)),
                            foregroundColor: MaterialStateProperty.all<Color>(
                                colours.AppColor.background),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
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
                                EdgeInsets.all(12)),
                            foregroundColor: MaterialStateProperty.all<Color>(
                                colours.AppColor.background),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
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
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LeaderBoard(),
                              ));
                        },
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.all(12)),
                            foregroundColor: MaterialStateProperty.all<Color>(
                                colours.AppColor.background),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
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
                                EdgeInsets.all(12)),
                            foregroundColor: MaterialStateProperty.all<Color>(
                                colours.AppColor.background),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    side: BorderSide(
                                        color: colours.AppColor.main,
                                        width: 3)))),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("EXIT GAME",
                              style: TextStyle(
                                  fontSize: 32,
                                  color: Colors.white,
                                  fontFamily: 'StickNoBills')),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }
}
