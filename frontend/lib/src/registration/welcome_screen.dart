import 'package:flutter/material.dart';
import 'package:frontend/src/registration/login.dart';
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
  bool _isVisible = false;
  var logger = Logger();

  void _toggleBottomSheet() {
    setState(() {
      _isVisible = !_isVisible; // Меняем состояние видимости
    });
  }

  @override
  Widget build(BuildContext context){
    return  Scaffold(
      backgroundColor: Colors.black,
        body:  Stack(
          children:[
            const _BackgroundWidget(),
            const _CenterTextWidget(),
            _ButtonsWidget(toggleBottomSheet: _toggleBottomSheet),
            if (_isVisible) const BottomSheetWidget(),
        ]
      ) 
    );
  }
}

// Виджет с кнопками
class _ButtonsWidget extends StatelessWidget {
  final VoidCallback toggleBottomSheet;
  const _ButtonsWidget({required this.toggleBottomSheet});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        child: Row(    
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _ButtonWidget('Sign up', Colors.black, Colors.transparent, const Radius.circular(0), toggleBottomSheet: toggleBottomSheet),
            _ButtonWidget('Sign in', Colors.blueAccent, Colors.white, const Radius.circular(30), toggleBottomSheet: toggleBottomSheet),      
          ],
        ),
      ),
    );
  }
}

// Виджет кнопки
// ignore: must_be_immutable
class _ButtonWidget extends StatelessWidget {
  final String textButton;
  final Color colorText;
  final Color colorBackground;
  final Radius radius;
  final VoidCallback? toggleBottomSheet; // Коллбек для кнопки

  const _ButtonWidget(this.textButton, this.colorText, this.colorBackground, this.radius, {this.toggleBottomSheet});


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: toggleBottomSheet, 
        style: TextButton.styleFrom(
          minimumSize: (const Size(150, 70)),
          backgroundColor: colorBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: radius), 
          ),
        ),
        child: Text(
          textButton,
          style: GoogleFonts.poppins(color: colorText, fontSize: 14, fontWeight: FontWeight.w500),
          )
        )
    );
  }
}
// Виджет бэкграунда
class _BackgroundWidget extends StatelessWidget {
  const _BackgroundWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/bg.jpg'),
          fit: BoxFit.cover, 
        ),
      ),
    );
  }
}
// Виджет с текстом
class _CenterTextWidget extends StatelessWidget {
  const _CenterTextWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Welcome Back!',
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500),
          ), 
          const SizedBox(height: 15),
          Text(
            'Please log in to enter the system',
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ]
      )
    );
  }
}

