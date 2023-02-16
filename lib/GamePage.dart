import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart'; // ADDED GOOGLE FONTS
import 'package:sdd_assignment_2/About.dart';
import 'package:sdd_assignment_2/BoardSettings.dart';
import 'Building.dart';
import 'EndGame.dart';
import 'Login.dart';
import 'Player.dart';
import 'colours.dart' as colours;


class GamePage extends StatefulWidget {
  const GamePage({super.key});
  static int value = 0;

  @override
  State<GamePage> createState() => _GamePageState();

  static Player player = Player(currentUser?.displayName, [], 0, 0);

  static int randomNum() {
    Random random = Random();
    int num = random.nextInt(5);
    return num;
  }

  static int num1 = 0;
  static int num2 = 0;
  static int row = 0;
  static int col = 0;
  static bool showboth = true;
  static int showeither = 0;
}

class _GamePageState extends State<GamePage> {
  AudioPlayer audioPlayer = AudioPlayer();
  final BoardSettings boardSettings =
      BoardSettings(cols: GamePage.player.level, rows: GamePage.player.level);

  @override
  void initState() {
    super.initState();
    GamePage.player =
        Player(currentUser?.displayName, [], 0, GamePage.player.level);
    GamePage.row = GamePage.player.level;
    GamePage.col = GamePage.player.level;
    GamePage.player.nerf();
    for (var i = 0; i < boardSettings.totalTiles(); i++) {
      GamePage.player.map.add("-");
    }
    GamePage.num1 = GamePage.randomNum();
    GamePage.num2 = GamePage.randomNum();
    while (GamePage.num1 == GamePage.num2) {
      GamePage.num1 = GamePage.randomNum();
    }
    //print(GamePage.player.level);
    loadSound();
  }

