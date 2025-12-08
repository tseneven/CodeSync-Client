import 'package:code_sync/data/dto/user.dto.dart';

abstract class Registration_Interface{
  Future<String> register(User user);
  Future<String> login(User user);
}

