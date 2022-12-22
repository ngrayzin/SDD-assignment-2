import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flame/flame.dart'; // ADDED FLAME INTO DART FILE
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart'; // ADDED GOOGLE FONTS
import 'package:sdd_assignment_2/BoardSettings.dart';
import 'package:sdd_assignment_2/BoardTile.dart';
import 'package:sdd_assignment_2/Building.dart';
import 'colours.dart' as colours;
import 'Firebase_options.dart';

class BuildingCard extends StatefulWidget {
  const BuildingCard({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BuildingCard();

  static returnColour(String building) {
    switch (building) {
      case "Park":
        return colours.AppColor.parkColor;
      case "Commercial":
        return colours.AppColor.commercialColor;
      case "Industry":
        return colours.AppColor.industryColor;
      case "Residential":
        return colours.AppColor.residentialColor;
      case "Road":
        return colours.AppColor.roadColor;
    }
    return colours.AppColor.main;
  }
}

class _BuildingCard extends State<BuildingCard> {
  final Map buildingList = {
    0: "Park",
    1: "Commercial",
    2: "Industry",
    3: "Residential",
    4: "Road"
  };
  Building building = Building(1);
  @override
  Widget build(BuildContext context) {
    return Draggable<Building>(
      data: building,
      feedback: SizedBox(
        width: 40,
        height: 40,
        child: Center(
          child: Card(
              color: BuildingCard.returnColour(building.name),
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Center(
                  child: Image.asset('assets/images/${building.name}.png'),
                ),
              )),
        ),
      ),
      childWhenDragging: const SizedBox(width: 20),
      child: _Building(building: building.name),
    );
  }
}

class _Building extends StatelessWidget {
  const _Building({key, required this.building}) : super(key: key);

  final String building;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.37,
      height: MediaQuery.of(context).size.width * 0.37,
      child: Card(
          elevation: 10,
          shadowColor: Colors.grey,
          color: BuildingCard.returnColour(building),
          shape: RoundedRectangleBorder(
            //side: BorderSide(color: Colors.white70, width: 1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
              padding: const EdgeInsets.all(10.0),
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
              ))),
    );
  }
}
