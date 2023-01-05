import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flame/flame.dart'; // ADDED FLAME INTO DART FILE
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart'; // ADDED GOOGLE FONTS
import 'package:sdd_assignment_2/About.dart';
import 'package:sdd_assignment_2/BoardSettings.dart';
import 'package:sdd_assignment_2/GameLevel.dart';
import 'package:sdd_assignment_2/GamePage.dart';
import 'package:sdd_assignment_2/PopUpMessage.dart';
import 'Building.dart';
import 'Login.dart';
import 'MainMenu.dart';
import 'Player.dart';
import 'colours.dart' as colours;
import 'Firebase_options.dart';
import 'package:flutter/src/widgets/container.dart';

import 'main.dart';

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
  void initState(){
    super.initState();
    print("object");
    print(widget.player.point);
    widget.player.highscore(widget.player.point, widget.player.level).then((value){
      print("value");
      if(value){
        print("asdauifvggfwoeufbeg");
        Fluttertoast.showToast(
            msg: "NEW HIGH SCORE!",
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    });
  }

  late BoardSettings boardSettings = BoardSettings(cols: widget.player.level, rows: widget.player.level);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
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
                      .width * 0.12), // was 0.12
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(
                    flex: 5,
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
                      .height * 0.04),
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
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                              ' ${widget.player.point}',
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              widget.player.saveGame(widget.player.point, widget.player.level).then((value){
                                Navigator.popUntil(context, (route) => route.isFirst);
                                /*Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                const GameLevel()), (Route<dynamic> route) => false);*/
                              });
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
                                padding: const EdgeInsets.only(top: 10.0, bottom: 8.0, right: 2, left: 2),
                                child: Text(
                                    "SAVE SCORE",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'StickNoBills',
                                      color: colours.AppColor.background,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              DatabaseReference remove = FirebaseDatabase.instance.ref('players/${currentUser?.uid}/saveGame');
                              remove.set(null).then((value) => Navigator.popUntil(context, (route) => route.isFirst));
                              //Navigator.popUntil(context, (route) => route.isFirst);
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
                              padding: const EdgeInsets.only(top: 10.0, bottom: 8.0, right: 0, left: 0),
                              child: Text(
                                "DISCARD SCORE",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'StickNoBills',
                                  color: colours.AppColor.background,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget returnGameBoard() {
    return Container(
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
