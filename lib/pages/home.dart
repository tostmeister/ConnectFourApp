import 'package:flutter/material.dart';
import 'package:flutter_project_connectfour1/pages/gamePage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
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

class _HomeState extends State<Home> {
  final Color color1 = HexColor.fromHex('#EFE696');
  final Color color2 = HexColor.fromHex('#EF9696');
  final Color color3 = HexColor.fromHex('#CFF4FF');
  final Color color4 = HexColor.fromHex('#484848');
  final Color color5 = HexColor.fromHex('#97B6C0');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[color2 ,Colors.white, Colors.white, Colors.white, color1]),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      child: Image.asset("assets/images/Icon.png", width: 300, height: 300)
                  ),

                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    child: ElevatedButton(onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GamePage()),);
                    },
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(
                            side: BorderSide(color: color5, width: 3),
                          ),
                          backgroundColor: color3,
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                          textStyle: TextStyle(
                              fontSize: 25,
                              fontFamily: 'Lemon')),
                      child: Text('START',
                        style: TextStyle(
                            color: color4),),
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  Container(
                    child: ElevatedButton(onPressed: (){},
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(
                            side: BorderSide(color: color5, width: 3),
                          ),
                          backgroundColor: color3,
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                          textStyle: TextStyle(
                              fontSize: 25,
                              fontFamily: 'Lemon')),
                      child: Text('  EXIT  ',
                        style: TextStyle(
                            color: color4),),
                    ),
                  )
                ],
              )
            ],
          ),
        )


    );
  }
}
