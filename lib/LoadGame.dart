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
import 'colours.dart' as colours;
import 'Firebase_options.dart';
import 'package:flutter/src/widgets/container.dart';

class LoadGame extends StatefulWidget{
  const LoadGame({super.key});

  @override
  State<LoadGame> createState() => _LoadGameState();
}

class _LoadGameState extends State<LoadGame>{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Load Game Page',
      home: Scaffold(
        backgroundColor: colours.AppColor.background,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            bottomOpacity: 0,
            centerTitle: true,
            flexibleSpace: Padding(
              padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
              child : Row(
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
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(
                    flex: 5,
                  ),
                  Text(
                    'LOAD GAME',
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
                    visible: false,
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
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(25, 60, 25, 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 5.0),
                  child: Text(
                    "Enter Your Name Below:",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'StickNoBills',
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 12.0),
                  child: TextField(
                    maxLines: 1,

                    style: TextStyle(
                        fontFamily: 'StickNoBills',
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 12.0),
                      filled: true,
                      fillColor: colours.AppColor.buttonBackground,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: colours.AppColor.main,
                          width: 3,
                        )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: colours.AppColor.main,
                          width: 3,
                        )
                      ),
                      labelText: 'Player Name',
                      labelStyle: TextStyle(
                        fontFamily: 'StickNoBills',
                        color: Colors.grey,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      )
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 50.0, left: 5.0),
                  child: Text(
                    "Recent Game Played:",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'StickNoBills',
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Container( //previous game card
                  margin: EdgeInsets.only(top: 12.0),
                  padding: EdgeInsets.all(8.0),
                  width: MediaQuery.of(context).size.width,
                  //height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: colours.AppColor.buttonBackground,
                    border: Border.all(
                      width: 3.0,
                      color: colours.AppColor.main,
                    ),

                  ),

                  child: Column(
                    children: [
                      Container(

                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width * 0.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.black,

                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top:5.0)),
                      Row( //game details (points + turns + money)
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Card(
                              elevation: 0,
                              shadowColor: null,
                              color: colours.AppColor.main,
                              child: SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset(
                                        'assets/images/point.png',
                                        width: 20,
                                        height: 20,
                                        fit: BoxFit.fitWidth,
                                      ),
                                      SizedBox(width: 12.0),
                                      Text(
                                        '190',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'StickNoBills',
                                          color: colours.AppColor.background,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
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
                              color: colours.AppColor.main,
                              child: SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset(
                                        'assets/images/point.png',
                                        width: 20,
                                        height: 20,
                                        fit: BoxFit.fitWidth,
                                      ),
                                      SizedBox(width: 12.0),
                                      Text(
                                        '190',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'StickNoBills',
                                          color: colours.AppColor.background,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
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
                              color: colours.AppColor.main,
                              child: SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset(
                                        'assets/images/point.png',
                                        width: 20,
                                        height: 20,
                                        fit: BoxFit.fitWidth,
                                      ),
                                      SizedBox(width: 12.0),
                                      Text(
                                        '190',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'StickNoBills',
                                          color: colours.AppColor.background,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}