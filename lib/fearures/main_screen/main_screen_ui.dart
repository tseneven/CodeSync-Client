import 'package:code_sync/fearures/main_screen/enums/states_eum.dart';
import 'package:code_sync/fearures/main_screen/news_screen_ui.dart';
import 'package:code_sync/fearures/main_screen/overlay_add_board.dart';
import 'package:code_sync/utils/hex_to_Color.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<NewsWidgetState> newsKey = GlobalKey<NewsWidgetState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(flex: 21, child: NewsWidget(key: newsKey)),
          LowerPanelWidget(onNewsUpdate: () {
            newsKey.currentState?.loadBoard();
          })
        ],
      ),
      backgroundColor: HexToColor.hexToColor("#ebebe8"),
    );
  }
}

class LowerPanelWidget extends StatefulWidget {
  final VoidCallback onNewsUpdate;
  LowerPanelWidget({super.key, required this.onNewsUpdate});

  @override
  LowerPanelWidgetState createState() => LowerPanelWidgetState();
}

class LowerPanelWidgetState extends State<LowerPanelWidget> {
  StatesEum eum = StatesEum.news;

  void boardAdd() async {
    OverlayAddBoard.show(
      context,
      onClose: widget.onNewsUpdate,
    );
  }

  void setStateMenu(String state) {
    setState(() {
      if (state == "News") {
        eum = StatesEum.news;
      } else if (state == "Tasks") {
        eum = StatesEum.tasks;
      } else if (state == "Chats") {
        eum = StatesEum.chats;
      } else if (state == "Profile") {
        eum = StatesEum.profile;
      } else if (state == "add") {
        boardAdd();
      }
    });
  }

  void action(String state) {
    setStateMenu(state);
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
                      action: action,
                      isSelected: eum == StatesEum.news ? true : false,
                    ),
                    ButtonWidget(
                      icon: Icons.task,
                      textUnderButton: "Tasks",
                      centralButton: false,
                      action: action,
                      isSelected: eum == StatesEum.tasks ? true : false,
                    ),
                    ButtonWidget(
                      icon: Icons.add,
                      textUnderButton: "add",
                      centralButton: true,
                      action: action,
                      isSelected: false,
                    ),
                    ButtonWidget(
                      icon: Icons.chat_bubble,
                      textUnderButton: "Chats",
                      centralButton: false,
                      action: action,
                      isSelected: eum == StatesEum.chats ? true : false,
                    ),
                    ButtonWidget(
                      icon: Icons.person,
                      textUnderButton: "Profile",
                      centralButton: false,
                      action: action,
                      isSelected: eum == StatesEum.profile ? true : false,
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
  final void Function(String state) action;
  final bool isSelected;

  ButtonWidget(
      {super.key,
      required this.icon,
      required this.textUnderButton,
      required this.centralButton,
      required this.action,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return centralButton == false
        ? Column(
            children: [
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                    color: Colors.black, // фон контейнера
                    boxShadow: [
                      isSelected
                          ? const BoxShadow(
                              color: Colors.cyanAccent,
                              offset: Offset(0, 5),
                              blurRadius: 20,
                              spreadRadius: 2,
                            )
                          : const BoxShadow(color: Colors.transparent)
                    ]),
                child: GestureDetector(
                  onTap: () => action(textUnderButton),
                  child: Icon(
                    icon,
                    color: Colors.white,
                  ),
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
                onTap: () => action(textUnderButton),
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
