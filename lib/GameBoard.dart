import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flame/flame.dart'; // ADDED FLAME INTO DART FILE
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart'; // ADDED GOOGLE FONTS
import 'package:sdd_assignment_2/BoardSettings.dart';
import 'package:sdd_assignment_2/BoardTile.dart';
import 'colours.dart' as colours;
import 'firebase_options.dart';

class GameBoard extends StatefulWidget{
  final BoardSettings boardSettings;
  const GameBoard({Key? key, required this.boardSettings}) : super (key:key);

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard>{
  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: SizedBox(
          height: 400,
          //margin: const EdgeInsets.only(top: 10.0),
          child:
          Expanded(
            child: GridView.count(
              crossAxisCount: widget.boardSettings.cols,
              crossAxisSpacing: 3,
              mainAxisSpacing: 3,
              children: [
                for (var i = 0; i < widget.boardSettings.totalTiles(); i++)
                /*
                Text("$i",
                style: TextStyle(
                  color: Colors.white,
                ),),

                 */
                  BoardTile(boardIndex: i, boardSettings: widget.boardSettings)
              ],
            ),
          ),
        ),
    );
  }
}