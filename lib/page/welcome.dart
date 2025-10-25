import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarot/controller/controller.dart';
import 'package:tarot/page/home.dart';
import 'package:tarot/theme/color.dart';

import '../widget/card_single.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.sizeOf(context).width < 600
        ? const WelcomeMobile()
        : const WelcomePC();
  }
}

class WelcomeMobile extends StatelessWidget {
  const WelcomeMobile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: width(context) > 1000
                  ? width(context) * 0.35
                  : width(context) * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
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
                              "Hoşgeldiniz!",
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
                  TarotCardSingle(
                    img: "assets/desen.png",
                    width: 300,
                    color: textColor,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Jea ve Tarot'a Hoş Geldiniz!",
                    style: GoogleFonts.poppins(
                      color: textColor,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "Lütfen kendinizi tanıtın.",
                    style: GoogleFonts.poppins(
                      color: textColor.withOpacity(0.5),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFieldTT(
                    text: "Adınız ve Soyadınız Nedir?",
                    controller: name,
                    keyboardType: TextInputType.name,
                    maxLines: 1,
                  ),
                  TextFieldTT(
                    text: "Kaç Yaşındasınız?",
                    controller: old,
                    keyboardType: TextInputType.number,
                    maxLines: 1,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: defaultColor,
        onPressed: () async {
          if (name.text.length >= 2 && old.text.length >= 2) {
            SharedPreferences db = await SharedPreferences.getInstance();
            await db.setString("user_name", name.text.trim());
            await db.setString("user_old", old.text.trim());
            await CosmosNavigator.pushNonAnimated(
              // ignore: use_build_context_synchronously
              context,
              const HomePage(),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content:
                    Text("Lütfen tüm alanları, doğru bir şekilde doldurun."),
              ),
            );
          }
        },
        child: Icon(
          Icons.arrow_forward,
          color: textColor,
        ),
      ),
    );
  }
}

class TextFieldTT extends StatefulWidget {
  final String text;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  const TextFieldTT({
    super.key,
    required this.text,
    required this.controller,
    this.keyboardType,
    this.maxLines,
    this.inputFormatters,
  });

  @override
  State<TextFieldTT> createState() => _TextFieldTTState();
}

class _TextFieldTTState extends State<TextFieldTT> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
      child: TextField(
        keyboardType: widget.keyboardType,
        maxLines: widget.maxLines,
        inputFormatters: widget.inputFormatters,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w400,
        ),
        cursorColor: defaultColor,
        controller: widget.controller,
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: textColor.withOpacity(0.5),
            fontWeight: FontWeight.w400,
          ),
          hintText: widget.text,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: defaultColor.withOpacity(0.4),
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: defaultColor.withOpacity(0.4),
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: defaultColor.withOpacity(0.8),
              width: 2,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: defaultColor.withOpacity(0.4),
              width: 2,
            ),
          ),
          isDense: true,
        ),
      ),
    );
  }
}

class WelcomePC extends StatelessWidget {
  const WelcomePC({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: width(context) > 1000
                  ? width(context) * 0.35
                  : width(context) * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
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
                              "Hoşgeldiniz!",
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
                  TarotCardSingle(
                    img: "assets/desen.png",
                    width: 300,
                    color: textColor,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Jea ve Tarot'a Hoş Geldiniz!",
                    style: GoogleFonts.poppins(
                      color: textColor,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "Lütfen kendinizi tanıtın.",
                    style: GoogleFonts.poppins(
                      color: textColor.withOpacity(0.5),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFieldTT(
                    text: "Adınız Nedir?",
                    controller: name,
                    keyboardType: TextInputType.name,
                    maxLines: 1,
                  ),
                  TextFieldTT(
                    text: "Kaç Yaşındasınız?",
                    controller: old,
                    keyboardType: TextInputType.number,
                    maxLines: 1,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: defaultColor,
        onPressed: () async {
          if (name.text.length >= 2 && old.text.length >= 2) {
            SharedPreferences db = await SharedPreferences.getInstance();
            await db.setString("user_name", name.text.trim());
            await db.setString("user_old", old.text.trim());
            await CosmosNavigator.pushNonAnimated(
              // ignore: use_build_context_synchronously
              context,
              const HomePage(),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content:
                    Text("Lütfen tüm alanları, doğru bir şekilde doldurun."),
              ),
            );
          }
        },
        child: Icon(
          Icons.arrow_forward,
          color: textColor,
        ),
      ),
    );
  }
}
