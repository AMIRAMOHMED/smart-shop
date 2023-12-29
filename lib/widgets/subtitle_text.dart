import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubtitleTextWidget extends StatelessWidget {
  const SubtitleTextWidget(
      {super.key,
      this.fontStyle,
      this.textDecoration,
      this.fontWeight,
      this.color,
      required this.label,
      required this.fontSize});

  final FontWeight? fontWeight;
  final Color? color;
  final String label;
  final double fontSize;

  final TextDecoration? textDecoration;
  final FontStyle? fontStyle;

  @override
  Widget build(BuildContext context) {
    return Text(label,
        style: TextStyle(
            fontStyle: fontStyle,
            fontSize: fontSize,
            overflow: TextOverflow.visible,
            fontWeight: fontWeight,
            decoration: textDecoration,
            color: color));
  }
}
