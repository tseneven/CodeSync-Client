import 'package:flutter/material.dart';
import 'package:code_sync/fearures/auth/presentation/auth_ui.dart';
// import 'package:skyforge/features/presentation/register/register_ui.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AuthPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
