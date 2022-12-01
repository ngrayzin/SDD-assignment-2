import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flame/flame.dart'; // ADDED FLAME INTO DART FILE
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart'; // ADDED GOOGLE FONTS
import 'package:sdd_assignment_2/BoardSettings.dart';
import 'colours.dart' as colours;
import 'Firebase_options.dart';


class BuildingTile extends StatefulWidget {
  final int boardIndex;
  final BoardSettings boardSettings;
  final String name;
  const BuildingTile({Key? key, required this.boardIndex, required this.boardSettings, required this.name}) : super (key: key);


  @override
  State<BuildingTile> createState() => _BuildingTile();

}

class _BuildingTile extends State<BuildingTile>{
  @override
  Widget build(BuildContext context){
    return Card(
        elevation: 0,
        shadowColor: Colors.grey,
        color: Colors.amber,
        child: Padding(
            padding: EdgeInsets.all(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(
                    fontSize: 10,
                    fontFamily: 'StickNoBills',
                    fontWeight: FontWeight.bold,
                    color: colours.AppColor.background,
                  ),
                )
              ],
            )
        )
    );
  }
}