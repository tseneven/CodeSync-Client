import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  Widget build(BuildContext context){
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Hello',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.g_mobiledata),
              label: 'World',
            ),
          ]
        ),
        body: Align(
          child: Row(
            children: [
              Padding(padding: EdgeInsets.all(20),
                child: Text("Child1"),
              ),
              Padding(padding: EdgeInsets.all(20),
                child: Text("Child2"),
              ),
              Padding(padding: EdgeInsets.all(20),
                child: Text("Child3"),
              )       
            ],
          ),
        ),
    );
  }
}
