import 'package:flutter_project_connectfour1/src/BoardSettings.dart';

class Tile{
  final int col;
  final int row;

  Tile({required this.col, required this.row});

  factory Tile.fromBoardIndex(int boardIndex, BoardSettings setting){
    final col = (boardIndex % setting.cols).ceil() + 1;
    final row = setting.rows -((boardIndex+1)/setting.cols).ceil() + 1;
    return Tile(col: col, row: row);
  }

  @override
  int get hashCode => Object.hash(col, row);

  @override
  bool operator ==(Object other) {
    return other is Tile && other.col == col && other.row == row;
  }
}