import 'package:flutter/material.dart';
import 'src/registration/login.dart'; // Импортируем экран входа

void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "RPS",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: const LoginPage(),
    );
  }
}