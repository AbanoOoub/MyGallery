import 'package:flutter/material.dart';
import 'package:my_gallery_app/utils/app_font_details.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final double fontSize;
  final Color textColor;
  final int maxLines;
  final FontWeight fontWeight;

  const CustomTextWidget({
    Key? key,
    required this.text,
    this.textAlign = TextAlign.center,
    this.maxLines = 1,
    this.fontWeight = FontWeight.normal,
    required this.fontSize,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: AppFontDetails.fontFamily,
        color: textColor,
      ),
    );
  }
}
