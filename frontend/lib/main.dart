import 'package:flutter/material.dart';
import 'package:frontend/fearures/auth/presentation/RegistrationUI.dart';// Импортируем начальный экран

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