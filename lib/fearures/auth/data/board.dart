import 'dart:convert';
import 'package:code_sync/data/repositories/shared_preferences.dart';
import 'package:code_sync/fearures/auth/domain/board_interface.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class Board extends BoardInterface {
  Logger logger = Logger();
  final sh = ShServise();

  @override
  Future<List<Map<String, dynamic>>> getAllBoards() async {
    const endpoint = "http://10.0.2.2:5163/api/Borders/GetAll";

    final uri = Uri.parse(endpoint);

    try {
      final token = await sh.getToken();

      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data
            .map((board) => {
                  "id": board["id"],
                  "userID": board["userID"],
                  "username": board["username"],
                  "text": board["text"],
                  "haveImage": board["haveImage"],
                  "date": board["date"],
                  "likes": board["likes"],
                  "countLikes": board["countLikes"],
                  "repost": board["repost"],
                })
            .toList();
      } else {
        logger.e('Ошибка загрузки списка постов: ${response.statusCode}');
        return [
          {'ex': "Ошибка загрузки списка постов: ${response.statusCode}"}
        ];
      }
    } catch (e) {
      logger.e('Ошибка: $e');
      return [
        {'ex': e.toString()}
      ];
    }
  }

  @override
  Future<String> boardAdd(String text, bool haveImage) async {
    const endpoint = "http://10.0.2.2:5163/api/Borders/CreateBorder";

    final uri = Uri.parse(endpoint);

    final token = await sh.getToken();
    final username = await sh.getUsername();
    final userId = await sh.getUserID();

    logger.d(token);

    final response = await http.post(uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({
          'UserID': userId,
          'Username': username,
          'text': text,
          'haveImage': haveImage,
          'repost': 0
        })
      );

    if (response.statusCode == 200) {
      return "Ок";
    }
    return "Ошибка публикации: ${response.statusCode}";
  }
}
