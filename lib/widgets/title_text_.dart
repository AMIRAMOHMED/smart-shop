import 'package:flutter/material.dart';

class TitlesTextWidget extends StatelessWidget {
  const TitlesTextWidget(
      {super.key,
      this.color,
      required this.label,
      this.maxLine,
      required this.fontSize});

  final Color? color;
  final String label;
  final double fontSize;
  final int? maxLine;

  @override
  Widget build(BuildContext context) {
    return Text(label,
        maxLines: maxLine,
        style: TextStyle(
            fontSize: fontSize,
            overflow: TextOverflow.ellipsis,
            fontWeight: FontWeight.bold,
            color: color));
  }
}
