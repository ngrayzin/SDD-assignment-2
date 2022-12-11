import 'package:flutter/cupertino.dart';

class Player extends ChangeNotifier {
  final String name;
  final List<String> map;
  int turn = 0;

  Player(this.name, this.map, this.turn);
  void addItemToMap(int i, String n) {
    map[i] = n;
  }
  void addTurn() {
    turn++;
    notifyListeners();
  }

  int returnTurn(){
    print(turn);
    notifyListeners();
    return turn;
  }

}


class Player{
  final String name;
  final List<String> map = [];
  final List<List<String>> ruleMap = [];
  Player(this.name);
}
