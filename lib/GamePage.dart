import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flame/flame.dart'; // ADDED FLAME INTO DART FILE
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart'; // ADDED GOOGLE FONTS
import 'package:sdd_assignment_2/BoardSettings.dart';
import 'package:sdd_assignment_2/BuildingCard.dart';
import 'package:sdd_assignment_2/GameBoard.dart';
import 'package:sdd_assignment_2/GameOver.dart';
import 'colours.dart' as colours;
import 'Firebase_options.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();

}

class _GamePageState extends State<GamePage>{
  final BoardSettings boardSettings = BoardSettings(cols: 10, rows: 10);
  @override

  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Game Page',
      home: Scaffold(
        backgroundColor: colours.AppColor.background,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: AppBar (
            elevation: 0,
            backgroundColor: Colors.transparent,
            bottomOpacity: 0,
            centerTitle: true,
            flexibleSpace: Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(
                    flex: 1,
                  ),
                  IconButton(
                    iconSize: 40,
                    icon: const Icon(Icons.info_outline),
                    color: colours.AppColor.main,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GameOver(),
                          ));
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
                      icon: const Icon(Icons.close),
                      color: colours.AppColor.main,
                      onPressed: () => Navigator.pop(context),
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
        ),
        body: SafeArea(
          child: Container (
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              //alignment: Alignment.center,
              padding:  EdgeInsets.fromLTRB(20,10,20,20),
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
                                  SizedBox(width: 10.0),
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
                  GameBoard(boardSettings: boardSettings),

                  //SizedBox(height: 20.0),

                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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


