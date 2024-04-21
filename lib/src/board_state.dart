import 'package:flutter/material.dart';
import 'package:flutter_project_connectfour1/src/BoardSettings.dart';
import 'package:flutter_project_connectfour1/src/tile.dart';

enum TileOwner{
  blank,
  player1,
  player2
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

class BoardState extends ChangeNotifier{
  final BoardSettings boardSettings;
  final List<Tile> playerTaken1 = [];
  final List<Tile> playerTaken2 = [];
  final Color color1 = HexColor.fromHex('#EFE696');
  final Color color2 = HexColor.fromHex('#EF9696');
  final Color color5 = HexColor.fromHex('#97B6C0');
  final Color color6 = HexColor.fromHex('#ADEF96');
  final Color color7 = HexColor.fromHex('#6CC775');
  final Color color8 = HexColor.fromHex('#C76C6C');
  final Color color9 = HexColor.fromHex('#C7B86C');

  List<Tile> winTiles = [];
  int step = 1;
  int winPlayer = 0;

  BoardState({required this.boardSettings});

  final ChangeNotifier playerWon = ChangeNotifier();

  Color tileColor(tile){
    if (winTiles.contains(tile)) {
      return color6;
    }
    else if(getTileOwner(tile)==TileOwner.player1){
      return color2;
    }
    else if(getTileOwner(tile)==TileOwner.player2){
      return color1;
    }
    else {
      return Colors.white;
    }
  }
  Color borderColor(tile){
    if (winTiles.contains(tile)) {
      return color7;
    }
    else if(getTileOwner(tile)==TileOwner.player1){
      return color8;
    }
    else if(getTileOwner(tile)==TileOwner.player2){
      return color9;
    }
    else {
      return color5;
    }
  }

  void clearBoard(){
    playerTaken1.clear();
    playerTaken2.clear();
    winTiles.clear();
    notifyListeners();
  }

  Future<void> makeMove(Tile tile) async {
    if(step == 1){
      Tile? newTile = evaluateMove(tile);
      if (newTile == null) {
        notifyListeners();
        return;
      }

      playerTaken1.add(newTile);
      step = 2;
      notifyListeners();

      bool didPlayer1Win = checkWin(newTile);
      if (didPlayer1Win == true) {
        playerWon.notifyListeners();
        notifyListeners();
        return;
      }
      notifyListeners();
    }
    else if(step == 2){
      Tile? newTile = evaluateMove(tile);
      if (newTile == null) {
        notifyListeners();
        return;
      }

      notifyListeners();
      playerTaken2.add(newTile);
      step = 1;

      bool didPlayer2Win = checkWin(newTile);
      if (didPlayer2Win == true) {
        playerWon.notifyListeners();
        notifyListeners();
        return;
      }
      notifyListeners();
    }
    notifyListeners();
  }


  Tile? evaluateMove(Tile tile) {
    for (var bRow = 1; bRow < boardSettings.rows + 1; bRow++) {
      var evalTile = Tile(col: tile.col, row: bRow);
      if (getTileOwner(evalTile) == TileOwner.blank) {
        return evalTile;
      }
    }
    return null;
  }

  TileOwner getTileOwner(Tile tile){
    if(playerTaken1.contains(tile)){
      return TileOwner.player1;
    }
    else if(playerTaken2.contains(tile)){
      return TileOwner.player2;
    }
    else {
      return TileOwner.blank;
    }
  }

  bool checkWin(Tile playTile) {
    var takenTiles = (getTileOwner(playTile) == TileOwner.player1) ? playerTaken1 : playerTaken2;

    List<Tile>? vertical = verticalCheck(playTile, takenTiles);
    if (vertical != null) {
      winTiles = vertical;
      return true;
    }

    List<Tile>? horizontal = horizontalCheck(playTile, takenTiles);
    if (horizontal != null) {
      winTiles = horizontal;
      return true;
    }

    List<Tile>? forwardDiagonal = forwardDiagonalCheck(playTile, takenTiles);
    if (forwardDiagonal != null) {
      winTiles = forwardDiagonal;
      return true;
    }

    List<Tile>? backDiagonal = backDiagonalCheck(playTile, takenTiles);
    if (backDiagonal != null) {
      winTiles = backDiagonal;
      return true;
    }

    return false;
  }

  List<Tile>? verticalCheck(Tile playTile, List<Tile> takenTiles) {
    List<Tile> tempWinTiles = [];

    for (var row = playTile.row; row > 0; row--) {
      Tile tile = Tile(col: playTile.col, row: row);
      if (takenTiles.contains(tile)) {
        tempWinTiles.add(tile);
      } else {
        break;
      }
    }

    if (tempWinTiles.length >= boardSettings.winCondition()) {
      return tempWinTiles;
    }

    return null;
  }

  List<Tile>? horizontalCheck(Tile playTile, List<Tile> takenTiles) {
    List<Tile> tempWinTiles = [playTile];
    if (playTile.col > 1) {
      for (var col = playTile.col - 1; col > 0; col--) {
        Tile tile = Tile(col: col, row: playTile.row);

        if (takenTiles.contains(tile)) {
          tempWinTiles.add(tile);
        } else {
          break;
        }
      }
    }

    if (playTile.col < boardSettings.cols) {
      for (var col = playTile.col + 1; col < boardSettings.cols + 1; col++) {
        Tile tile = Tile(col: col, row: playTile.row);

        if (takenTiles.contains(tile)) {
          tempWinTiles.add(tile);
        } else {
          break;
        }
      }
    }

    if (tempWinTiles.length >= boardSettings.winCondition()) {
      return tempWinTiles;
    }

    return null;
  }

  List<Tile>? forwardDiagonalCheck(Tile playTile, List<Tile> takenTiles) {
    List<Tile> tempWinTiles = [playTile];
    if (playTile.col > 1 && playTile.row > 1) {
      for (var i = 1; i < playTile.row + 1; i++) {
        Tile tile = Tile(col: playTile.col - i, row: playTile.row - i);

        if (takenTiles.contains(tile)) {
          tempWinTiles.add(tile);
        } else {
          break;
        }
      }
    }

    if (playTile.col < boardSettings.cols && playTile.row < boardSettings.rows) {
      for (var i = 1; i < (boardSettings.rows + 1) - playTile.row; i++) {
        Tile tile = Tile(col: playTile.col + i, row: playTile.row + i);
        if (takenTiles.contains(tile)) {
          tempWinTiles.add(tile);
        } else {
          break;
        }
      }
    }

    if (tempWinTiles.length >= boardSettings.winCondition()) {
      return tempWinTiles;
    }

    return null;
  }

  List<Tile>? backDiagonalCheck(Tile playTile, List<Tile> takenTiles) {
    List<Tile> tempWinTiles = [playTile];
    if (playTile.col > 1 && playTile.row < boardSettings.rows) {
      for (var i = 1; i < (boardSettings.rows + 1) - playTile.row; i++) {
        Tile tile = Tile(col: playTile.col - i, row: playTile.row + i);

        if (takenTiles.contains(tile)) {
          tempWinTiles.add(tile);
        } else {
          break;
        }
      }
    }
    if (playTile.col < boardSettings.cols && playTile.row > 1) {
      for (var i = 1; i < playTile.row + 1; i++) {
        Tile tile = Tile(col: playTile.col + i, row: playTile.row - i);
        if (takenTiles.contains(tile)) {
          tempWinTiles.add(tile);
        } else {
          break;
        }
      }
    }
    if (tempWinTiles.length >= boardSettings.winCondition()) {
      return tempWinTiles;
    }

    return null;
  }
}