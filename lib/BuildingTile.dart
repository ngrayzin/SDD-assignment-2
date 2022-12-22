import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flame/flame.dart'; // ADDED FLAME INTO DART FILE
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart'; // ADDED GOOGLE FONTS
import 'package:sdd_assignment_2/BoardSettings.dart';
import 'BuildingCard.dart';
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
    return Container(
        color: BuildingCard.returnColour(widget.name),
        child: Center(
          child:Image.asset('assets/images/${widget.name}.png'),
        )
    );
  }
}
