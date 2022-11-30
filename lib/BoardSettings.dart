class BoardSettings {
  final int rows;
  final int cols;

  const BoardSettings({required this.cols, required this.rows});

  int totalTiles(){
    return rows*cols;
  }
}