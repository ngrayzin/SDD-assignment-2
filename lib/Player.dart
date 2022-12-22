import 'package:flutter/cupertino.dart';

class Player {
  String name;
  final List<String> map;
  int turn = 0;
  int point = 0;
  int coin = 16;

  Player(this.name, this.map, this.turn);

  /* Player.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        map = json['map'],
        turn = json['turn'],
        point = json['point'],
        coin = json['coin'];*/
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'map': map.toString(),
      'turn': turn,
      'point': point,
      'coin': coin,
    };
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
}
