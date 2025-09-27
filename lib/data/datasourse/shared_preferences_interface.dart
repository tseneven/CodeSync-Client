abstract class ShServiseInterface{
  Future<void> saveToken(String token);
  Future<String?> getToken();
}