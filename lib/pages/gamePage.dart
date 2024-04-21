import 'package:flutter/material.dart';
import 'package:flutter_project_connectfour1/pages/home.dart';
import 'package:flutter_project_connectfour1/src/BoardSettings.dart';
import 'package:flutter_project_connectfour1/pages/gameBoard.dart';
import 'package:flutter_project_connectfour1/src/board_state.dart';
import 'package:provider/provider.dart';

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

class GamePage extends StatefulWidget  {
  GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final BoardSettings boardSettings = BoardSettings(rows: 6, cols: 7);
  final Color color1 = HexColor.fromHex('#EFE696');
  final Color color2 = HexColor.fromHex('#EF9696');
  final Color color3 = HexColor.fromHex('#CFF4FF');
  final Color color4 = HexColor.fromHex('#484848');
  final Color color5 = HexColor.fromHex('#97B6C0');
  final Color color8 = HexColor.fromHex('#C76C6C');
  final Color color9 = HexColor.fromHex('#C7B86C');
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          final boardState = BoardState(boardSettings: boardSettings);
          boardState.playerWon.addListener(_playerWon);
          return boardState;
        })
      ],
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[color2 ,Colors.white, Colors.white, Colors.white, color1]),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                Builder(builder: (context) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Spacer(),
                        SizedBox(
                          width: 400,
                          child: Row(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage('assets/images/player1.png'),
                                        fit: BoxFit.contain
                                    ),
                                    border: Border.all(
                                      color: color8,
                                      width: 5.0,
                                    ),
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.white
                                ),
                              ),
                              Container(
                                child: Text(' PLAYER 1',
                                  style: TextStyle(
                                      color: color4,
                                      fontFamily: 'Lemon',
                                      fontSize: 30
                                  ),
                                  textAlign: TextAlign.right,),
                              )
                            ],
                          ),
                        ),
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: color5,
                                width: 3.0
                            ),
                            borderRadius: BorderRadius.circular(10),
                            color: color3,
                          ),
                          height: 350,
                          child: GameBoard(boardSettings: boardSettings),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) => Home()));
                          },
                          style: ElevatedButton.styleFrom(
                              shape: CircleBorder(
                                side: BorderSide(color: color5, width: 3),
                              ),
                              backgroundColor: color3
                          ),
                          child: Icon(Icons.menu, color: color4),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            context.read<BoardState>().clearBoard();
                          },
                          style: ElevatedButton.styleFrom(
                              shape: StadiumBorder(
                                side: BorderSide(color: color5, width: 3),
                              ),
                              backgroundColor: color3
                          ),
                          child: Text("RESET",
                            style: TextStyle(
                                color: color4,
                                fontSize: 20,
                                fontFamily: 'Lemon'
                            ),),
                        ),
                        const Spacer(),

                        SizedBox(
                          width: 400,
                          child: Row(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage('assets/images/player2.png',),
                                        fit: BoxFit.contain
                                    ),
                                    border: Border.all(
                                      color: color9,
                                      width: 5.0,
                                    ),
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.white
                                ),
                              ),
                              Container(
                                child: Text(' PLAYER 2',
                                    style: TextStyle(
                                        color: color4,
                                        fontFamily: 'Lemon',
                                        fontSize: 30
                                    )),
                              )
                            ],
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _playerWon(){
    showDialog(
        context: context,
        builder: (context) {
          return SizedBox(
            width: 100,
            height: 100,
            child: AlertDialog(

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: color5, width: 3),
              ),
              backgroundColor: Colors.white,

              content: SizedBox(
                  width: 50,
                  height: 50,
                  child: Center(
                    child: Text('YOU WIN!',
                      style: TextStyle(
                          color: color4,
                          fontFamily: 'Lemon',
                          fontSize: 30
                      ),),
                  )
              ),
              actions: <Widget>[
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) => Home())); // dismisses only the dialog and returns nothing
                    },
                    style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(
                          side: BorderSide(color: color5, width: 3),
                        ),
                        backgroundColor: color3,
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        textStyle: TextStyle(
                            fontFamily: 'Lemon'
                        )
                    ),
                    child: Text('BACK',
                      style: TextStyle(
                          fontSize: 20,
                          color: color4
                      ),),
                  ),
                ),
              ],
            ),
          );
        }

    );
  }
}


