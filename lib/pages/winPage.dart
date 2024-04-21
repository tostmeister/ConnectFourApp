import 'package:flutter/material.dart';
import 'package:flutter_project_connectfour1/pages/home.dart';

class WinPage extends StatefulWidget {
  const WinPage({super.key});
  @override
  State<WinPage> createState() => _WinPageState();
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

class _WinPageState extends State<WinPage> {
  final Color color1 = HexColor.fromHex('#EFE696');
  final Color color2 = HexColor.fromHex('#EF9696');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[color1 ,Colors.white, color2]),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      'WIN!!!',
                      style: TextStyle(
                          fontSize: 50,
                          fontFamily: 'Permanent Marker'
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    child: ElevatedButton.icon(onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),);
                    },

                      label: Text('Начать игру', style: TextStyle(
                          fontFamily: 'Permanent Marker',
                          fontSize: 30
                      ),
                      ),
                      icon: Icon(
                          Icons.start
                      ),
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
