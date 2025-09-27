import 'package:code_sync/data/datasourse/shared_preferences_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShServise extends ShServiseInterface {

  // Сохранение токена с входными данными (Токен)
  @override
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('auth_token', token);
  }

  // Получение токена
  @override
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}