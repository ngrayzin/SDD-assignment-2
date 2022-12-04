class Player {
  final String name;
  final List<String> map;
  int turn = 0;

  Player(this.name, this.map);
  void addItemToMap(int i, String n) {
    map[i] = n;
  }
  void addTurn() {
    turn++;
  }

}






