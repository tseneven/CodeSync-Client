import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:google_fonts/google_fonts.dart';


class RegistrationPage extends StatefulWidget{
  const RegistrationPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegistrationPage>
{
  @override
  Widget build(BuildContext context){
    return const Scaffold(
      body: Row(
        children: [
          Text("text")
        ],
      ),
    );
  }
}