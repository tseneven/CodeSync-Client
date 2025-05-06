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

  @override
  Widget build(BuildContext context){
    return  const Scaffold(
      backgroundColor: Colors.black,
        body:  Stack(
          children:[
            _BackgroundWidget(),
            _CenterTextWidget(),
            _ButtonsWidget() 
        ]
      ) 
    );
  }
}

// Виджет с кнопками
class _ButtonsWidget extends StatelessWidget {
  const _ButtonsWidget();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        child: const Row(    
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _ButtonWidget('Sign up', Colors.black, Colors.transparent, Radius.circular(0) ),
            _ButtonWidget('Sign in', Colors.blueAccent, Colors.white, Radius.circular(30)),      
          ],
        ),
      ),
    );
  }
}

// Виджет кнопки
class _ButtonWidget extends StatelessWidget {
  final String textButton;
  final Color colorText;
  final Color colorBackground;
  final Radius radius;
  const _ButtonWidget(this.textButton, this.colorText, this.colorBackground, this.radius);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: (){}, 
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