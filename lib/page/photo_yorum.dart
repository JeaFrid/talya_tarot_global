import 'dart:io';

import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tarot/controller/controller.dart';
import 'package:tarot/page/home.dart';
import 'package:tarot/services/ai.dart';
import 'package:tarot/theme/color.dart';

class PhotoYorum extends StatefulWidget {
  final String prompt;
  final File photo;
  const PhotoYorum({super.key, required this.prompt, required this.photo});

  @override
  State<PhotoYorum> createState() => _PhotoYorumState();
}

class _PhotoYorumState extends State<PhotoYorum> {
  ValueNotifier<String> yorum = ValueNotifier(
      "Lütfen biraz bekleyin... Gönderdiğiniz fotoğrafı yorumluyorum...");
  a() async {
    String b = await Ai.getAIResponseYorum(
      widget.prompt,
      widget.photo,
    );
    String xx = b.contains("UNAVAILABLE")
        ? "Huh! Talya çok fazla yüklendi. Anlaşılan o ki şu an uygulamayı kullanan kişi sayısı çok fazla. Lütfen 10 dakika sonra tekrar gel!"
        : b;
    yorum.value = xx;
    yorum.notifyListeners();
  }

  @override
  void initState() {
    super.initState();
    a();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
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
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: yorum,
                      builder: (
                        BuildContext context,
                        dynamic value,
                        Widget? child,
                      ) {
                        return Expanded(
                          child: Text(
                            yorum.value,
                            style: GoogleFonts.poppins(
                              color: textColor.withOpacity(0.5),
                              fontSize: 18,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (mounted) {
            CosmosNavigator.pushNonAnimated(
              context,
              const HomePage(),
            );
          }
        },
        backgroundColor: defaultColor,
        child: Icon(
          Icons.home,
          color: textColor,
        ),
      ),
    );
  }
}
