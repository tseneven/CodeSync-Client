import 'package:flutter/material.dart';

class NewsWidget extends StatefulWidget {
  const NewsWidget({
    super.key,
  });

  @override
  NewsWidgetState createState() => NewsWidgetState();
}

class NewsWidgetState extends State<NewsWidget> {
  // Тестово список подгрузил, потом удалю
  List<Map<String, dynamic>> news = [
    {
      'userid': 1,
      'username': 'testUser',
      'text': 'test1',
      'haveImage': true,
      'date': '12.09.2025',
      'likes': {'count': 999},
      'repost': 0
    },
    {
      'userid': 1,
      'username': 'testUser',
      'text': 'test1',
      'haveImage': true,
      'date': '12.09.2025',
      'likes': {'count': 999},
      'repost': 0
    },
    {
      'userid': 1,
      'username': 'testUser',
      'text': 'test1',
      'haveImage': true,
      'date': '12.09.2025',
      'likes': {'count': 999},
      'repost': 0
    },
    {
      'userid': 1,
      'username': 'testUser',
      'text': 'test1',
      'haveImage': false,
      'date': '12.09.2025',
      'likes': {'count': 999},
      'repost': 0
    },
    {
      'userid': 1,
      'username': 'testUser',
      'text': 'test1',
      'haveImage': false,
      'date': '12.09.2025',
      'likes': {'count': 999},
      'repost': 0
    },
    {
      'userid': 1,
      'username': 'testUser',
      'text': 'test1',
      'haveImage': false,
      'date': '12.09.2025',
      'likes': {'count': 999},
      'repost': 0
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: news.length,
          itemBuilder: (context, index) {
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
                        padding: const EdgeInsets.only(left:15.0, top: 8.0, bottom: 8.0, right: 8.0),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              backgroundImage: AssetImage('assets/memoji.webp'),
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
                      news[index]['haveImage'] == true
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        news[index]['username'],
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      const Text(
                                        ':',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.favorite,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                news[index]['likes']['count']
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
                                        padding: const EdgeInsets.only(right: 15),
                                        child: Text(
                                          news[index]['date'].toString(),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0, top: 10.0),
                                  child: Image(
                                      image: AssetImage('assets/bg_fon.png')),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        news[index]['username'],
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      const Text(
                                        ':',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.favorite,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                news[index]['likes']['count']
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
                                        padding: const EdgeInsets.only(right: 15),
                                        child: Text(
                                          news[index]['date'].toString(),
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
          }),
    );
  }
}
