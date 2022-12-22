import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flame/flame.dart'; // ADDED FLAME INTO DART FILE
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart'; // ADDED GOOGLE FONTS
import 'package:sdd_assignment_2/About.dart';
import 'package:sdd_assignment_2/BoardSettings.dart';
import 'package:sdd_assignment_2/BoardTile.dart';
import 'package:sdd_assignment_2/BuildingCard.dart';
import 'package:sdd_assignment_2/GameBoard.dart';
import 'Building.dart';
import 'Player.dart';
import 'colours.dart' as colours;
import 'Firebase_options.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();

  static Player player = Player("name", [], 0);

  static int randomNum() {
    Random random = Random();
    int num = random.nextInt(5);
    return num;
  }

  static int num1 = 0;
  static int num2 = 0;
}

class _GamePageState extends State<GamePage> {
  final BoardSettings boardSettings = BoardSettings(cols: 10, rows: 10);
  //late Timer timer;
  late BoardTile boardTile;

  @override
  void initState() {
    super.initState();
    GamePage.player = Player("name", [], 0);
    //GamePage.randomizer();
    for (var i = 0; i < boardSettings.totalTiles(); i++) {
      GamePage.player.map.add("-");
    }
    print(GamePage.player.map);
    GamePage.num1 = GamePage.randomNum();
    GamePage.num2 = GamePage.randomNum();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
          title: 'Game Page',
          home: Scaffold(
            backgroundColor: colours.AppColor.background,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: colours.AppColor.background,
              centerTitle: true,
              flexibleSpace: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(
                      flex: 1,
                    ),
                    IconButton(
                      iconSize: 40,
                      icon: const Icon(Icons.close),
                      color: colours.AppColor.main,
                      onPressed: () async {
                        final postKey = FirebaseDatabase.instance
                            .ref()
                            .child('players')
                            .push()
                            .key;
                        FirebaseDatabase.instance
                            .ref('players/$postKey')
                            .set(GamePage.player.toJson())
                            .then((_) {
                          // Data saved successfully!
                          Navigator.pop(context);
                        }).catchError((error) {
                          print(error);
                          // The write failed...
                        });
                      },
                    ),
                    const Spacer(
                      flex: 5,
                    ),
                    Text(
                      'N.A.C',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        fontFamily: 'StickNoBills',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(
                      flex: 5,
                    ),
                    Visibility(
                      child: IconButton(
                        iconSize: 40,
                        icon: const Icon(Icons.info_outline),
                        color: colours.AppColor.main,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const AboutPage(), //goes to about page
                              ));
                        },
                      ),
                      maintainAnimation: true,
                      maintainSize: true,
                      maintainState: true,
                      visible: true,
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                  ],
                ),
              ),
            ),
            body: SafeArea(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  //alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.07,
                      MediaQuery.of(context).size.height * 0.05,
                      MediaQuery.of(context).size.width * 0.07,
                      MediaQuery.of(context).size.height * 0.05),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Card(
                              elevation: 0,
                              shadowColor: null,
                              color: colours.AppColor.buttonBackground,
                              child: SizedBox(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 10, 12, 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset(
                                        'assets/images/Point.png',
                                        width: 30,
                                        height: 30,
                                        fit: BoxFit.fitWidth,
                                      ),
                                      SizedBox(width: 10.0),
                                      Text(
                                        '190',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'StickNoBills',
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                          const Spacer(
                            flex: 1,
                          ),
                          Card(
                              elevation: 0,
                              shadowColor: null,
                              color: colours.AppColor.buttonBackground,
                              child: SizedBox(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 10, 12, 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'TURN  ${GamePage.player.turn}',
                                        style: const TextStyle(
                                          fontFamily: 'StickNoBills',
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                          const Spacer(
                            flex: 1,
                          ),
                          Card(
                              elevation: 0,
                              shadowColor: null,
                              color: colours.AppColor.buttonBackground,
                              child: SizedBox(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 10, 12, 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset(
                                        'assets/images/Coin.png',
                                        width: 30,
                                        height: 30,
                                        fit: BoxFit.fitWidth,
                                      ),
                                      SizedBox(width: 10.0),
                                      Text(
                                        '${GamePage.player.coin}',
                                        style: TextStyle(
                                          fontFamily: 'StickNoBills',
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 30.0)),
                      returnGameBoard(),

                      //SizedBox(height: 20.0),

                      Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: IntrinsicHeight(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              //randomizer here
                              randomizer(GamePage.num1),
                              // BuildingCard(),
                              Spacer(),
                              // BuildingCard(),
                              randomizer(GamePage.num2),
                            ],
                          )))
                    ],
                  )),
            ),
          )),
    );
  }

  Widget randomizer(int number) {
    Building building = Building(number);
    return Draggable<Building>(
      data: building,
      feedback: SizedBox(
        width: 40,
        height: 40,
        child: Center(
          child: Card(
              color: BuildingCard.returnColour(building.name),
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Center(
                  child:Image.asset('assets/images/${building.name}.png'),
                ),
              )
          ),
        ),
      ),
      childWhenDragging: const SizedBox(width: 20),
      child: SizedBox(
        width: MediaQuery.of(context).size.width*0.37,
        height: MediaQuery.of(context).size.width*0.37,
        child: Card(
            elevation: 10,
            shadowColor: Colors.grey,
            color: BuildingCard.returnColour(building.name),
            shape: RoundedRectangleBorder(
              //side: BorderSide(color: Colors.white70, width: 1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('assets/images/${building.name}.png'),
                      width: 70,
                      height: 70,
                    ),
                    Text(
                      building.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'StickNoBills',
                        fontWeight: FontWeight.bold,
                        color: colours.AppColor.background,
                      ),
                    )
                  ],
                )
            )
        ),
      ),
    );
  }

  Widget returnGameBoard() {
    return Expanded(
      //margin: const EdgeInsets.only(top: 10.0),
      child: Container(
        margin: const EdgeInsets.all(0.0),
        child: SizedBox(
          height: 400,
          child: GridView.count(
            crossAxisCount: boardSettings.cols,
            crossAxisSpacing: 3,
            mainAxisSpacing: 3,
            children: [
              for (var i = 0; i < boardSettings.totalTiles(); i++)
                returnBoardTile(i)
            ],
          ),
        ),
      ),
    );
  }

  Widget returnBoardTile(int index) {
    bool exist = false;
    String name = "";
    List<String> building = [
      'Park',
      'Industry',
      'Residential',
      'Road',
      'Commercial'
    ];
    return DragTarget<Building>(
      onAccept: (data) => setState(() {
        exist = GamePage.player.turn == 0
            ? true
            : rules(GamePage.player.map, index);
        name = data.name;
        exist ? GamePage.player.addItemToMap(index, name) : null;
        exist ? GamePage.player.addTurn() : null;
        exist ? GamePage.player.minusCoin() : null;
        if(exist){
          GamePage.num1 = GamePage.randomNum();
          GamePage.num2 = GamePage.randomNum();
        }
        //print(GamePage.player.map);
      }),
      builder: (context, accept, reject) {
        if (exist) {
          return returnBuildingTile(name);
        } else {
          if (building.contains(GamePage.player.map[index])) {
            return returnBuildingTile(GamePage.player.map[index]);
          } else {
            GamePage.player.addItemToMap(index, "-");
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              //child: Center(child: Text ("${widget.boardIndex}"),),
            );
          }
        }
      },
    );
  }

  Widget returnBuildingTile(String name) {
    return Container(
        color: BuildingCard.returnColour(name),
        child: Center(
          child: Image.asset('assets/images/$name.png'),
        ));
  }
}

bool rules(List<String> map,int i) {
  List<String> building = [
    'Park',
    'Industry',
    'Residential',
    'Road',
    'Commercial'
  ];
  //center index is either +1 -1 +10 -10
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
