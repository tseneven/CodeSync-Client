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
      body: const Column(
        children: [
          Expanded(flex: 21, child: NewsWidget()),
          LowerPanelWidget()
        ],
      ),
      backgroundColor: HexToColor.hexToColor("#ebebe8"),
    );
  }
}

class LowerPanelWidget extends StatelessWidget {
  const LowerPanelWidget({
    super.key,
  });

  void boardAdd() async {

  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          child: Container(
            height: 10,
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.black),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ButtonWidget(
                      icon: Icons.newspaper,
                      textUnderButton: "News",
                      centralButton: false,
                      action: () {},
                    ),
                    ButtonWidget(
                      icon: Icons.task,
                      textUnderButton: "Tasks",
                      centralButton: false,
                      action: () {},
                    ),
                    ButtonWidget(
                      icon: Icons.add,
                      textUnderButton: "",
                      centralButton: true,
                      action: boardAdd,
                    ),
                    ButtonWidget(
                      icon: Icons.chat_bubble,
                      textUnderButton: "Chats",
                      centralButton: false,
                      action: () {},
                    ),
                    ButtonWidget(
                      icon: Icons.person,
                      textUnderButton: "Profile",
                      centralButton: false,
                      action: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final IconData icon;
  final String textUnderButton;
  final bool centralButton;
  final VoidCallback action;

  ButtonWidget(
      {super.key,
      required this.icon,
      required this.textUnderButton,
      required this.centralButton,
      required this.action});

  @override
  Widget build(BuildContext context) {
    return centralButton == false
        ? Column(
            children: [
              const SizedBox(height: 20),
              GestureDetector(
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
              Text(
                textUnderButton,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              )
            ],
          )
        : Column(
            children: [
              const SizedBox(height: 20),
              GestureDetector(
                onTap: action,
                child: Container(
                  width: 60,
                  height: 60,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: HexToColor.hexToColor("#ebebe8"),
                      width: 3,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      icon,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
