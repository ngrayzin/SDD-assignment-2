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
}
