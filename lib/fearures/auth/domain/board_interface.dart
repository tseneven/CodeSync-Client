abstract class BoardInterface {
  Future<List<Map<String, dynamic>>> getAllBoards();
  Future<String> boardAdd(String text, bool haveImage);
}  