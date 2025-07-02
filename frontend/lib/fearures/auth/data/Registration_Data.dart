import 'dart:convert';
import 'package:frontend/fearures/auth/domain/Registration_Interface.dart';
import 'package:http/http.dart' as http;

class RegistrationData extends Registration_Interface{

  @override
  Future<String> Registr(String username, String email, String password){

    final response = await http.post(

    );

  }

}