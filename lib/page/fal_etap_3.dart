import 'package:cosmos/cosmos.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarot/page/fal_etap_4.dart';
import 'package:tarot/services/ai.dart';
import 'package:tarot/theme/color.dart';
import 'package:tarot/widget/card_single.dart';

import '../controller/controller.dart';

class FalPageUcuncu extends StatefulWidget {
  final List<Map<String, String>> list;
  const FalPageUcuncu({super.key, required this.list});

  @override
  State<FalPageUcuncu> createState() => _FalPageUcuncuState();
}

class _FalPageUcuncuState extends State<FalPageUcuncu> {
  @override
  void initState() {
    super.initState();
    String card1 = (widget.list[1]["value"] == "true" ? "Ters " : "") +
        (widget.list[0]["name"] ?? "Bilinmeyen");
    String card2 = (widget.list[3]["value"] == "true" ? "Ters " : "") +
        (widget.list[2]["name"] ?? "Bilinmeyen");
    String card3 = (widget.list[5]["value"] == "true" ? "Ters " : "") +
        (widget.list[4]["name"] ?? "Bilinmeyen");

    print("""
◘ Gelen Kartlar ◘

İlk kart: $card1,
İkinci kart: $card2,
Sonuncu kart: $card3,

""");
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
                        "Üçüncü Etap",
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
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Transform.rotate(
                    angle:
                        (widget.list[1]["value"] ?? false) == "true" ? 15.7 : 0,
                    child: TarotCardSingle(
                      img: widget.list[0]["img"] ?? "assets/backgroundcard.png",
                      width: 120,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Transform.rotate(
                    angle:
                        (widget.list[3]["value"] ?? false) == "true" ? 15.7 : 0,
                    child: TarotCardSingle(
                      img: widget.list[2]["img"] ?? "assets/backgroundcard.png",
                      width: 120,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Transform.rotate(
                    angle:
                        (widget.list[5]["value"] ?? false) == "true" ? 15.7 : 0,
                    child: TarotCardSingle(
                      img: widget.list[4]["img"] ?? "assets/backgroundcard.png",
                      width: 120,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Text(
              "Yorumlama yapılmadan önce kartlarınızı görün.",
              style: GoogleFonts.poppins(
                color: textColor.withOpacity(0.5),
                fontSize: 14,
              ),
            ),
            Text(
              "Yorumlamaya göndermek için son etaba ilerleyin.",
              style: GoogleFonts.poppins(
                color: textColor.withOpacity(0.5),
                fontSize: 12,
              ),
            ),
            const Spacer(),
            const Spacer(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          CosmosAlert.loadingIOS(context);
          String card1 = (widget.list[1]["value"] == "true" ? "Ters " : "") +
              (widget.list[0]["name"] ?? "Bilinmeyen");
          String card2 = (widget.list[3]["value"] == "true" ? "Ters " : "") +
              (widget.list[2]["name"] ?? "Bilinmeyen");
          String card3 = (widget.list[5]["value"] == "true" ? "Ters " : "") +
              (widget.list[4]["name"] ?? "Bilinmeyen");

          String b = await Ai.getAIResponse("""
İlk kart: $card1,
İkinci kart: $card2,
Sonuncu kart: $card3,
""");
          String a = b.contains("UNAVAILABLE")
              ? "Huh! Talya çok fazla yüklendi. Anlaşılan o ki şu an uygulamayı kullanan kişi sayısı çok fazla. Lütfen 10 dakika sonra tekrar gel!"
              : b;
          SharedPreferences db = await SharedPreferences.getInstance();
          db.setStringList(CosmosRandom.randomTag(), [
            widget.list[0]["name"] ?? "",
            widget.list[0]["img"] ?? "",
            widget.list[1]["value"] ?? "",
            widget.list[2]["name"] ?? "",
            widget.list[2]["img"] ?? "",
            widget.list[3]["value"] ?? "",
            widget.list[4]["name"] ?? "",
            widget.list[4]["img"] ?? "",
            widget.list[5]["value"] ?? "",
            a,
            name.text,
            old.text,
            niyet.text,
            CosmosTime.getNowTimeString(),
          ]);
          if (mounted) {
            CosmosNavigator.pushNonAnimated(
              // ignore: use_build_context_synchronously
              context,
              FalPageFinal(
                list: widget.list,
                comment: a,
              ),
            );
          }
        },
        backgroundColor: defaultColor,
        child: Icon(
          Icons.arrow_forward,
          color: textColor,
        ),
      ),
    );
  }
}
