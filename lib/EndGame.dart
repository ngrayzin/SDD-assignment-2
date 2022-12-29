import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flame/flame.dart'; // ADDED FLAME INTO DART FILE
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart'; // ADDED GOOGLE FONTS
import 'package:sdd_assignment_2/About.dart';
import 'package:sdd_assignment_2/BoardSettings.dart';
import 'package:sdd_assignment_2/BoardTile.dart';
import 'package:sdd_assignment_2/BuildingCard.dart';
import 'package:sdd_assignment_2/GameBoard.dart';
import 'package:sdd_assignment_2/GameLevel.dart';
import 'package:sdd_assignment_2/GamePage.dart';
import 'package:sdd_assignment_2/PopUpMessage.dart';
import 'Building.dart';
import 'MainMenu.dart';
import 'Player.dart';
import 'colours.dart' as colours;
import 'Firebase_options.dart';
import 'package:flutter/src/widgets/container.dart';

class EndGame extends StatefulWidget {
  final Player player ;
  const EndGame(this.player);

  @override
  State<StatefulWidget> createState() => EndGameState();
}


class EndGameState extends State<EndGame> {
  //int level;
  //EndGameState(this.level);
  @override
  void initState() {
    super.initState();
    print("please work");
    print(widget.player.level);
  }

  late BoardSettings boardSettings = BoardSettings(cols: widget.player.level, rows: widget.player.level);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'End Game',
      home: Scaffold(
        backgroundColor: colours.AppColor.background,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: colours.AppColor.background,
          flexibleSpace: Padding(
            padding: EdgeInsets.only(
                top: MediaQuery
                    .of(context)
                    .size
                    .width * 0.15), // was 0.12
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

                  onPressed: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return saveGameMsg();
                          });
                    });
                  }),
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
                    onPressed: () {},
                  ),
                  maintainAnimation: true,
                  maintainSize: true,
                  maintainState: true,
                  visible: false,
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
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height,
            //alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(
                MediaQuery
                    .of(context)
                    .size
                    .width * 0.07,
                MediaQuery
                    .of(context)
                    .size
                    .height * 0.03, //was 0.05
                MediaQuery
                    .of(context)
                    .size
                    .width * 0.07,
                MediaQuery
                    .of(context)
                    .size
                    .height * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                  child: Text(
                    'THE GAME HAS ENDED!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      letterSpacing: 1,
                      fontFamily: 'StickNoBills',
                      color: colours.AppColor.main,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: colours.AppColor.buttonBackground,
                      border: Border.all(width: 3.0 ,color: colours.AppColor.main)
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3.0),
                    child: returnGameBoard(),
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Card(
                  elevation: 0,
                  shadowColor: null,
                  color: colours.AppColor.background,
                  child: Container(
                    width:  MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: colours.AppColor.buttonBackground,
                    ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'FINAL SCORE: ',
                            style: TextStyle(
                              fontFamily: 'StickNoBills',
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            ' ${widget.player.turn}',
                            style: TextStyle(
                              fontFamily: 'StickNoBills',
                              color: colours.AppColor.main,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        widget.player.saveGame();
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            widget.player.map = [];
                            widget.player.coin = 0;
                            widget.player.turn = 0;
                            widget.player.point = 0;
                          return const GameLevel();
                          }));
                      },
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: const BorderSide(color: Colors.transparent)
                              )
                          ),
                          backgroundColor:
                          MaterialStateProperty.all<Color>(colours.AppColor.main),
                          side: MaterialStateProperty.all<BorderSide>(BorderSide.none)),
                      child: Container(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 8.0),
                          child: Text(
                              "SAVE GAME & START NEW GAME",
                              style: TextStyle(
                                fontFamily: 'StickNoBills',
                                color: colours.AppColor.background,
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  AlertDialog saveGameMsg(){
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
          onPressed: (){
            FirebaseDatabase.instance
                .ref('players/${currentUser?.uid}')
                .set(widget.player.saveGameToJson())
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
            onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
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


  Widget returnGameBoard() {
    return Expanded(
      //margin: const EdgeInsets.only(top: 10.0),
      child: Container(
        margin: const EdgeInsets.all(0.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.width * (1-0.14) - 12.0,
          child: GridView.count(
            //padding: EdgeInsets.zero,
            crossAxisCount: widget.player.level,
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
        exist = widget.player.turn == 0
            ? true
            : rules(widget.player.map, index);
        name = data.name;
      }),
      builder: (context, accept, reject) {
        if (exist) {
          return returnBuildingTile(name);
        } else {
          if (building.contains(widget.player.map[index])) {
            return returnBuildingTile(widget.player.map[index]);
          } else {
            widget.player.addItemToMap(index, "-");
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
        color: colours.AppColor.background,
        child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Center(
              child: Image.asset('assets/images/$name.png'),
            )
        )
    );
  }
}
