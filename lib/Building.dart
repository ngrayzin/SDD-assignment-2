import 'dart:ffi';
import 'dart:ui';
import 'colours.dart' as colours;

class Building{
  //final int index;
  final String name;
  final Map buildingList = {
    0 : "Park",
    1 : "Commercial",
    2 : "Industry",
    3 : "Residential",
    4 : "Road"
  };
  Building({required this.name});

}


