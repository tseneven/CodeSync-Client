import 'dart:convert';
import 'package:code_sync/data/datasourse/shared_preferences_interface.dart';
import 'package:code_sync/data/repositories/shared_preferences.dart';
import 'package:code_sync/fearures/auth/domain/Registration_Interface.dart';

import 'package:http/http.dart' as http;

class RegistrationData extends Registration_Interface {
  final ShServiseInterface sp = ShServise();

  @override
  Future<String> login(String username, String email, String password) async {
    try {
      const endpoint = "http://10.0.2.2:5163/api/Auth/login";
      final response = await http.post(Uri.parse(endpoint),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(
              {'username': username, 'email': email, 'password': password}));
      if (response.statusCode == 403) return "Неверный пароль";

      if (response.statusCode == 404) return "Такого пользователя нет";
      if (response.statusCode == 500) return "Ошибка на сервере";

      sp.saveToken(response.body);
      return "Ок";
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<String> register(
      String username, String email, String password) async {
    try {
      const endpoint = "http://10.0.2.2:5163/api/Auth/register";

      final response = await http.post(Uri.parse(endpoint),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(
              {'username': username, 'email': email, 'password': password}));

      if (response.statusCode == 500) return "Ошибка на сервере";

      return "Ок";
    } catch (e) {
      return e.toString();
    }
  }
}
