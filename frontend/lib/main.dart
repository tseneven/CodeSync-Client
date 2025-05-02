import 'package:flutter/material.dart';
import 'package:frontend/src/registration/welcome_screen.dart';// Импортируем начальный экран

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "RPS",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: const WelcomePage(),
    );
  }
}