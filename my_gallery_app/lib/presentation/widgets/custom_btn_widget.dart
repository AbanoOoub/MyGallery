import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';
import 'custom_text_widget.dart';

class CustomBtnWidget extends StatelessWidget {
  const CustomBtnWidget(
      {Key? key,
      required this.img,
      required this.text,
      required this.fontSize,
      required this.textColor,
      required this.btnHeight,
      required this.btnWidth,
      required this.onTap,
      required this.btnColor,
      this.fontWeight = FontWeight.normal})
      : super(key: key);

  final String img;
  final String text;
  final double fontSize;
  final double btnHeight;
  final double btnWidth;
  final Color textColor;
  final Color btnColor;
  final FontWeight fontWeight;

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: btnHeight,
        width: btnWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25.r)),
          color: btnColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(img),
            CustomTextWidget(
                text: text, fontSize: fontSize, fontWeight: fontWeight, textColor: textColor),
          ],
        ),
      ),
    );
  }
}
