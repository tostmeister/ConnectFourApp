import 'package:flutter/material.dart';
import 'package:flutter_project_connectfour1/src/BoardSettings.dart';
import 'package:flutter_project_connectfour1/src/board_state.dart';
import 'package:flutter_project_connectfour1/src/tile.dart';
import 'package:provider/provider.dart';

class boardTile extends StatefulWidget {
  final int indexBoard;
  final BoardSettings boardSettings;
  const boardTile({super.key,required this.indexBoard, required this.boardSettings});
  @override
  State<boardTile> createState() => _boardTileState();
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

class _boardTileState extends State<boardTile> {
  final Color color1 = HexColor.fromHex('#EFE696');
  final Color color2 = HexColor.fromHex('#EF9696');
  final Color color5 = HexColor.fromHex('#97B6C0');

  @override
  Widget build(BuildContext context) {
    final tile = Tile.fromBoardIndex(widget.indexBoard, widget.boardSettings);
    return InkResponse(
      onTap: () {
        Provider.of<BoardState>(context, listen: false).makeMove(tile);
      },
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          child: Consumer<BoardState>(
              builder: (context, boardState, child)  {
                return Container(
                  margin: EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: boardState.borderColor(tile),
                        width: 3),
                    color:boardState.tileColor(tile ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(child: Text('')),
                );
              }
          ),
        ),
      ),
    );
  }

}