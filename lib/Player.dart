import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Player {
  String name;
  String stringMap = "";
  List<String> map;
  int turn = 0;
  int point = 0;
  int coin = 16;

  Player(this.name, this.map, this.turn);

  Player.fromJson(dynamic json)
      : name = json['name'],
        map = [],
        stringMap = json['map'],
        turn = json['turn'],
        point = json['point'],
        coin = json['coin'];

  // factory Player.fromJson(dynamic json) {
  //   return Player(json['name'] as String, json['map'] as List<String>,
  //       json['turn'] as int);
  // }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'map': map.toString(),
      'turn': turn,
      'point': point,
      'coin': coin,
    };
  }

  void deserializeMap() {
    stringMap = stringMap.substring(1, stringMap.length - 1);
    List<String> list = stringMap.split(", ");
    map = list;
  }

  void addItemToMap(int i, String n) {
    map[i] = n;
  }

  void addTurn() {
    turn++;
  }

  void minusCoin() {
    coin--;
  }

  int returnTurn() {
    print(turn);
    return turn;
  }



  void calculatePoints(int row){
    point = 0;
    coin = 16-turn;

    for (int i = 0; i < (row*row); i++){
      //checking for the road
      //point
      if (i % row == 0){
        List<String> roadList = List<String>.filled(row, "-", growable: false);
        int counter = i;
        int roadCount = 0;
        List<int> connected = [];
        for (int element = 0; element < row; element++){
          roadList[element] = map[counter];
          counter++;
        }
        print("roadList");
        print(roadList);
        for (int roadCounter = 0; roadCounter < roadList.length; roadCounter++){
          if (roadList[roadCounter] == "Road"){
            roadCount +=1 ;
          }
          else {
            connected.add(roadCount);
            roadCount = 0;
          }
        }
        print("connected");
        print(connected);
        print("\n\n\n\n");
        for (int x = 0; x < connected.length; x++){
          if (connected[x] > 1){
            print("break");
            print(connected[x]);
            point += connected[x];
          }
        }
      }

      //checking for Park
      if (map[i] == "Park"){
        if (map.asMap().containsKey(i - row) && map[i - row] == "Park") { //check if there is smt below
          point++;
        } else if (map.asMap().containsKey(i + row) && map[i + row] == "Park") { //check if there is smt on top
          point++;
        } else if (map.asMap().containsKey(i - 1) && map[i - 1] == "Park" && i % row == 0) { //check if there is smt on the left
          point++;
        } else if (map.asMap().containsKey(i + 1) && map[i + 1] == "Park" &&(i + 1) % row != 0) { //check if there is smt on the right
          point++;
        }
      }
      //checking for Commercial
      else if (map[i] == "Commercial"){
        //point
        if (map.asMap().containsKey(i - row) && map[i - row] == "Commercial") { //check if there is smt below
          point++;
        } else if (map.asMap().containsKey(i + row) && map[i + row] == "Commercial") { //check if there is smt on top
          point++;
        } else if (map.asMap().containsKey(i - 1) && map[i - 1] == "Commercial" && i % row == 0) { //check if there is smt on the left
          point++;
        } else if (map.asMap().containsKey(i + 1) && map[i + 1] == "Commercial" &&(i + 1) % row != 0) { //check if there is smt on the right
          point++;
        }
        //coin
        if (map.asMap().containsKey(i - row) && map[i - row] == "Residential") { //check if there is smt below
          coin++;
        } else if (map.asMap().containsKey(i + row) && map[i + row] == "Residential") { //check if there is smt on top
          coin++;
        } else if (map.asMap().containsKey(i - 1) && map[i - 1] == "Residential" && i % row == 0) { //check if there is smt on the left
          coin++;
        } else if (map.asMap().containsKey(i + 1) && map[i + 1] == "Residential" &&(i + 1) % row != 0) { //check if there is smt on the right
          coin++;
        }
      }
      //checking for industry
      else if  (map[i] == "Industry"){
        //point
        point++;
        //coin
        if (map.asMap().containsKey(i - row) && map[i - row] == "Residential") { //check if there is smt below
          coin++;
        } else if (map.asMap().containsKey(i + row) && map[i + row] == "Residential") { //check if there is smt on top
          coin++;
        } else if (map.asMap().containsKey(i - 1) && map[i - 1] == "Residential" && i % row == 0) { //check if there is smt on the left
          coin++;
        } else if (map.asMap().containsKey(i + 1) && map[i + 1] == "Residential" &&(i + 1) % row != 0) { //check if there is smt on the right
          coin++;
        }
      }

      //checking for residential
      else if (map[i] == "Residential"){
        bool adjacent = false;
        //point
        //for adjacent industry
        if (map.asMap().containsKey(i - row) && map[i - row] == "Industry") { //check if there is smt below
          point++;
          adjacent = true;
        } else if (map.asMap().containsKey(i + row) && map[i + row] == "Industry") { //check if there is smt on top
          point++;
          adjacent = true;
        } else if (map.asMap().containsKey(i - 1) && map[i - 1] == "Industry" && i % row == 0) { //check if there is smt on the left
          point++;
          adjacent = true;
        } else if (map.asMap().containsKey(i + 1) && map[i + 1] == "Industry" &&(i + 1) % row != 0) { //check if there is smt on the right
          point++;
          adjacent = true;
        }
        // if there are other buildings next to it
        if (!adjacent){
          //residential
          if (map.asMap().containsKey(i - row) && map[i - row] == "Residential") { //check if there is smt below
            point++;
          } else if (map.asMap().containsKey(i + row) && map[i + row] == "Residential") { //check if there is smt on top
            point++;
          } else if (map.asMap().containsKey(i - 1) && map[i - 1] == "Residential" && i % row == 0) { //check if there is smt on the left
            point++;
          } else if (map.asMap().containsKey(i + 1) && map[i + 1] == "Residential" &&(i + 1) % row != 0) { //check if there is smt on the right
            point++;
          }
          //commercial
          if (map.asMap().containsKey(i - row) && map[i - row] == "Commercial") { //check if there is smt below
            point++;
          } else if (map.asMap().containsKey(i + row) && map[i + row] == "Commercial") { //check if there is smt on top
            point++;
          } else if (map.asMap().containsKey(i - 1) && map[i - 1] == "Commercial" && i % row == 0) { //check if there is smt on the left
            point++;
          } else if (map.asMap().containsKey(i + 1) && map[i + 1] == "Commercial" &&(i + 1) % row != 0) { //check if there is smt on the right
            point++;
          }
          //park
          if (map.asMap().containsKey(i - row) && map[i - row] == "Park") { //check if there is smt below
            point+=2;
          } else if (map.asMap().containsKey(i + row) && map[i + row] == "Park") { //check if there is smt on top
            point+=2;
          } else if (map.asMap().containsKey(i - 1) && map[i - 1] == "Park" && i % row == 0) { //check if there is smt on the left
            point+=2;
          } else if (map.asMap().containsKey(i + 1) && map[i + 1] == "Park" &&(i + 1) % row != 0) { //check if there is smt on the right
            point+=2;
          }
        }
      }

    }









    /*
    var gridRow = List<String>.filled(row, "-");
    var gridList = List.generate(col, (i) => gridRow, growable: false);
    List<String> mapCopy = map;

    for (int r = 0; r < row; r++){
      for (int c = 0; c < col; c++){
        gridList[r][c] = mapCopy[0];
        mapCopy.removeAt(0);
        print (gridList);
      }
    }



    for (int r = 0; r < row; r++){
      for (int c = 0; c < col; c++){

        print (gridList[r][c]);

        //Park
        if (gridList[r][c] == "Park"){
          if (r != row && c != col && r != 0 && c != 0){ //if the park lies in the middle of the grid
            if (gridList[r-1][c] == "Park" || gridList[r+1][c] == "Park" || gridList[r][c-1] == "Park" || gridList[r][c+1] == "Park"){
              point++;
            }
          }
          else if (r == 0 && c != 0 && c != col){ // if the park lies in the top row
            if (gridList[r+1][c] == "Park" || gridList[r][c-1] == "Park" || gridList[r][c+1] == "Park"){
              point++;
            }
          }
          else if (r == row && c != 0 && c != col){ // if the park lies in the bottom row
            if (gridList[r-1][c] == "Park" || gridList[r][c-1] == "Park" || gridList[r][c+1] == "Park"){
              point++;
            }
          }
          else if (c == 0 && r != 0 && r != row){ // if the park lies in the first col
            if (gridList[r-1][c] == "Park" || gridList[r+1][c] == "Park" || gridList[r][c+1] == "Park"){
              point++;
            }
          }
          else if (c == col && r != 0 && r != row){ // if the park lies in the last col
            if (gridList[r-1][c] == "Park" || gridList[r+1][c] == "Park" || gridList[r][c-1] == "Park"){
              point++;
            }
          }
          else if (r == 0 && c == 0){ // if park lies in the top left corner of the grid
            if ( (gridList[r][c+1] == "Park") || (gridList[r+1][c] == "Park")){
              point++;
            }
          }
          else if (r == 0 && c == col){ // if the park lies in the top right corner of the grid
            if ( (gridList[r][c-1] == "Park") || (gridList[r+1][c] == "Park") ){
              point++;
            }
          }
          else if (r == row && c == 0){ // if the park lies in the bottom left corner of the grid
            if ( (gridList[r-1][c] == "Park") && (gridList[r][c-1] == "Park") ){
              point++;
            }
          }
          else if (r == row && c == col){ // if the park lies in the bottom right corner of the grid
            if ( (gridList[r-1][c] == "Park") && (gridList[r][c-1] == "Park") ){
              point++;
            }
          }
        }
        //End of Park



      }
    }
    */




  }
}
