import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_gallery_app/utils/app_font_details.dart';

import '../../utils/app_colors.dart';
import 'custom_text_widget.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;
  final String? label;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;
  final TextAlign textAlign;
  final FormFieldValidator<String> validator;
  final bool readOnly;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final Color? fillColor;
  final Color? hintColor;
  final Color? textColor;
  final void Function(String)? onChange;
  final void Function()? onEditingComplete;

  const CustomTextFormFieldWidget({
    Key? key,
    required this.hint,
    this.label,
    this.suffixIcon,
    this.obscureText = false,
    this.readOnly = false,
    this.textInputType,
    this.textInputAction,
    this.textAlign = TextAlign.start,
    this.fillColor,
    this.hintColor,
    this.textColor,
    this.controller,
    this.onChange,
    required this.validator,
    this.prefixIcon,
    this.onEditingComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return label != null
        ? Padding(
            padding: EdgeInsets.only(bottom: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 5.w),
                  child: CustomTextWidget(
                    text: label!,
                    fontSize: AppFontDetails.mediumFontSize,
                    textColor: AppColors.blackColor,
                    fontWeight: AppFontDetails.normalFontWeight,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 80.w,
                  child: Center(
                    child: TextFormField(
                      readOnly: readOnly,
                      obscureText: obscureText,
                      controller: controller,
                      keyboardType: textInputType,
                      textInputAction: textInputAction,
                      onChanged: onChange,
                      textAlign: textAlign,
                      textAlignVertical: TextAlignVertical.center,
                      validator: validator,
                      onEditingComplete: onEditingComplete,
                      style: TextStyle(
                        color: textColor ?? AppColors.mainColor,
                        fontSize: AppFontDetails.smallFontSize,
                      ),
                      decoration: InputDecoration(
                        suffixIcon: suffixIcon,
                        prefixIcon: prefixIcon,
                        hintText: hint,
                        hintStyle: TextStyle(color: hintColor ?? AppColors.mainColor),
                        filled: fillColor != null,
                        fillColor: fillColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(color: AppColors.whiteColor, width: 1.w),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(color: AppColors.errorColor, width: 1.w),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(color: AppColors.whiteColor, width: 1.w),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(color: AppColors.whiteColor, width: 1.w),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : SizedBox(
            width: double.infinity,
            height: 80.w,
            child: Center(
              child: TextFormField(
                readOnly: readOnly,
                obscureText: obscureText,
                controller: controller,
                keyboardType: textInputType,
                textInputAction: textInputAction,
                onChanged: onChange,
                textAlign: textAlign,
                textAlignVertical: TextAlignVertical.center,
                validator: validator,
                onEditingComplete: onEditingComplete,
                style: TextStyle(
                  color: textColor ?? AppColors.mainColor,
                  fontSize: AppFontDetails.smallFontSize,
                ),
                decoration: InputDecoration(
                  suffixIcon: suffixIcon,
                  prefixIcon: prefixIcon,
                  hintText: hint,
                  hintStyle: TextStyle(color: hintColor ?? AppColors.mainColor),
                  filled: fillColor != null,
                  fillColor: fillColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.r),
                    borderSide: BorderSide(color: AppColors.whiteColor, width: 1.w),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.r),
                    borderSide: BorderSide(color: AppColors.errorColor, width: 1.w),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.r),
                    borderSide: BorderSide(color: AppColors.whiteColor, width: 1.w),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.r),
                    borderSide: BorderSide(color: AppColors.whiteColor, width: 1.w),
                  ),
                ),
              ),
            ),
          );
  }
}
