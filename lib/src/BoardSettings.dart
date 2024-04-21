class BoardSettings{
  final int rows;
  final int cols;
  const BoardSettings({required this.rows, required this.cols});

  int totalTitles() {
    return cols * rows;
  }

  int winCondition() {
    return 4;
  }
}