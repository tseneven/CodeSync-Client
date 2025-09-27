import 'package:code_sync/fearures/main_screen/news_screen_ui.dart';
import 'package:code_sync/utils/hex_to_Color.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(flex: 21, child: NewsWidget()),
          Expanded(
            flex: 3,
            child: Container(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                child: Container(
                  height: 10,
                  width: double.infinity,
                  decoration: const BoxDecoration(color: Colors.black),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Row(                 
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ButtonWidget(
                            icon: Icons.newspaper,
                            textUnderButton: "News",
                          ),
                          ButtonWidget(
                            icon: Icons.task,
                            textUnderButton: "Tasks",
                          ),
                          ButtonWidget(
                            icon: Icons.person,
                            textUnderButton: "Profile",
                          ),
                          ButtonWidget(
                            icon: Icons.chat_bubble,
                            textUnderButton: "Chats",
                          ),
                          ButtonWidget(
                            icon: Icons.person_search,
                            textUnderButton: "Friends",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      backgroundColor: HexToColor.hexToColor("#ebebe8"),
    );
  }
}



class ButtonWidget extends StatelessWidget {
  IconData icon;
  String textUnderButton;
  ButtonWidget({super.key, required this.icon, required this.textUnderButton});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        Text(textUnderButton, style: const TextStyle(color: Colors.white, fontSize: 12),)
      ],
    );
  }
}
