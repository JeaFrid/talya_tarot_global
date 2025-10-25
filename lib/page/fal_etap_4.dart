import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tarot/page/home.dart';
import 'package:tarot/theme/color.dart';
import 'package:tarot/widget/card_single.dart';

class FalPageFinal extends StatefulWidget {
  final List<Map<String, String>> list;
  final String comment;
  const FalPageFinal({super.key, required this.list, required this.comment});

  @override
  State<FalPageFinal> createState() => _FalPageFinalState();
}

class _FalPageFinalState extends State<FalPageFinal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: CosmosBackgroundImage(
        image: "assets/3d-abstract-space-scene-with-planets (1).jpg",
        child: SafeArea(
          child: Stack(
            children: [
              SizedBox(
                width: width(context),
                height: height(context),
                child: SingleChildScrollView(
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
                                  "Yorumlama",
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
                      const SizedBox(height: 30),
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Transform.rotate(
                              angle:
                                  (widget.list[1]["value"] ?? false) == "true"
                                      ? 15.7
                                      : 0,
                              child: TarotCardSingle(
                                img: widget.list[0]["img"] ??
                                    "assets/backgroundcard.png",
                                width: 120,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Transform.rotate(
                              angle:
                                  (widget.list[3]["value"] ?? false) == "true"
                                      ? 15.7
                                      : 0,
                              child: TarotCardSingle(
                                img: widget.list[2]["img"] ??
                                    "assets/backgroundcard.png",
                                width: 120,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Transform.rotate(
                              angle:
                                  (widget.list[5]["value"] ?? false) == "true"
                                      ? 15.7
                                      : 0,
                              child: TarotCardSingle(
                                img: widget.list[4]["img"] ??
                                    "assets/backgroundcard.png",
                                width: 120,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.comment,
                                style: GoogleFonts.poppins(
                                  color: textColor.withOpacity(0.5),
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                child: IntrinsicHeight(
                  child: GestureDetector(
                    onTap: () async {
                      ShareResult x = await Share.share(widget.comment);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        left: 10,
                        right: 20,
                      ),
                      margin: const EdgeInsets.all(10),
                      width: 140,
                      decoration: BoxDecoration(
                        color: cColor,
                        borderRadius: BorderRadius.circular(1020),
                        boxShadow: [
                          BoxShadow(
                            color: defaultColor.withOpacity(0.5),
                            offset: const Offset(1.6, 2),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.ios_share,
                            color: textColor.withOpacity(0.7),
                          ),
                          Text(
                            "Paylaş",
                            style: GoogleFonts.poppins(
                              color: textColor.withOpacity(0.7),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (mounted) {
            CosmosNavigator.pushNonAnimated(
              context,
              const HomePage(),
            );
          }
        },
        backgroundColor: defaultColor,
        child: Icon(
          Icons.refresh,
          color: textColor,
        ),
      ),
    );
  }
}
