import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tarot/theme/color.dart';

class MessageBox extends StatelessWidget {
  final bool isRaya;
  final String message;
  final String timestamp;
  final double width;
  const MessageBox({
    super.key,
    required this.isRaya,
    required this.message,
    required this.timestamp,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return isRaya ? raya(context) : me(context);
  }

  Row raya(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 8),
        Container(
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.all(8),
          width: message.length < 80 ? 200 : width * 0.6,
          decoration: BoxDecoration(
            color: navColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Raya",
                style: GoogleFonts.dmSans(
                  color: defaultColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              MarkdownBody(
                data: message,
                selectable: true,
                onTapLink: (text, href, title) async {
                  await openUrl(href ?? "https://bybug.com.tr");
                },
                styleSheet: MarkdownStyleSheet(
                  listBullet: TextStyle(
                    color: defaultColor,
                    fontSize: 18,
                  ),
                  listIndent: 24.0,
                  listBulletPadding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  p: GoogleFonts.dmSans(
                    fontSize: 14,
                    color: textColor,
                  ),
                  h1: GoogleFonts.dmSans(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: defaultColor,
                  ),
                  h2: GoogleFonts.dmSans(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                  h3: GoogleFonts.dmSans(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor.withOpacity(0.8),
                  ),
                  h4: GoogleFonts.dmSans(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor.withOpacity(0.6),
                  ),
                  h5: GoogleFonts.dmSans(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: textColor.withOpacity(0.4),
                  ),
                  blockquote: GoogleFonts.dmMono(
                    fontStyle: FontStyle.italic,
                    color: textColor.withOpacity(0.2),
                  ),
                  codeblockDecoration: BoxDecoration(
                    color: textColor.withOpacity(0.02),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  code: GoogleFonts.sourceCodePro(
                    fontSize: 12,
                    color: textColor.withOpacity(0.7),
                    backgroundColor: Colors.transparent,
                  ),
                  blockquoteDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 2,
                      color: textColor.withOpacity(0.2),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    timestamp,
                    style: GoogleFonts.dmSans(
                      color: textColor.withOpacity(0.6),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row me(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.all(8),
          width: message.length < 80 ? 200 : width * 0.6,
          decoration: BoxDecoration(
            color: navColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Siz",
                style: GoogleFonts.dmSans(
                  color: defaultColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              MarkdownBody(
                data: message,
                selectable: true,
                onTapLink: (text, href, title) async {
                  await openUrl(href ?? "https://bybug.com.tr");
                },
                styleSheet: MarkdownStyleSheet(
                  listBullet: TextStyle(
                    color: defaultColor,
                    fontSize: 18,
                  ),
                  listIndent: 24.0,
                  listBulletPadding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  p: GoogleFonts.dmSans(
                    fontSize: 14,
                    color: textColor,
                  ),
                  h1: GoogleFonts.dmSans(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: defaultColor,
                  ),
                  h2: GoogleFonts.dmSans(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                  h3: GoogleFonts.dmSans(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor.withOpacity(0.8),
                  ),
                  h4: GoogleFonts.dmSans(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor.withOpacity(0.6),
                  ),
                  h5: GoogleFonts.dmSans(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: textColor.withOpacity(0.4),
                  ),
                  blockquote: GoogleFonts.dmMono(
                    fontStyle: FontStyle.italic,
                    color: textColor.withOpacity(0.2),
                  ),
                  codeblockDecoration: BoxDecoration(
                    color: textColor.withOpacity(0.02),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  code: GoogleFonts.sourceCodePro(
                    fontSize: 12,
                    color: textColor.withOpacity(0.7),
                    backgroundColor: Colors.transparent,
                  ),
                  blockquoteDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 2,
                      color: textColor.withOpacity(0.2),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "10:00",
                    style: GoogleFonts.dmSans(
                      color: textColor.withOpacity(0.6),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
