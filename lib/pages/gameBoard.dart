import 'package:flutter/material.dart';
import 'package:flutter_project_connectfour1/src/BoardSettings.dart';
import 'package:flutter_project_connectfour1/src/BoardTile.dart';

class GameBoard extends StatefulWidget {
  final BoardSettings boardSettings;
  const GameBoard({super.key, required this.boardSettings});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 400,
      child: GridView.count(
        crossAxisCount: widget.boardSettings.cols,
        children: [
          for (var i=0; i < widget.boardSettings.totalTitles(); i++)
            boardTile(indexBoard: i, boardSettings: widget.boardSettings)
        ],
      ),
    );
  }
}
