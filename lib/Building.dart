import 'dart:ffi';

class Building{
  //final int index;
  final String name;
  final Map buildingList = {
    0 : "park",
    1 : "factory",
    2 : "house",
    3 : "motorway",
    4 : "shopping center"
  };
  Building({required this.name});
}


