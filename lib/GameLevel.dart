import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flame/flame.dart'; // ADDED FLAME INTO DART FILE
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart'; // ADDED GOOGLE FONTS
import 'package:sdd_assignment_2/About.dart';
import 'package:sdd_assignment_2/BoardSettings.dart';
import 'package:sdd_assignment_2/BoardTile.dart';
import 'package:sdd_assignment_2/BuildingCard.dart';
import 'package:sdd_assignment_2/GameBoard.dart';
import 'package:sdd_assignment_2/PopUpMessage.dart';
import 'Building.dart';
import 'Player.dart';
import 'colours.dart' as colours;
import 'Firebase_options.dart';

class GameLevel extends StatefulWidget {
  const GameLevel({super.key});

  @override
  State<GameLevel> createState() => _GameLevelState();

  //static Player player = Player("name", [], 0);

}

class _GameLevelState extends State<GameLevel> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Level',
      home: Scaffold(
        backgroundColor: colours.AppColor.background,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: colours.AppColor.background,
          flexibleSpace: Padding(
            padding: EdgeInsets.only(
                top: MediaQuery
                    .of(context)
                    .size
                    .width * 0.15), // was 0.12
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(
                  flex: 1,
                ),
                IconButton(
                  iconSize: 40,
                  icon: const Icon(Icons.close),
                  color: colours.AppColor.main,
                  onPressed: () => Navigator.pop(context),
                ),
                const Spacer(
                  flex: 5,
                ),
                const Text(
                  'Game Level',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'StickNoBills',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Spacer(
                  flex: 5,
                ),
                Visibility(
                  child: IconButton(
                    iconSize: 40,
                    icon: const Icon(Icons.info_outline),
                    color: colours.AppColor.main,
                    onPressed: () {},
                  ),
                  maintainAnimation: true,
                  maintainSize: true,
                  maintainState: true,
                  visible: false,
                ),
                const Spacer(
                  flex: 1,
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height,
            //alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(
                MediaQuery
                    .of(context)
                    .size
                    .width * 0.07,
                MediaQuery
                    .of(context)
                    .size
                    .height * 0.1, //was 0.05
                MediaQuery
                    .of(context)
                    .size
                    .width * 0.07,
                MediaQuery
                    .of(context)
                    .size
                    .height * 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: colours.AppColor.buttonBackground,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: BorderSide(width: 3, color: colours.AppColor.main),
                        ),
                      ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      padding: const EdgeInsets.fromLTRB(10.0, 18.0, 10.0, 18.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Text(
                            'EASY',
                            style: TextStyle(
                              fontFamily: 'StickNoBills',
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            '5x5 grid',
                            style: TextStyle(
                              fontFamily: 'StickNoBills',
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: colours.AppColor.buttonBackground,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: BorderSide(width: 3, color: colours.AppColor.main),
                      ),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      padding: const EdgeInsets.fromLTRB(10.0, 18.0, 10.0, 18.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Text(
                              'MEDIUM',
                              style: TextStyle(
                                fontFamily: 'StickNoBills',
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              '7x7 grid',
                              style: TextStyle(
                                fontFamily: 'StickNoBills',
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: colours.AppColor.buttonBackground,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: BorderSide(width: 3, color: colours.AppColor.main),
                      ),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      padding: const EdgeInsets.fromLTRB(10.0, 18.0, 10.0, 18.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Text(
                              'HARD',
                              style: TextStyle(
                                fontFamily: 'StickNoBills',
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              '10x10 grid',
                              style: TextStyle(
                                fontFamily: 'StickNoBills',
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}