import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flame/flame.dart'; // ADDED FLAME INTO DART FILE
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart'; // ADDED GOOGLE FONTS
import 'package:sdd_assignment_2/BoardSettings.dart';
import 'package:sdd_assignment_2/GameBoard.dart';
import 'colours.dart' as colours;
import 'firebase_options.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();

}

class _GamePageState extends State<GamePage>{
  final BoardSettings boardSettings = BoardSettings(cols: 20, rows: 20);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: colours.AppColor.background,
      body: SafeArea(
        child: Container (
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        //alignment: Alignment.center,
        padding:  EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  iconSize: 50,
                  icon: const Icon(Icons.menu),
                  color: colours.AppColor.main,
                  onPressed: (){},
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: Text(
                    'N.A.C',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 50,
                      fontFamily: 'StickNoBills',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  iconSize: 50,
                  icon: const Icon(Icons.close),
                  color: colours.AppColor.main,
                  onPressed: (){},
                ),
              ],
            ),

            const Spacer(),
            GameBoard(boardSettings: boardSettings),
            const Spacer(),
          ],
        )
        ),
      ),
    );
  }
}


