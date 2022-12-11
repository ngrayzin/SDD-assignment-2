import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flame/flame.dart'; // ADDED FLAME INTO DART FILE
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart'; // ADDED GOOGLE FONTS
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

  void x(Function widgetSetState){
    //Your code
    widgetSetState();
  }
}

class _GamePageState extends State<GamePage>{
  final BoardSettings boardSettings = BoardSettings(cols: 10, rows: 10);
  late Timer timer;
  late BoardTile boardTile;
  @override
  void initState(){
    super.initState();
    GamePage.player =Player("name", [], 0);
    timer = Timer.periodic(const Duration(milliseconds: 5), (_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Game Page',
      home: Scaffold(
        backgroundColor: colours.AppColor.background,
        appBar: AppBar (
            elevation: 0,
            backgroundColor: colours.AppColor.background,
            centerTitle: true,
            leading: IconButton(
              iconSize: 50,
              icon: const Icon(Icons.info_outline),
              color: colours.AppColor.main,
              onPressed: (){},
            ),
            title: const Text(
              'N.A.C',
              style: TextStyle(
                fontSize: 50,
                fontFamily: 'StickNoBills',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            actions: <Widget>[
              IconButton(
                iconSize: 50,
                icon: const Icon(Icons.close),
                color: colours.AppColor.main,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        body: SafeArea(
          child: Container (
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              //alignment: Alignment.center,
              padding:  EdgeInsets.fromLTRB(10,30,10,20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget> [
                      Card(
                          elevation: 0,
                          shadowColor: null,
                          color: colours.AppColor.buttonBackground,
                          child: SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset(
                                          'assets/images/point.png',
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
                          )
                      ),
                      Text(
                        'TURN ${GamePage.player.turn}',
                        style: const TextStyle(
                        fontFamily: 'StickNoBills',
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.normal,
                        ),
                      ),
                      Card(
                          elevation: 0,
                          shadowColor: null,
                          color: colours.AppColor.buttonBackground,
                          child: SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    'assets/images/coin.png',
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.fitWidth,
                                  ),
                                  //SizedBox(width: 10.0),
                                  Text(
                                    '16',
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
                          )
                      ),
                    ],
                  ),
                  GameBoard(boardSettings: boardSettings, player: GamePage.player,),

                  //SizedBox(height: 20.0),

                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //randomizer here
                        BuildingCard(),
                        BuildingCard(),
                      ],
                    )
                  )
                ],
              )
          ),
        ),
      )
    );
  }

}

