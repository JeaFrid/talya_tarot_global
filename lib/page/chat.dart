import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tarot/theme/color.dart';
import 'package:tarot/widget/message.dart';

import '../controller/scrollcontroller.dart';
import '../controller/value.dart';
import '../widget/textbox.dart';

class ChatAI extends StatefulWidget {
  const ChatAI({super.key});

  @override
  State<ChatAI> createState() => _ChatAIState();
}

class _ChatAIState extends State<ChatAI> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
      () {
        if (mounted) {
          showMessage(
            context,
            "Merhaba, sevgili danışan!",
            "Nasılsın? Umarım iyisindir. Burası Talya'nın özel odası. Ona sorularını sorabilir ve kartlara bakarak yanıt vermesini isteyebilirsin. Onu selamlamana gerek yok. Direkt sorunu sorarak başla! İyi bakımlar.",
            onTap: () {
              Navigator.pop(context);
              Future.delayed(
                const Duration(seconds: 2),
                () {
                  if (mounted) {
                    messageList.value.add(
                      MessageBox(
                        width: width(context),
                        isRaya: true,
                        message:
                            "Selam, sevgili danışanım. Sorularını sormaya hazırsan, ben başlamaya hazırım. Hadi bana ilk sorunu sor ve kartların ne dediğine birlikte bakalım.",
                        timestamp: CosmosTime.getDateTR(
                          DateTime.now(),
                        ),
                      ),
                    );
                    messageList.notifyListeners();
                  }
                },
              );
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
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Talya",
                    style: GoogleFonts.rochester(
                      color: defaultColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  const Expanded(
                    child: Column(),
                  ),
                  SizedBox(
                    width: width(context) < 900
                        ? width(context)
                        : width(context) * 0.5,
                    child: LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return Column(
                          children: [
                            ValueListenableBuilder(
                              valueListenable: messageList,
                              builder: (
                                BuildContext context,
                                dynamic value,
                                Widget? child,
                              ) {
                                return Expanded(
                                  child: SingleChildScrollView(
                                    controller: scrollController,
                                    // physics: const BouncingScrollPhysics(),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 30),
                                        Column(
                                          children: value,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            TextBoxBottom(
                              width: constraints.maxWidth,
                            ),
                            Text(
                              "Raya, yalnızca çıkan kartlara göre yorum yapar.",
                              style: GoogleFonts.dmSans(
                                color: textColor.withOpacity(0.5),
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        );
                      },
                    ),
                  ),
                  const Expanded(
                    child: Column(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  showMessage(BuildContext context, String title, String subtitle,
      {void Function()? onTap}) {
    return CosmosAlert.showCustomAlert(
      context,
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            width: width(context) < 600 ? widthPercentage(context, 0.8) : 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: cColor,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: defaultColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        subtitle,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 12,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: onTap ??
                          () {
                            Navigator.pop(context);
                          },
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Hadi Başlayalım!",
                          style: TextStyle(
                            color: defaultColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
