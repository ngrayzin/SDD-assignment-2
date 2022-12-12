import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flame/flame.dart'; // ADDED FLAME INTO DART FILE
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart'; // ADDED GOOGLE FONTS
import 'package:sdd_assignment_2/BoardSettings.dart';
import 'package:sdd_assignment_2/BuildingCard.dart';
import 'package:sdd_assignment_2/GameBoard.dart';
import 'Player.dart';
import 'PopUpMessage.dart';
import 'colours.dart' as colours;
import 'Firebase_options.dart';

class GameOver extends StatefulWidget {
  const GameOver({super.key});

  @override
  State<GameOver> createState() => _GameOver();

  static Player player = Player("name", [], 0);
}

class _GameOver extends State<GameOver> {
  final BoardSettings boardSettings = BoardSettings(cols: 10, rows: 10);
  //Player player = Player("name", []);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Game Over',
      home: Scaffold(
        backgroundColor: colours.AppColor.background,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            bottomOpacity: 0,
            centerTitle: true,
            flexibleSpace: Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
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
                      onPressed: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => PopUpMessage()),
                  ),
                  const Spacer(
                    flex: 5,
                  ),
                  Text(
                    'N.A.C',
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
                      icon: const Icon(Icons.close),
                      color: colours.AppColor.main,
                      onPressed: () => Navigator.pop(context),
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
        ),
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding:  EdgeInsets.fromLTRB(20,20,20,20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(0),
                  child: Text(
                    'THE GAME HAS ENDED!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'StickNoBills',
                      color: colours.AppColor.main,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                GameBoard(boardSettings: boardSettings, player: GameOver.player,),
                const Padding(padding: EdgeInsets.only(top: 60)),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: 75,
                  child: TextButton(
                    onPressed: (){},
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      backgroundColor: colours.AppColor.main,
                    ),
                    child: Text(
                      "SAVE GAME",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'StickNoBills',
                        color: colours.AppColor.background,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  )
                ),
              ],
            )
          ),
        ),
      )
    );
  }
}