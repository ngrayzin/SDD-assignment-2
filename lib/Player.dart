import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:sdd_assignment_2/GamePage.dart';

import 'Login.dart';

class Player {
  String? name;
  String stringMap = "";
  List<String> map = [];
  int turn = 0;
  int point = 0;
  int coin = 16;
  int level = 0;
  int highScore = 0;

  Player(this.name, this.map, this.turn, this.level);

  Player.fromPlayer(var playerName, var playerHighScore) {
    name = playerName;
    highScore = playerHighScore;
  }

  Player.fromJson(dynamic json)
      : name = FirebaseAuth.instance.currentUser?.displayName,
        map = [],
        stringMap = json['map'],
        turn = json['turn'],
        point = json['point'],
        coin = json['coin'],
        level = json['level'];

  // factory Player.fromJson(dynamic json) {
  //   return Player(json['name'] as String, json['map'] as List<String>,
  //       json['turn'] as int);
  // }

  Map<String, dynamic> ToJson() {
    return {
      'map': map.toString(),
      'turn': turn,
      'point': point,
      'coin': coin,
      'level': level,
    };
  }

  void nerf() {
    if (level == 5) {
      coin -= 8;
    } else if (level == 7) {
      coin -= 4;
    }
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
    return turn;
  }

  bool endGrid() {
    for (int i = 0; i < map.length; i++) {
      if (map[i] == "-") {
        return false;
      }
    }
    return true;
  }

  Future<void> saveGame(int score, int level) async {
    //final user =  FirebaseDatabase.instance.ref().child('players/${currentUser?.uid}');
    var ref;
    switch (level) {
      case 5:
        ref = FirebaseDatabase.instance
            .ref()
            .child('players/${currentUser?.uid}/highestScore_easy');
        break;
      case 7:
        ref = FirebaseDatabase.instance
            .ref()
            .child('players/${currentUser?.uid}/highestScore_medium');
        break;
      case 10:
        ref = FirebaseDatabase.instance
            .ref()
            .child('players/${currentUser?.uid}/highestScore_hard');
        break;
    }
    final newPostKey = FirebaseDatabase.instance
        .ref()
        .child('players/${currentUser?.uid}/finishGame')
        .push()
        .key;
    DatabaseReference finish = FirebaseDatabase.instance
        .ref('players/${currentUser?.uid}/finishGame/$newPostKey');
    DatabaseReference remove =
        FirebaseDatabase.instance.ref('players/${currentUser?.uid}/saveGame');
    await ref.get().then((snapshot) {
      if (snapshot.exists) {
        String string = snapshot.value.toString();
        int i = int.parse(string);
        if (score > i) {
          ref.set(score);
        }
      } else {
        ref.set(score);
      }
    }).then((_) {
      finish.set(ToJson());
      remove.set(null);
    });
    //DatabaseReference ref = FirebaseDatabase.instance.ref('players/${currentUser?.uid}/finishGame');
    //await ref.update(saveGameToJson());
  }

  Future<bool> highscore(int score, int level) async {
    bool check = false;
    var currentUser = FirebaseAuth.instance.currentUser;
    var ref;
    switch (level) {
      case 5:
        ref = FirebaseDatabase.instance
            .ref()
            .child('players/${currentUser?.uid}/highestScore_easy');
        break;
      case 7:
        ref = FirebaseDatabase.instance
            .ref()
            .child('players/${currentUser?.uid}/highestScore_medium');
        break;
      case 10:
        ref = FirebaseDatabase.instance
            .ref()
            .child('players/${currentUser?.uid}/highestScore_hard');
        break;
    }
    await ref.get().then((snapshot) {
      if (snapshot.exists) {
        String string = snapshot.value.toString();
        int i = int.parse(string);
        if (score > i) {
          check = true;
        }
      } else {
        check = true;
      }
    });
    return check;
  }

  void setLevel(String text) {
    if (text == "Easy") {
      GamePage.value = 5;
      level = 5;
    } else if (text == "Medium") {
      GamePage.value = 7;
      level = 7;
    } else if (text == "Hard") {
      GamePage.value = 10;
      level = 10;
    }
  }

