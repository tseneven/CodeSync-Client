import 'dart:ffi';

import 'package:code_sync/data/datasourse/shared_preferences_interface.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShServise extends ShServiseInterface {
  Logger logger = Logger();

  // Сохранение токена с входными данными (Токен, юзернейма и юзерайди)
  @override
  Future<void> saveToken(String token, int userID, String username) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('auth_token', token);
    prefs.setString('username', username);
    prefs.setInt('user_id', userID);
    logger.d(token);
  }

  // Получение токена
  @override
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // Получение юзерайди
  @override
  Future<String> getUserID() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id').toString();
  }

  // Получение юзернейма
  @override
  Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }
}
