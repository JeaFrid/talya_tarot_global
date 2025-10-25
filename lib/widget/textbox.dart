import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tarot/constant/tarot.dart';
import 'package:tarot/controller/controller.dart';
import 'package:tarot/services/ai.dart';
import 'package:tarot/theme/color.dart';

import '../controller/textediting.dart';

ValueNotifier<bool> readOnly = ValueNotifier(false);

class TextBoxBottom extends StatefulWidget {
  final String? text;
  final Function()? onTap;
  final Function()? onTapLong;
  final double width;
  final TextEditingController? textEditingController;
  const TextBoxBottom({
    super.key,
    required this.width,
    this.text,
    this.onTap,
    this.textEditingController,
    this.onTapLong,
  });

  @override
  State<TextBoxBottom> createState() => _TextBoxBottomState();
}

class _TextBoxBottomState extends State<TextBoxBottom> {
  final FocusNode _focusNode = FocusNode();
  final ValueNotifier<bool> _focus = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(
      () {
        _focus.value = _focusNode.hasFocus;
      },
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: readOnly,
      builder: (BuildContext context, dynamic rO, Widget? child) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  focusNode: _focusNode,
                  style: GoogleFonts.dmSans(
                    color: textColor,
                    fontSize: 13,
                  ),
                  cursorColor: defaultColor,
                  controller: widget.textEditingController ?? messageController,
                  readOnly: rO,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: widget.text ?? "Bir mesaj yazın...",
                    hintStyle: GoogleFonts.dmSans(
                      color: textColor.withOpacity(0.5),
                      fontSize: 13,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: textColor,
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: defaultColor.withOpacity(0.4),
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: defaultColor,
                        width: 2,
                      ),
                    ),
                  ),
                  onSubmitted: (a) async {},
                ),
              ),
              const SizedBox(width: 6),
              GestureDetector(
                onLongPress: () {
                  if (kDebugMode) {
                    if (widget.onTapLong != null) {
                      widget.onTapLong!();
                    }
                  }
                },
                onTap: widget.onTap ??
                    (rO
                        ? () {}
                        : () async {
                            if (messageController.text.isNotEmpty) {
                              niyet.text = messageController.text;
                              List<Map<String, String>> currentList = [];
                              List<Map<String, String>> tarotListAll =
                                  tarotCards;
                              List aa = [1, 2, 3, 4, 5, 6];
                              ValueNotifier<bool> card1 = ValueNotifier(false);
                              ValueNotifier<bool> card2 = ValueNotifier(false);
                              ValueNotifier<bool> card3 = ValueNotifier(false);
                              Timer.periodic(
                                const Duration(milliseconds: 2),
                                (timer) async {
                                  if (card1.value == false) {
                                    card1.value = true;
                                    for (var i = 0; i < 78; i++) {
                                      shuffleList(tarotListAll);
                                    }
                                  } else if (card2.value == false) {
                                    card2.value = true;
                                    for (var i = 0; i < 78; i++) {
                                      shuffleList(tarotListAll);
                                    }
                                  } else if (card3.value == false) {
                                    card3.value = true;
                                    for (var i = 0; i < 78; i++) {
                                      shuffleList(tarotListAll);
                                    }
                                    for (var i = 0; i < 3; i++) {
                                      Random random = Random();
                                      int randomInt = random.nextInt(75);
                                      currentList
                                          .add(tarotListAll[randomInt + 1]);
                                      currentList.add({
                                        "value": random.nextBool().toString()
                                      });
                                    }
                                    String card1s =
                                        (currentList[1]["value"] == "true"
                                                ? "Ters "
                                                : "") +
                                            (currentList[0]["name"] ??
                                                "Bilinmeyen");
                                    String card2s =
                                        (currentList[3]["value"] == "true"
                                                ? "Ters "
                                                : "") +
                                            (currentList[2]["name"] ??
                                                "Bilinmeyen");
                                    String card3s =
                                        (currentList[5]["value"] == "true"
                                                ? "Ters "
                                                : "") +
                                            (currentList[4]["name"] ??
                                                "Bilinmeyen");

                                    await Ai.sendMessage(widget.width, """
İlk kart: $card1s,
İkinci kart: $card2s,
Sonuncu kart: $card3s,
""");
                                    timer.cancel();
                                  }
                                },
                              );
                            }
                          }),
                child: ValueListenableBuilder(
                  valueListenable: _focus,
                  builder: (
                    BuildContext context,
                    dynamic value,
                    Widget? child,
                  ) {
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: value == false
                              ? defaultColor.withOpacity(0.4)
                              : defaultColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: 49,
                      height: 49,
                      child: rO == false
                          ? Padding(
                              padding: const EdgeInsets.only(left: 3),
                              child: Icon(
                                Icons.send_rounded,
                                color: value == false
                                    ? defaultColor.withOpacity(0.4)
                                    : defaultColor,
                                size: 22,
                              ),
                            )
                          : CupertinoActivityIndicator(
                              color: defaultColor,
                              radius: 10,
                            ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void shuffleList(List list) {
    final random = Random();
    for (int i = list.length - 1; i > 0; i--) {
      int j = random.nextInt(i + 1);
      var temp = list[i];
      list[i] = list[j];
      list[j] = temp;
    }
  }
}
