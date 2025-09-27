import 'package:code_sync/fearures/main_screen/main_screen_ui.dart';
import 'package:flutter/material.dart';
import 'package:code_sync/fearures/auth/presentation/auth/auth_ui.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
