import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarot/controller/controller.dart';
import 'package:tarot/page/fal_etap_2.dart';
import 'package:tarot/theme/color.dart';

class FalPage extends StatefulWidget {
  const FalPage({super.key});

  @override
  State<FalPage> createState() => _FalPageState();
}

class _FalPageState extends State<FalPage> {
  getData() async {
    SharedPreferences db = await SharedPreferences.getInstance();
    if (db.getString("user_name") != null && db.getString("user_old") != null) {
      name.text = db.getString("user_name") ?? "";
      old.text = db.getString("user_old") ?? "";
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.sizeOf(context).width < 600
        ? const FalPageMobile()
        : const FalPagePc();
  }
}

class FalPageMobile extends StatelessWidget {
  const FalPageMobile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
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
                          "İlk Etap",
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
              TextFieldTT(
                text: "Niyetinizi birkaç kelime ile tarif edin...",
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: niyet,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: defaultColor,
        onPressed: () {
          if (name.text.length >= 2 &&
              old.text.length >= 2 &&
              niyet.text.length >= 5) {
            CosmosNavigator.pushNonAnimated(
              context,
              const FalPageIkinci(),
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
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.text,
            style: GoogleFonts.poppins(
              color: _isFocused ? defaultColor : textColor.withOpacity(0.7),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Focus(
            onFocusChange: (focused) {
              setState(() {
                _isFocused = focused;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color:
                      _isFocused ? defaultColor : defaultColor.withOpacity(0.3),
                  width: 2,
                ),
                boxShadow: _isFocused
                    ? [
                        BoxShadow(
                          color: defaultColor.withOpacity(0.1),
                          blurRadius: 8,
                          spreadRadius: 2,
                        )
                      ]
                    : [],
              ),
              child: TextField(
                keyboardType: widget.keyboardType,
                maxLines: widget.maxLines,
                inputFormatters: widget.inputFormatters,
                style: GoogleFonts.poppins(
                  color: textColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
                cursorColor: defaultColor,
                controller: widget.controller,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  border: InputBorder.none,
                  hintStyle: GoogleFonts.poppins(
                    color: textColor.withOpacity(0.5),
                    fontWeight: FontWeight.w400,
                  ),
                  hintText: widget.text,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FalPagePc extends StatelessWidget {
  const FalPagePc({
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
                              "İlk Etap",
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
                  TextFieldTT(
                    text: "Niyetinizi birkaç kelime ile tarif edin...",
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: niyet,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: defaultColor,
        onPressed: () {
          if (name.text.length >= 2 &&
              old.text.length >= 2 &&
              niyet.text.length >= 5) {
            CosmosNavigator.pushNonAnimated(
              context,
              const FalPageIkinci(),
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
