import 'package:flutter/material.dart';

class CustomTextBtnWidget extends StatelessWidget {
  const CustomTextBtnWidget(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.backgroundColor,
      this.borderColor = Colors.transparent,
      this.borderRadius = BorderRadius.zero,
      required this.textColor,
      required this.fontSize})
      : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color borderColor;
  final BorderRadius borderRadius;
  final Color textColor;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: borderRadius,
            side: BorderSide(color: borderColor),
          ),
        ),
      ),
      child: Text(text, style: TextStyle(color: textColor, fontSize: fontSize)),
    );
  }
}
