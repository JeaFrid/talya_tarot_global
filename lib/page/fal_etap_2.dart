import 'dart:async';
import 'dart:math';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tarot/constant/tarot.dart';
import 'package:tarot/page/fal_etap_3.dart';
import 'package:tarot/theme/color.dart';
import 'package:tarot/widget/card_single.dart';

class FalPageIkinci extends StatefulWidget {
  const FalPageIkinci({super.key});

  @override
  State<FalPageIkinci> createState() => _FalPageIkinciState();
}

class _FalPageIkinciState extends State<FalPageIkinci>
    with SingleTickerProviderStateMixin {
  ValueNotifier<double> rotate = ValueNotifier(0);
  ValueNotifier<bool> card1 = ValueNotifier(false);
  ValueNotifier<bool> card2 = ValueNotifier(false);
  ValueNotifier<bool> card3 = ValueNotifier(false);
  late AnimationController _controller;
  late Animation<double> _animation;

  List<Map<String, String>> currentList = [];
  List<Map<String, String>> tarotListAll = tarotCards;
  List aa = [1, 2, 3, 4, 5, 6];

  void shuffleList(List list) {
    final random = Random();
    for (int i = list.length - 1; i > 0; i--) {
      int j = random.nextInt(i + 1);
      var temp = list[i];
      list[i] = list[j];
      list[j] = temp;
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 2 * pi).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.repeat();

    Timer.periodic(
      const Duration(milliseconds: 5),
      (timer) {
        rotate.value = rotate.value + 0.001;
      },
    );
    Timer.periodic(
      const Duration(seconds: kDebugMode ? 1 : 1),
      (timer) {
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
            currentList.add(tarotListAll[randomInt + 1]);
            currentList.add({"value": random.nextBool().toString()});
          }

          Future.delayed(
            const Duration(seconds: 2),
            () {
              if (mounted) {
                CosmosNavigator.pushNonAnimated(
                  context,
                  FalPageUcuncu(
                    list: currentList,
                  ),
                );
              }
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "Talya",
                        style: GoogleFonts.poppins(
                          color: textColor,
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        "İkinci Etap",
                        style: GoogleFonts.poppins(
                          color: textColor.withOpacity(0.5),
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            ValueListenableBuilder(
              valueListenable: card1,
              builder: (
                BuildContext context,
                dynamic card1Value,
                Widget? child,
              ) {
                return ValueListenableBuilder(
                  valueListenable: card2,
                  builder: (
                    BuildContext context,
                    dynamic card2Value,
                    Widget? child,
                  ) {
                    return ValueListenableBuilder(
                      valueListenable: card3,
                      builder: (
                        BuildContext context,
                        dynamic card3Value,
                        Widget? child,
                      ) {
                        return Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            Visibility(
                              visible: card1Value,
                              child: TweenAnimationBuilder(
                                duration: const Duration(milliseconds: 800),
                                tween: Tween<double>(begin: pi, end: 0),
                                builder: (context, double value, child) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Transform(
                                      transform: Matrix4.identity()
                                        ..setEntry(3, 2, 0.001)
                                        ..rotateY(value),
                                      alignment: Alignment.center,
                                      child: const TarotCardSingle(
                                        img: "assets/backgroundcard.png",
                                        width: 100,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Visibility(
                              visible: card2Value,
                              child: TweenAnimationBuilder(
                                duration: const Duration(milliseconds: 800),
                                tween: Tween<double>(begin: pi, end: 0),
                                builder: (context, double value, child) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Transform(
                                      transform: Matrix4.identity()
                                        ..setEntry(3, 2, 0.001)
                                        ..rotateY(value),
                                      alignment: Alignment.center,
                                      child: const TarotCardSingle(
                                        img: "assets/backgroundcard.png",
                                        width: 100,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Visibility(
                              visible: card3Value,
                              child: TweenAnimationBuilder(
                                duration: const Duration(milliseconds: 800),
                                tween: Tween<double>(begin: pi, end: 0),
                                builder: (context, double value, child) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Transform(
                                      transform: Matrix4.identity()
                                        ..setEntry(3, 2, 0.001)
                                        ..rotateY(value),
                                      alignment: Alignment.center,
                                      child: const TarotCardSingle(
                                        img: "assets/backgroundcard.png",
                                        width: 100,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 25),
            ValueListenableBuilder(
              valueListenable: rotate,
              builder: (
                BuildContext context,
                dynamic value,
                Widget? child,
              ) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Transform.rotate(
                    angle: 2 * pi * value,
                    child: TarotCardSingle(
                      img: "assets/desen.png",
                      width: width(context) < 700 ? width(context) * 0.4 : 200,
                      color: textColor,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 25),
            Text(
              "Kartlar Karıştırılıyor...",
              style: GoogleFonts.poppins(
                color: textColor.withOpacity(0.5),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 50),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
