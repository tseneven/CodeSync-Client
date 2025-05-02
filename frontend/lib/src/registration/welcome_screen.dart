import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';

class WelcomePage extends StatefulWidget{
  const WelcomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  var logger = Logger();

  @override
  Widget build(BuildContext context){
    return  Scaffold(
      backgroundColor: Colors.black,
        body: Stack(
          children:[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/bg.jpg'),
                  fit: BoxFit.cover, 
                ),
              ),
            ),

            Center(
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
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                child: Row(    
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: (){}, 
                        style: TextButton.styleFrom(
                          minimumSize: (const Size(150, 70)),
                        ),
                        child: const Text(
                          'Sign up',
                          style: TextStyle(color: Colors.white),
                          )
                        )
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {}, 
                        style: ElevatedButton.styleFrom(
                          minimumSize: (const Size(150, 70)),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(30)), 
                          ),
                        ),
                        child: const Text(
                          'Sign in',
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                    ),
                  ),                    
                ],
              ),
            ),
          ) 
        ]
      ) 
    );
  }
}