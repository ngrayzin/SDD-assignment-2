import 'dart:ffi';

class Building{
  //final int index;
  final String name;
  final Map buildingList = {
    0 : "Park",
    1 : "Factory",
    2 : "House",
    3 : "Motorway",
    4 : "Shopping center"
  };
  Building({required this.name});
}