  void loadSound() async {
    audioPlayer.setPlaybackRate(2);
    audioPlayer.play(AssetSource("audio/lego.mp3"));
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
              centerTitle: true,
              elevation: 0,
              backgroundColor: colours.AppColor.background,
              flexibleSpace: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.12), // was 0.12
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
                      onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return saveGameMsg();
                        },
                      ),
                    ),
                    const Spacer(
                      flex: 5,
                    ),
                    const Text(
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
                          print("hello");
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                AboutPage(), //goes to about page
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
                      MediaQuery.of(context).size.height * 0.03, //was 0.05
                      MediaQuery.of(context).size.width * 0.07,
                      MediaQuery.of(context).size.height * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
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
                                      const SizedBox(width: 10.0),
                                      Text(
                                        '${GamePage.player.point}',
                                        textAlign: TextAlign.center,
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
                            ),
                          ),
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
                                      const SizedBox(width: 10.0),
                                      Text(
                                        '${GamePage.player.coin}',
                                        style: const TextStyle(
                                          fontFamily: 'StickNoBills',
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )),
                        ],
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                      returnGameBoard(),
                      const Spacer(
                        flex: 3,
                      ),

                      Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),

                          child: IntrinsicHeight(
                              child: options())),

                    ],
                  )),
            ),
          )),
    );
  }

  Widget options() {
    if (GamePage.showboth == true) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //randomizer here
          Visibility(
            child: randomizer0 (GamePage.num1),
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: true,
          ),
          // BuildingCard(),
          const Spacer(),
          // BuildingCard(),
          Visibility(
            child: randomizer1 (GamePage.num2),
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: true,
          ),
        ],
      );
    } else {
      //Random random = Random();
      //GamePage.showeither = random.nextInt(2);
      if (GamePage.showeither == 0) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //randomizer here
            Visibility(
              child: randomizer0 (GamePage.num1),
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: true,
            ),
            // BuildingCard(),
            const Spacer(),
            // BuildingCard(),
            Visibility(
              child: randomizer1 (GamePage.num2),
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: false,
            ),
          ],
        );
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //randomizer here
            Visibility(
              child: randomizer0 (GamePage.num1),
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: false,
            ),
            // BuildingCard(),
            const Spacer(),
            // BuildingCard(),
            Visibility(
              child: randomizer1 (GamePage.num2),
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: true,
            ),
          ],
        );
      }
    }
  }

  AlertDialog saveGameMsg() {
    AlertDialog alert = AlertDialog(
      insetPadding: EdgeInsets.all(10),
      title: const Text(
        'SAVE GAME?',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 50,
          fontFamily: 'StickNoBills',
          fontWeight: FontWeight.bold,
        ),
      ),
      shape: RoundedRectangleBorder(
          side: BorderSide(width: MediaQuery.of(context).size.width),
          borderRadius: BorderRadius.circular(12)),
      actionsAlignment: MainAxisAlignment.center,
      actions: <Widget>[
        TextButton(
          onPressed: () {
            FirebaseDatabase.instance
                .ref('players/${currentUser?.uid}/saveGame')
                .set(GamePage.player.ToJson())
                .then((_) {
              // Data saved successfully!
              Navigator.popUntil(context, (route) => route.isFirst);
            }).catchError((error) {
              print(error);
              // The write failed...
            });
          },
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(const Size(80, 50)),
            padding:
                MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(5)),
            foregroundColor: MaterialStateProperty.all<Color>(
                colours.AppColor.buttonBackground),
            backgroundColor:
                MaterialStateProperty.all<Color>(colours.AppColor.main),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
          ),
          child: const Text('YES',
              style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'StickNoBills',
                  fontWeight: FontWeight.bold)),
        ),
        const SizedBox(width: 25),
        TextButton(
            onPressed: () =>
                Navigator.popUntil(context, (route) => route.isFirst),
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(const Size(80, 20)),
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.all(5)),
              foregroundColor: MaterialStateProperty.all<Color>(
                  colours.AppColor.buttonBackground),
              backgroundColor:
                  MaterialStateProperty.all<Color>(colours.AppColor.main),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
            child: const Text('NO',
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'StickNoBills',
                    fontWeight: FontWeight.bold))),
        const Padding(padding: EdgeInsets.only(bottom: 85)),
      ],
    );
    return alert;
  }

  Widget randomizer0(int number) {
    Building building = Building(number);
    return Draggable<Building>(
      data: building,
      dragAnchorStrategy:
          (Draggable<Object> _, BuildContext __, Offset ___) =>
      const Offset(20, 20), // here
      feedback: SizedBox(
        width: 40,
        height: 40,
        child: Center(
          child: Card(
              color: colours.AppColor.background,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Center(
                  child: Image.asset('assets/images/${building.name}.png'),
                ),
              )),
        ),
      ),
      childWhenDragging: const SizedBox(
        width: 20,
      ),
      onDragStarted: () {
        setState(() {
          GamePage.showboth = false;
          GamePage.showeither = 0;
        });
      },
      onDragCompleted: () {
        setState(() {
          GamePage.showboth = true;
        });
      },
      onDraggableCanceled: (Velocity velocity, Offset offset) {
        setState(() {
          GamePage.showboth = true;
        });
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.37,
        height: MediaQuery.of(context).size.width * 0.37,
        child: Card(
            elevation: 8,
            shadowColor: colours.AppColor.main,
            color: colours.AppColor.buttonBackground,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: colours.AppColor.main, width: 2),
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
                    const SizedBox(height: 5.0),
                    Text(
                      building.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'StickNoBills',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                  ],
                ))),
      ),
    );
  }

  Widget randomizer1(int number) {
    Building building = Building(number);
    return Draggable<Building>(
      data: building,
      dragAnchorStrategy:
          (Draggable<Object> _, BuildContext __, Offset ___) =>
      const Offset(20, 20), // here
      feedback: SizedBox(
        width: 40,
        height: 40,
        child: Center(
          child: Card(
              color: colours.AppColor.background,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Center(
                  child: Image.asset('assets/images/${building.name}.png'),
                ),
              )),
        ),
      ),
      childWhenDragging: const SizedBox(
        width: 20,
      ),
      onDragStarted: () {
        setState(() {
          GamePage.showboth = false;
          GamePage.showeither = 1;
        });
      },
      onDragCompleted: () {
        setState(() {
          GamePage.showboth = true;
        });
      },
      onDraggableCanceled: (Velocity velocity, Offset offset) {
        setState(() {
          GamePage.showboth = true;
        });
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.37,
        height: MediaQuery.of(context).size.width * 0.37,
        child: Card(
            elevation: 8,
            shadowColor: colours.AppColor.main,
            color: colours.AppColor.buttonBackground,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: colours.AppColor.main, width: 2),
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
                    const SizedBox(height: 5.0),
                    Text(
                      building.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'StickNoBills',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                  ],
                ))),
      ),
    );
  }

  Widget returnGameBoard() {
    return Container(
        margin: const EdgeInsets.all(0.0),
        child: SizedBox(
          height: 350,
          child: GridView.count(
            //padding: EdgeInsets.zero,
            crossAxisCount: boardSettings.cols,
            crossAxisSpacing: 3,
            mainAxisSpacing: 3,
            children: [
              for (var i = 0; i < boardSettings.totalTiles(); i++)
                returnBoardTile(i)
            ],
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
        exist ? loadSound() : null;
        exist ? GamePage.player.addItemToMap(index, name) : null;
        exist ? GamePage.player.addTurn() : null;
        exist ? GamePage.player.minusCoin() : null;
        exist ? GamePage.player.calculatePoints(GamePage.row) : null;
        exist ? GamePage.player.nerf() : null;
        if (GamePage.player.coin == 0 || GamePage.player.endGrid() == true){
          Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    EndGame(GamePage.player), //goes to end game page
              ));
        }
        if (exist) {
          GamePage.num1 = GamePage.randomNum();
          GamePage.num2 = GamePage.randomNum();
          // Loop to check if it is the same value, change if it's same value
          while (GamePage.num1 == GamePage.num2) {
            GamePage.num1 = GamePage.randomNum();
          }
        }
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
              decoration: BoxDecoration(
                color: colours.AppColor.main,
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
        color: colours.AppColor.background,
        child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Center(
              child: Image.asset('assets/images/$name.png'),
            )));
  }
}

bool rules(List<String> map, int i) {
  List<String> building = [
    'Park',
    'Industry',
    'Residential',
    'Road',
    'Commercial'
  ];
  //center index is either +1 -1 +10 -10
  if (building.contains(map[i])) {
    return false;
  } else if (map.asMap().containsKey(i - GamePage.row) &&
      map[i - GamePage.row] != "-") {
    //check if there is smt below
    return true;
  } else if (map.asMap().containsKey(i + GamePage.row) &&
      map[i + GamePage.row] != "-") {
    //check if there is smt on top
    return true;
  } else if (map.asMap().containsKey(i - 1) &&
      map[i - 1] != "-" &&
      i % GamePage.row != 0) {
    //check if there is smt on the left
    return true;
  } else if (map.asMap().containsKey(i + 1) &&
      map[i + 1] != "-" &&
      (i + 1) % GamePage.row != 0) {
    //check if there is smt on the right
    return true;
  } else {
    return false;
  }
}
