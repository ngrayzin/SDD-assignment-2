import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flame/flame.dart'; // ADDED FLAME INTO DART FILE
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart'; // ADDED GOOGLE FONTS
import 'package:sdd_assignment_2/BoardSettings.dart';
import 'package:sdd_assignment_2/BuildingTile.dart';
import 'Building.dart';
import 'colours.dart' as colours;
import 'Firebase_options.dart';


class BoardTile extends StatefulWidget {
  final int boardIndex;
  final BoardSettings boardSettings;
  const BoardTile({Key? key, required this.boardIndex, required this.boardSettings}) : super (key: key);


  @override
  State<BoardTile> createState() => _BoardTileState();

}

class _BoardTileState extends State<BoardTile>{
  bool exist = false;
  String name = "";
  @override
  Widget build(BuildContext context){
    return DragTarget<Building>(
      onAccept: (data) => setState(() {
        exist = true;
        name = data.name;
      }),
      builder: (context, accept, reject){
        if(exist){
          return BuildingTile(boardIndex: widget.boardIndex,
              boardSettings: widget.boardSettings,
              name: name);
        }
        else {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            //child: Center(child: Text ("${widget.boardIndex}"),),
          );
        }
      }
    );
  }
}