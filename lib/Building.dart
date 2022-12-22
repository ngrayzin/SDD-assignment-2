import 'dart:ffi';
import 'dart:ui';
import 'colours.dart' as colours;

class Building {
  late int index;
  late String name;
  final Map buildingList = {
    0: "Park",
    1: "Commercial",
    2: "Industry",
    3: "Residential",
    4: "Road"
  };
  Building(int index) {
    this.index = index;
    this.name = buildingList[index];
  }
}
