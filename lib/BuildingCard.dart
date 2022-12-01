import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flame/flame.dart'; // ADDED FLAME INTO DART FILE
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart'; // ADDED GOOGLE FONTS
import 'package:sdd_assignment_2/BoardSettings.dart';
import 'package:sdd_assignment_2/BoardTile.dart';
import 'colours.dart' as colours;
import 'firebase_options.dart';

class BuildingCard extends StatefulWidget{
  const BuildingCard({Key? key}) : super (key:key);

  @override
  State<StatefulWidget> createState() => _BuildingCard();
}

class _BuildingCard extends State<BuildingCard> {
  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      data: 'road',
      feedback: SizedBox(
        width: 40,
        height: 40,
        child: Card(
            elevation: 0,
            shadowColor: Colors.grey,
            color: Colors.amber,
            child: Padding(
                padding: EdgeInsets.all(0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'P',
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
        ),
      ),
      child: Building(building: 'park'),
      childWhenDragging: const SizedBox(width: 20),
    );
  }
}

class Building extends StatelessWidget{
  const Building({key, required this.building}) : super(key:key);

  final String building;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: Card(
          elevation: 10,
          shadowColor: Colors.grey,
          color: colours.AppColor.main,
          child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/images/$building.png'),
                    width: 70,
                    height: 70,
                  ),
                  Text(
                    building,
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'StickNoBills',
                      fontWeight: FontWeight.bold,
                      color: colours.AppColor.background,
                    ),
                  )
                ],
              )
          )
      ),
    );
  }

}

