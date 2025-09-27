abstract class ShServiseInterface{
  Future<void> saveToken(String token, int userID, String username);
  Future<String?> getToken();
  Future<String?> getUserID();
  Future<String?> getUsername();
}