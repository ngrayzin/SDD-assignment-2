import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flame/flame.dart'; // ADDED FLAME INTO DART FILE
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart'; // ADDED GOOGLE FONTS
import 'colours.dart' as colours;
import 'Firebase_options.dart';
import 'Player.dart';

class LeaderBoardCard extends StatelessWidget {
  // final Player player;
  // const LeaderBoardPage({Key? key, required this.player}) : super(key: key);

  const LeaderBoardCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 2, 10, 5),
      padding: const EdgeInsets.fromLTRB(20.0, 5, 20, 5),
      height: 60,
      decoration: BoxDecoration(
        color: colours.AppColor.buttonBackground,
        border: Border.all(
          color: colours.AppColor.main,
          width: 3.0,
        ),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
          "Player 24908", //Replace with player.name
          style: TextStyle(
              fontSize: 24, color: Colors.white, fontFamily: 'StickNoBills'),
          textAlign: TextAlign.center,
        ),
        Text(
          "490", //Replace with player.points
          style: TextStyle(
              fontSize: 24, color: Colors.white, fontFamily: 'StickNoBills'),
          textAlign: TextAlign.center,
        ),
      ]),
    );
  }
}
