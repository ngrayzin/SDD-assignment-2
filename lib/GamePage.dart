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
import 'Player.dart';
import 'colours.dart' as colours;
import 'Firebase_options.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();

  static Player player = Player("name", [], 0);


  static void randomizer(){
    Random random = Random();
    int randomNumber1 = random.nextInt(5);
    int randomNumber2 = random.nextInt(5);
    print(randomNumber1);
    print(randomNumber2);
  }
}

class _GamePageState extends State<GamePage> {

  final BoardSettings boardSettings = BoardSettings(cols: 10, rows: 10);
  late Timer timer;
  late BoardTile boardTile;

  refresh(){
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    GamePage.player = Player("name", [], 0);
    GamePage.randomizer();
    timer = Timer.periodic(const Duration(milliseconds: 5), (_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                      final postKey =
                          FirebaseDatabase.instance.ref().child('players').push().key;
                      FirebaseDatabase.instance
                          .ref('players/$postKey')
                          .set(GamePage.player.toJson())
                          .then((_) {
                            // Data saved successfully!
                            Navigator.pop(context);
                          })
                          .catchError((error) {
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
                    GameBoard(
                      boardSettings: boardSettings,
                      player: GamePage.player,
                    ),

                    //SizedBox(height: 20.0),

                    Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: IntrinsicHeight(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            //randomizer here
                            BuildingCard(),
                            Spacer(),
                            BuildingCard(),
                          ],
                        )))
                  ],
                )),
          ),
        ));
  }
}

