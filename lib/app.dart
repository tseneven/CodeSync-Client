import 'package:code_sync/UI/auth_service/auth/auth_ui.dart';
import 'package:flutter/material.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AuthPageWrapper(),
      debugShowCheckedModeBanner: false,
    );
  }
}
