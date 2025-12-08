abstract class ShServiseInterface{
  Future<void> saveToken(String token, String userID, String username);
  Future<String?> getToken();
  Future<String?> getUserID();
  Future<String?> getUsername();
}