import 'package:code_sync/fearures/auth/data/board.dart';
import 'package:code_sync/utils/hex_to_color.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OverlayAddBoard extends StatefulWidget {
  BuildContext context;
  final VoidCallback? onClose;

  OverlayAddBoard({
    super.key,
    required this.context,
    this.onClose,
  });

  static OverlayEntry? _overlayEntry;

  static void show(
    BuildContext context,
    {VoidCallback? onClose}
  ) {
    hide();
    _overlayEntry = OverlayEntry(
      builder: (_) => Positioned.fill(
        child: Material(
          color: Colors.black54,
          child: Center(
            child: OverlayAddBoard(
              context: context,
              onClose: onClose,
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  static void hide([VoidCallback? onClose]) {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (onClose != null) {
    onClose(); 
  }
  }

  @override
  State<OverlayAddBoard> createState() => _OverlayAddBoardState();
}

class _OverlayAddBoardState extends State<OverlayAddBoard> {
  final _textController = TextEditingController();
  final board = Board();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void addBoard() async {
    final result = await board.boardAdd(_textController.text, false);

    if (result == "Ок") {
      setState(() {
        OverlayAddBoard.hide(widget.onClose);
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Expanded(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                decoration:
                    BoxDecoration(color: HexToColor.hexToColor("#202427")),
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Write your thoughts!",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'SFPro',
                                  ),
                                ),
                                GestureDetector(
                                  onTap: OverlayAddBoard.hide,
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 12,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextField(
                          controller: _textController,
                          textAlignVertical: TextAlignVertical.top,
                          expands: true,
                          style: const TextStyle(color: Colors.white),
                          maxLines: null,
                          minLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[800],
                            hintText: 'Enter text...',
                            hintStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w100,
                              fontFamily: 'SFPro',
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(),
                            ),
                            contentPadding: const EdgeInsets.all(12),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              children: [
                                GestureDetector(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Container(
                                        height: 45,
                                        width: 85,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[800],
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.only(
                                              left: 8.0, right: 10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Icon(Icons.attach_file),
                                              Text(
                                                "Attach",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w100,
                                                  fontFamily: 'SFPro',
                                                ),
                                              )
                                            ],
                                          ),
                                        )),
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                GestureDetector(
                                  onTap: addBoard,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Container(
                                        height: 45,
                                        width: 180,
                                        decoration: BoxDecoration(
                                          color:
                                              HexToColor.hexToColor("#2B8579"),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.only(
                                              left: 10.0, right: 10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Send",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w100,
                                                  fontFamily: 'SFPro',
                                                ),
                                              )
                                            ],
                                          ),
                                        )),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ))),
    );
  }
}
