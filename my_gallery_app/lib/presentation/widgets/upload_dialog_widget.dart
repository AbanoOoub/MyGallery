import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_font_details.dart';
import '../../utils/app_images_details.dart';
import 'custom_btn_widget.dart';

class UploadDialogWidget extends StatelessWidget {
  const UploadDialogWidget({Key? key, required this.onTapGallery, required this.onTapCamera})
      : super(key: key);

  final void Function() onTapGallery;
  final void Function() onTapCamera;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.whiteColor.withOpacity(0.3),
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25.r))),
      content: Container(
        width: 353.w,
        height: 270.w,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            // color: AppColors.whiteColor.withOpacity(0.2),
            borderRadius: BorderRadius.all(Radius.circular(20.r)),
            border: Border.all(color: AppColors.whiteColor)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomBtnWidget(
                img: AppImagesDetails.galleryImg,
                text: 'Gallery',
                btnColor: AppColors.complementaryColor1,
                fontSize: AppFontDetails.largeFontSize,
                textColor: AppColors.textColor,
                fontWeight: AppFontDetails.boldFontWeight,
                btnHeight: 65.w,
                btnWidth: 184.w,
                onTap: onTapGallery),
            CustomBtnWidget(
                img: AppImagesDetails.cameraImg,
                text: 'Camera',
                btnColor: AppColors.complementaryColor2,
                fontSize: AppFontDetails.largeFontSize,
                fontWeight: AppFontDetails.boldFontWeight,
                textColor: AppColors.textColor,
                btnHeight: 65.w,
                btnWidth: 184.w,
                onTap: onTapCamera),
          ],
        ),
      ),
    );
  }
}
