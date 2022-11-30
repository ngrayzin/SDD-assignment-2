import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flame/flame.dart'; // ADDED FLAME INTO DART FILE
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart'; // ADDED GOOGLE FONTS
import 'package:sdd_assignment_2/BoardSettings.dart';
import 'colours.dart' as colours;
import 'firebase_options.dart';


class BoardTile extends StatefulWidget {
  final int boardIndex;
  final BoardSettings boardSettings;
  const BoardTile({Key? key, required this.boardIndex, required this.boardSettings}) : super (key: key);


  @override
  State<BoardTile> createState() => _BoardTileState();

}

class _BoardTileState extends State<BoardTile>{
  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          //child: Center(child: Text ("${widget.boardSettings}"),),
        ),
    );
  }
}