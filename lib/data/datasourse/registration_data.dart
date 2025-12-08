import 'dart:convert';
import 'package:code_sync/data/datasourse/shared_preferences.dart';
import 'package:code_sync/domain/repositories/registration_Interface.dart';
import 'package:code_sync/domain/repositories/shared_preferences_interface.dart';
import 'package:http/http.dart' as http;
import '../dto/user.dto.dart';

class RegistrationData extends Registration_Interface {
  final ShServiseInterface sp = ShServise();
  @override
  Future<String> login(User user) async {
    try {
      const endpoint = "http://10.0.2.2:5163/api/Auth/login";
      final response = await http
          .post(Uri.parse(endpoint),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode({
                'username': user.name,
                'email': user.email,
                'password': user.password
              }))
          .timeout(
            const Duration(seconds: 15),
            onTimeout: () =>
                throw Exception('Время ожидания ответа сервера истекло'),
          );
      if (response.statusCode == 403) return "Неверный пароль";

      if (response.statusCode == 404) return "Такого пользователя нет";
      if (response.statusCode == 500) return "Ошибка на сервере";

      final data = jsonDecode(response.body);

      sp.saveToken(data['token'], data['userID'], data['username']);
      return "Ок";
    } catch (e) {
      return "Ошибка на сервере. Повторите позже";
    }
  }

  @override
  Future<String> register(User user) async {
    try {
      const endpoint = "http://10.0.2.2:5163/api/Auth/register";

      final response = await http
          .post(Uri.parse(endpoint),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode({
                'username': user.name,
                'email': user.email,
                'password': user.password
              }))
          .timeout(
            const Duration(seconds: 15),
            onTimeout: () =>
                throw Exception('Время ожидания ответа сервера истекло'),
          );

      if (response.statusCode == 400) {
        return "Такой пользователь уже существует";
      }

      if (response.statusCode == 500) return "Ошибка на сервере";

      return "Ок";
    } catch (e) {
      return "Ошибка на сервере. Повторите позже";
    }
  }
}
