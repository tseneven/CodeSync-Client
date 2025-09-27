import 'package:code_sync/data/repositories/shared_preferences.dart';
import 'package:code_sync/fearures/auth/data/board.dart';
import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:intl/intl.dart';

class NewsWidget extends StatefulWidget {
  const NewsWidget({
    super.key,
  });

  @override
  NewsWidgetState createState() => NewsWidgetState();
}

class NewsWidgetState extends State<NewsWidget> {
  final board = Board();
  final logger = Logger();
  String? userID;
  String? username;
  List<Map<String, dynamic>> news = [];

  @override
  void initState() {
    super.initState();
    loadBoard();
    loadUser();
  }

  void loadUser() async {
    final sh = ShServise();
    userID = await sh.getUserID();
    username = await sh.getUsername();
    setState(() {});
  }

  void loadBoard() async {
    final loadedNews = await board.getAllBoards();
    logger.d(loadedNews);

    if (loadedNews.isEmpty) return;
    if (loadedNews[0]['ex'] != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(loadedNews[0]['ex'])));
    } else {
      setState(() {
        news = [];
        news = loadedNews;
      });
    }
  }

  String formatDate(String isoString) {
    final dateTime = DateTime.parse(isoString);
    final formatter = DateFormat('dd.MM.yyyy HH:mm');
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: news.isNotEmpty
            ? ListView.builder(
                itemCount: news.length,
                itemBuilder: (context, index) {
                  List<dynamic> likes = news[index]['likes'];
                  bool isLiked =
                      likes.any((like) => like['userId'].toString() == userID);

                  for (int i = 0; i < likes.length; i++) {
                    // ignore: unrelated_type_equality_checks, collection_methods_unrelated_type
                    if (userID == likes[i]['userId'].toString()) {
                      isLiked = true;
                    }
                  }

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadiusGeometry.all(Radius.circular(10)),
                      child: Container(
                        decoration: const BoxDecoration(color: Colors.black),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0,
                                  top: 8.0,
                                  bottom: 8.0,
                                  right: 8.0),
                              child: Row(
                                children: [
                                  const CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/memoji.webp'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      news[index]['username'],
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            news[index]['haveImage'] == false
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              news[index]['username'],
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            const Text(
                                              ':',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                news[index]['text'],
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15.0,
                                            right: 8.0,
                                            bottom: 15.0,
                                            left: 20.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () async {
                                                        if (!isLiked) {
                                                          setState(() {
                                                            news[index]['likes']
                                                                .add({
                                                              'id': null,
                                                              'username':
                                                                  username,
                                                              'userId': userID,
                                                              'boardId':
                                                                  news[index]
                                                                      ['id'],
                                                            });
                                                            news[index][
                                                                    'countLikes'] =
                                                                news[index][
                                                                        'likes']
                                                                    .length;
                                                          });
                                                          // Обновляем сервер
                                                          await board
                                                              .likedBoard(
                                                                  news[index]
                                                                      ['id']);
                                                        }
                                                      },
                                                      child: Icon(
                                                        Icons.favorite,
                                                        color: isLiked
                                                            ? Colors.red
                                                            : Colors.white,
                                                        size: 20,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Text(
                                                      news[index]['countLikes']
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                                // ignore: prefer_const_constructors
                                                Row(
                                                  children: [
                                                    const SizedBox(width: 10),
                                                    const Icon(
                                                      Icons.chat_bubble,
                                                      color: Colors.white,
                                                      size: 20,
                                                    ),
                                                    const SizedBox(width: 10),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .subdirectory_arrow_right_sharp,
                                                      color: Colors.white,
                                                      size: 20,
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Text(
                                                      news[index]['repost']
                                                          .toString()
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 15),
                                              child: Text(
                                                formatDate(news[index]['date']),
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 20.0,
                                            right: 20.0,
                                            bottom: 20.0,
                                            top: 10.0),
                                        child: Image(
                                            image: AssetImage(
                                                'assets/bg_fon.png')),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              news[index]['username'],
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            const Text(
                                              ':',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                news[index]['text'],
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15.0,
                                            right: 8.0,
                                            bottom: 15.0,
                                            left: 20.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () async {
                                                        if (!isLiked) {
                                                          setState(() {
                                                            news[index]['likes']
                                                                .add({
                                                              'id':
                                                                  null, 
                                                              'username':
                                                                  userID,
                                                              'userId': username,
                                                              'boardId':
                                                                  news[index]
                                                                      ['id'],
                                                            });
                                                            news[index][
                                                                    'countLikes'] =
                                                                news[index][
                                                                        'likes']
                                                                    .length;
                                                          });
                                                          await board
                                                              .likedBoard(
                                                                  news[index]
                                                                      ['id']);
                                                        }
                                                      },
                                                      child: Icon(
                                                        Icons.favorite,
                                                        color: isLiked
                                                            ? Colors.red
                                                            : Colors.white,
                                                        size: 20,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Text(
                                                      news[index]['countLikes']
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                                // ignore: prefer_const_constructors
                                                Row(
                                                  children: [
                                                    const SizedBox(width: 10),
                                                    const Icon(
                                                      Icons.chat_bubble,
                                                      color: Colors.white,
                                                      size: 20,
                                                    ),
                                                    const SizedBox(width: 10),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .subdirectory_arrow_right_sharp,
                                                      color: Colors.white,
                                                      size: 20,
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Text(
                                                      news[index]['repost']
                                                          .toString()
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 15),
                                              child: Text(
                                                formatDate(news[index]['date']),
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                          ],
                        ),
                      ),
                    ),
                  );
                })
            : const Center(
                child: Text("Здесь пока ничего нету =)"),
              ));
  }
}
