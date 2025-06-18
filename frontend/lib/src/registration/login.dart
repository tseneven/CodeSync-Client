import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';

class WelcomePage extends StatefulWidget{
  const WelcomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WelcomePageState createState() => _WelcomePageState();
}
// Основной виджет
class _WelcomePageState extends State<WelcomePage> {
  var logger = Logger();

Color hexToColor(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: hexToColor("#f2f2eb"),
        body: Column(
          children:[
          const Image(image: AssetImage('assets/bg_gif.gif')),
          Text(
            'Welcome',
            style: GoogleFonts.adventPro(
              fontSize: 24,
              color: Colors.black
            ),
          )
        ]
      ) 
    );
  }
}



