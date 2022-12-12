import 'package:flutter/cupertino.dart';

class Player{
  final String name;
  final List<String> map;
  int turn = 0;
  int point = 0;
  int coin = 0;

  Player(this.name, this.map, this.turn);
  void addItemToMap(int i, String n) {
    map[i] = n;
  }
  void addTurn() {
    turn++;
  }

  int returnTurn(){
    print(turn);
    return turn;
  }
}

