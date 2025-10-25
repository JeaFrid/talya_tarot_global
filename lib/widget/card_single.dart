import 'package:flutter/material.dart';

class TarotCardSingle extends StatelessWidget {
  final String img;
  final double? width;
  final Color? color;
  const TarotCardSingle({
    super.key,
    required this.img,
    this.width,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Image.asset(
        img,
        width: width ?? 200,
        color: color,
      ),
    );
  }
}
