import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {

  var logger = Logger();

  @override
  Widget build(BuildContext context){
    return  const Scaffold(
      body: Stack (
        children: [
          BottomSheetWidget()
        ]
      )
    );
  }
}

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  double _bottomPosition = -200; 

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _bottomPosition = 0; 
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      bottom: _bottomPosition, 
      right: 0,
      duration: const Duration(milliseconds: 500), // Длительность анимации
      curve: Curves.easeOut, // Тип анимации (плавный выход)
      child: Container(
        color: Colors.white,
        height: 200,
        child: const Center(
          child: Column(
            children: [

            ],
          )
        ),
      ),
    );
  }
}