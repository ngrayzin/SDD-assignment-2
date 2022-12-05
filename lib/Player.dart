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


class Player{
  final String name;
  final List<String> map = [];
  final List<List<String>> ruleMap = [];
  Player(this.name);
}
