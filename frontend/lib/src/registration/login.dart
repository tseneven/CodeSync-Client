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
    return  Scaffold(
      backgroundColor: Colors.black,
        body: Container(
          width: double.infinity,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              _LoginNameWidget(),     
            ],
          ),
        )
    );
  }
}

class _LoginNameWidget extends StatelessWidget {
  const _LoginNameWidget();

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors:[
            Colors.purple,
            Colors.deepPurple,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(30),          
        )
      ),
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            "Добро пожаловать", 
            style: GoogleFonts.ptSansCaption(color: Colors.white, fontSize: 24),
            
          )
        ],
      ),
    );
  }
}