  void calculatePoints(int row) {
    point = 0;
    coin = 16 - turn;

    for (int i = 0; i < (row * row); i++) {
      //checking for the road
      //point
      if (i % row == 0) {
        List<String> roadList = List<String>.filled(row, "-", growable: false);
        int counter = i;
        int roadCount = 0;
        List<int> connected = [];
        for (int element = 0; element < row; element++) {
          roadList[element] = map[counter];
          counter++;
        }
        for (int roadCounter = 0;
            roadCounter < roadList.length;
            roadCounter++) {
          if (roadCounter < roadList.length - 1) {
            if (roadList[roadCounter] == "Road") {
              roadCount += 1;
            } else {
              connected.add(roadCount);
              roadCount = 0;
            }
          } else {
            if (roadList[roadCounter] == "Road") {
              roadCount += 1;
            }
            connected.add(roadCount);
            roadCount = 0;
          }
        }
        for (int x = 0; x < connected.length; x++) {
          if (connected[x] > 1) {
            point += connected[x];
          }
        }
      }

      //checking for Park
      if (map[i] == "Park") {
        if (map.asMap().containsKey(i - row) && map[i - row] == "Park") {
          //check if there is smt below
          point++;
        } else if (map.asMap().containsKey(i + row) && map[i + row] == "Park") {
          //check if there is smt on top
          point++;
        } else if (map.asMap().containsKey(i - 1) &&
            map[i - 1] == "Park" &&
            i % row != 0) {
          //check if there is smt on the left
          point++;
        } else if (map.asMap().containsKey(i + 1) &&
            map[i + 1] == "Park" &&
            (i + 1) % row != 0) {
          //check if there is smt on the right
          point++;
        }
      }
      //checking for Commercial
      else if (map[i] == "Commercial") {
        //point
        if (map.asMap().containsKey(i - row) && map[i - row] == "Commercial") {
          //check if there is smt below
          point++;
        } else if (map.asMap().containsKey(i + row) &&
            map[i + row] == "Commercial") {
          //check if there is smt on top
          point++;
        } else if (map.asMap().containsKey(i - 1) &&
            map[i - 1] == "Commercial" &&
            i % row != 0) {
          //check if there is smt on the left
          point++;
        } else if (map.asMap().containsKey(i + 1) &&
            map[i + 1] == "Commercial" &&
            (i + 1) % row != 0) {
          //check if there is smt on the right
          point++;
        }
        //coin
        if (map.asMap().containsKey(i - row) && map[i - row] == "Residential") {
          //check if there is smt below
          coin++;
        }
        if (map.asMap().containsKey(i + row) && map[i + row] == "Residential") {
          //check if there is smt on top
          coin++;
        }
        if (map.asMap().containsKey(i - 1) &&
            map[i - 1] == "Residential" &&
            i % row != 0) {
          //check if there is smt on the left
          coin++;
        }
        if (map.asMap().containsKey(i + 1) &&
            map[i + 1] == "Residential" &&
            (i + 1) % row != 0) {
          //check if there is smt on the right
          coin++;
        }
      }
      //checking for industry
      else if (map[i] == "Industry") {
        //point
        point++;
        //coin
        if (map.asMap().containsKey(i - row) && map[i - row] == "Residential") {
          //check if there is smt below
          coin++;
        }
        if (map.asMap().containsKey(i + row) && map[i + row] == "Residential") {
          //check if there is smt on top
          coin++;
        }
        if (map.asMap().containsKey(i - 1) &&
            map[i - 1] == "Residential" &&
            i % row != 0) {
          //check if there is smt on the left
          coin++;
        }
        if (map.asMap().containsKey(i + 1) &&
            map[i + 1] == "Residential" &&
            (i + 1) % row != 0) {
          //check if there is smt on the right
          coin++;
        }
      }

      //checking for residential
      else if (map[i] == "Residential") {
        bool adjacent = false;
        //point
        //for adjacent industry
        if (map.asMap().containsKey(i - row) && map[i - row] == "Industry") {
          //check if there is smt below
          point++;
          adjacent = true;
        } else if (map.asMap().containsKey(i + row) &&
            map[i + row] == "Industry") {
          //check if there is smt on top
          point++;
          adjacent = true;
        } else if (map.asMap().containsKey(i - 1) &&
            map[i - 1] == "Industry" &&
            i % row != 0) {
          //check if there is smt on the left
          point++;
          adjacent = true;
        } else if (map.asMap().containsKey(i + 1) &&
            map[i + 1] == "Industry" &&
            (i + 1) % row != 0) {
          //check if there is smt on the right
          point++;
          adjacent = true;
        }
        // if there are other buildings next to it
        if (!adjacent) {
          //residential
          if (map.asMap().containsKey(i - row) &&
              map[i - row] == "Residential") {
            //check if there is smt below
            point++;
          }
          if (map.asMap().containsKey(i + row) &&
              map[i + row] == "Residential") {
            //check if there is smt on top
            point++;
          }
          if (map.asMap().containsKey(i - 1) &&
              map[i - 1] == "Residential" &&
              i % row != 0) {
            //check if there is smt on the left
            point++;
          }
          if (map.asMap().containsKey(i + 1) &&
              map[i + 1] == "Residential" &&
              (i + 1) % row != 0) {
            //check if there is smt on the right
            point++;
          }
          //commercial
          if (map.asMap().containsKey(i - row) &&
              map[i - row] == "Commercial") {
            //check if there is smt below
            point++;
          }
          if (map.asMap().containsKey(i + row) &&
              map[i + row] == "Commercial") {
            //check if there is smt on top
            point++;
          }
          if (map.asMap().containsKey(i - 1) &&
              map[i - 1] == "Commercial" &&
              i % row != 0) {
            //check if there is smt on the left
            point++;
          }
          if (map.asMap().containsKey(i + 1) &&
              map[i + 1] == "Commercial" &&
              (i + 1) % row != 0) {
            //check if there is smt on the right
            point++;
          }
          //park
          if (map.asMap().containsKey(i - row) && map[i - row] == "Park") {
            //check if there is smt below
            point += 2;
          }
          if (map.asMap().containsKey(i + row) && map[i + row] == "Park") {
            //check if there is smt on top
            point += 2;
          }
          if (map.asMap().containsKey(i - 1) &&
              map[i - 1] == "Park" &&
              i % row != 0) {
            //check if there is smt on the left
            point += 2;
          }
          if (map.asMap().containsKey(i + 1) &&
              map[i + 1] == "Park" &&
              (i + 1) % row != 0) {
            //check if there is smt on the right
            point += 2;
          }
        }
      }
    }
  }
}
