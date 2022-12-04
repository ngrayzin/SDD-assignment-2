import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flame/flame.dart'; // ADDED FLAME INTO DART FILE
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart'; // ADDED GOOGLE FONTS
import 'package:sdd_assignment_2/BoardSettings.dart';
import 'package:sdd_assignment_2/BuildingTile.dart';
import 'package:sdd_assignment_2/GameBoard.dart';
import 'Building.dart';
import 'Player.dart';
import 'colours.dart' as colours;
import 'Firebase_options.dart';


class BoardTile extends StatefulWidget {
  final int boardIndex;
  final BoardSettings boardSettings;
  final Player player;
  const BoardTile({Key? key, required this.boardIndex, required this.boardSettings, required this.player}) : super (key: key);


  @override
  State<BoardTile> createState() => _BoardTileState();

}

class _BoardTileState extends State<BoardTile>{
  bool exist = false;
  String name = "";
  @override
  Widget build(BuildContext context){
    return DragTarget<Building>(
      builder: (context, accept, reject){
        if(exist){
          return BuildingTile(boardIndex: widget.boardIndex,
              boardSettings: widget.boardSettings,
              name: name);
        }
        else {
          widget.player.addItemToMap(widget.boardIndex,"-");
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Center(child: Text ("${widget.boardIndex}"),),
          );
        }
      },
      onAccept: (data) => setState(() {
        exist = widget.player.turn == 0 ? true : mapRules(widget.player.map, widget.boardIndex);
        name = data.name;
        exist ? widget.player.addItemToMap(widget.boardIndex,name) : null;
        exist ? widget.player.addTurn()  : null;
        print(widget.player.map);
      }),
    );
  }

  bool changeColour(){
    for(int i = 0; i < widget.boardSettings.totalTiles(); i++){
      if(widget.player.map[i] != "-"){
        return true;
      }
    }
    return false;
  }
}
