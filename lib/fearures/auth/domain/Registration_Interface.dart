abstract class Registration_Interface{
  Future<String> register(String username, String email, String password);
  Future<String> login(String username, String email, String password);
}

