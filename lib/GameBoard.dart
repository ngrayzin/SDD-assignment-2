import 'dart:convert';
import 'dart:core';
import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flame/flame.dart'; // ADDED FLAME INTO DART FILE
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart'; // ADDED GOOGLE FONTS
import 'package:sdd_assignment_2/BoardSettings.dart';
import 'package:sdd_assignment_2/BoardTile.dart';
import 'package:sdd_assignment_2/GamePage.dart';
import 'Building.dart';
import 'BuildingTile.dart';
import 'Player.dart';
import 'colours.dart' as colours;
import 'Firebase_options.dart';

class GameBoard extends StatefulWidget {
  final BoardSettings boardSettings;
  final Player player;
  const GameBoard({Key? key, required this.boardSettings, required this.player})
      : super(key: key);

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  //final List<List<String>> widgets = [];
  //List<String> list2 = [];
  @override
  void initState() {
    super.initState();
    /*for (var row = 0; row < 10; row++){
      list2.clear();
      for (var column = 0; column < 10; column++){
        list2.add("-");
      }
      widget.player.ruleMap.add(list2);
    }*/
    for (var i = 0; i < widget.boardSettings.totalTiles(); i++) {
      widget.player.map.add("-");
    }
    print(widget.player.map);
  }

  @override
  bool exist = false;
  String name = "";
  @override
  Widget build(BuildContext context) {
    return Expanded(
      //margin: const EdgeInsets.only(top: 10.0),
      child: Container(
        margin: const EdgeInsets.all(0.0),
        child: SizedBox(
          height: 400,
          child: GridView.count(
            crossAxisCount: widget.boardSettings.cols,
            crossAxisSpacing: 3,
            mainAxisSpacing: 3,
            children: [
              for (var i = 0; i < widget.boardSettings.totalTiles(); i++)
                BoardTile(
                  boardIndex: i,
                  boardSettings: widget.boardSettings,
                  player: widget.player,
                )
            ],
          ),
        ),
      ),
    );
  }

  int turnCount() {
    int count = 0;
    for (int i = 0; i < widget.boardSettings.totalTiles(); i++) {
      if (widget.player.map[i] != "-") {
        count++;
      }
    }
    return count;
  }
}

bool mapRules(List<String> map, int i) {
  //center index is either +1 -1 +10 -10
  List<String> building = [
    'Park',
    'Industry',
    'Residential',
    'Road',
    'Commercial'
  ];
  if (building.contains(map[i])) {
    print('no');
    return false;
  } else if (map.asMap().containsKey(i - 10) && map[i - 10] != "-") {
    print("yes");
    return true;
  }
  if (map.asMap().containsKey(i + 10) && map[i + 10] != "-") {
    print("yes");
    return true;
  }
  if (map.asMap().containsKey(i - 1) && map[i - 1] != "-" && i % 10 != 0) {
    print("yes");
    return true;
  }
  if (map.asMap().containsKey(i + 1) &&
      map[i + 1] != "-" &&
      (i + 1) % 10 != 0) {
    print("yes");
    return true;
  } else {
    print("no");
    return false;
  }
}

/*
 //right now its all in boardtile
 //add all the boardtile into list
 //map functions to boardtile list
 void _buildingDropped({
    required Building building,
    required Player player ,
    required int index,
  }){
    setState(() {
      player.addTurn();
      widget.player.addItemToMap(index,building.name);
      print(widget.player.map);
    });
  }
  Widget _buildDragZone(Building building, int index){
    bool exist = false;
    String name = "";
    return DragTarget<Building>(
        builder: (context, accept, reject){
          return DragTarget<Building>(
              onAccept: (data) => setState(() {
                exist = widget.player.turn == 1 ? true : mapRules(widget.player.map, index);
                _buildingDropped(building: building, player: widget.player, index: index);
              }),
              builder: (context, accept, reject){
                if(exist){
                  return BuildingTile(boardIndex: index,
                      boardSettings: widget.boardSettings,
                      name: name);
                }
                else {
                  widget.player.addItemToMap(index,"-");
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
    );
  }
}
*/