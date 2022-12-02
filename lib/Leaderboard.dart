import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flame/flame.dart'; // ADDED FLAME INTO DART FILE
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart'; // ADDED GOOGLE FONTS
import 'colours.dart' as colours;
import 'Firebase_options.dart';

class LeaderBoard extends StatelessWidget {
  const LeaderBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colours.AppColor.background,
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          elevation: 0.0,
          title: const Text(
            "LEADERBOARD",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                color: Colors.white,
                fontFamily: 'StickNoBills'),
            textAlign: TextAlign.center,
          )),
      body: Center(
          child: Column(
        children: [
          /*Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            padding: const EdgeInsets.all(5.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: const Text(
              "LEADERBOARD",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 48,
                  color: Colors.white,
                  fontFamily: 'StickNoBills'),
              textAlign: TextAlign.center,
            ),
          ),*/ //Container for leaderboard title
          Container(
            margin: const EdgeInsets.fromLTRB(10.0, 10, 10, 2),
            padding: const EdgeInsets.all(5.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Position",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontFamily: 'StickNoBills'),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Name",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontFamily: 'StickNoBills'),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Points",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontFamily: 'StickNoBills'),
                    textAlign: TextAlign.center,
                  ),
                ]),
          ), //Container for Leaderboard Title
          Container(
            margin: const EdgeInsets.fromLTRB(5.0, 2, 5, 5),
            padding: const EdgeInsets.fromLTRB(20.0, 5, 20, 5),
            decoration: BoxDecoration(
              color: colours.AppColor.buttonBackground,
              border: Border.all(
                color: colours.AppColor.main,
                width: 3.0,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "1st",
                    style: TextStyle(
                      color: colours.AppColor.main,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      fontFamily: 'StickNoBills',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Player 24908",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontFamily: 'StickNoBills'),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "490",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontFamily: 'StickNoBills'),
                    textAlign: TextAlign.center,
                  ),
                ]),
          ), //Container for player leaderboard attributes
          Container(
            margin: const EdgeInsets.fromLTRB(5.0, 2, 5, 5),
            padding: const EdgeInsets.fromLTRB(20.0, 5, 20, 5),
            decoration: BoxDecoration(
              color: colours.AppColor.buttonBackground,
              border: Border.all(
                color: colours.AppColor.main,
                width: 3.0,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "2nd",
                    style: TextStyle(
                      color: colours.AppColor.main,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      fontFamily: 'StickNoBills',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Rayzin",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontFamily: 'StickNoBills'),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "475",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontFamily: 'StickNoBills'),
                    textAlign: TextAlign.center,
                  ),
                ]),
          ),
        ],
      )),
    );
  }
}
