import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tarot/theme/color.dart';

class SanaOzel extends StatelessWidget {
  const SanaOzel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: CosmosBackgroundImage(
        image: "assets/giphy.gif",
        child: Center(
          child: Column(
            children: [
              const Spacer(),
              Text(
                "Sana Özel",
                style: GoogleFonts.poppins(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                width: width(context) * 0.8,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "Sana özel içeriklerimiz, bilgilendirmelerimiz ve seninle birlikte yapacağımız şeyler var.",
                        style: GoogleFonts.poppins(
                          color: textColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                      TextSpan(
                        text:
                            " Aramıza katılarak, Talya'nın gelişimine destek olabileceğini biliyor muydun? ",
                        style: GoogleFonts.poppins(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      TextSpan(
                        text:
                            "Senin istediğin her özelliği bu uygulamaya ekleyebiliriz. Aramıza katıl ve bizden ne istediğini söyle. Biz de senin isteklerini uygulamamıza ekleyelim.",
                        style: GoogleFonts.poppins(
                          color: textColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Bunu nasıl yapabilirsin?",
                style: GoogleFonts.poppins(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                width: width(context) * 0.8,
                child: Text(
                  "Şu an uygulamamızı kullanan insan sayısı, henüz 100'ü bile geçmedi. Hatta 100'ün yarısına bile gelemedik. Ve topluluğumuz da çok yeni. Bu yüzden sen, bizim ilk kullanıcılarımızdan birisin.\n\nİlk olarak yapabileceğin şey, Telegram'da aramıza katılmak.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: textColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: width(context) * 0.8,
                child: Text(
                  "Şimdiden teşekkürler. İyi ki varsın♥",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        await openUrl("https://t.me/talyatarot");
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 14,
                        ),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                            image: AssetImage("assets/giphy (1).gif"),
                            fit: BoxFit.cover,
                            opacity: 0.7,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Telegram Kanalımıza Katıl",
                              style: GoogleFonts.poppins(
                                color: textColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  const Shadow(
                                    color: Colors.black,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        await openUrl("https://t.me/+QE_yMYmlYcs1MmQ0");
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 14,
                        ),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                            image: AssetImage("assets/giphy (3).gif"),
                            fit: BoxFit.cover,
                            opacity: 0.7,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Telegram Grubumuza Katıl",
                              style: GoogleFonts.poppins(
                                color: textColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  const Shadow(
                                    color: Colors.black,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
