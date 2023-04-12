import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_gallery_app/business_logic/home_screen_logic/home_screen_cubit.dart';
import 'package:my_gallery_app/data/constants/app_constants.dart';
import 'package:my_gallery_app/helpers/shared_pref.dart';
import 'package:my_gallery_app/presentation/widgets/custom_btn_widget.dart';
import 'package:my_gallery_app/presentation/widgets/custom_text_widget.dart';
import 'package:my_gallery_app/presentation/widgets/upload_dialog_widget.dart';
import 'package:my_gallery_app/utils/app_colors.dart';
import 'package:my_gallery_app/utils/app_font_details.dart';
import 'package:my_gallery_app/utils/app_routes.dart';

import '../../utils/app_images_details.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeScreenCubit()..getGalleryImages(),
      child: BlocConsumer<HomeScreenCubit, HomeScreenState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is LogOutSuccessState) {
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.loginScreenRoute, (route) => false);
          }
        },
        builder: (context, state) {
          HomeScreenCubit homeScreenCubit = HomeScreenCubit.get(context);
          return Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                AppImagesDetails.homeBackgroundImg,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                body: SafeArea(
                  child: RefreshIndicator(
                    onRefresh: () async => homeScreenCubit.getGalleryImages(),
                    child: Padding(
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextWidget(
                                    text:
                                        'Welcome\n${CacheHelper.getData(key: AppConstantKeys.userNameKey) ?? ''}',
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                    fontWeight: AppFontDetails.boldFontWeight,
                                    fontSize: AppFontDetails.maxFontSize,
                                    textColor: AppColors.textColor.withOpacity(0.8)),
                                CircleAvatar(
                                  radius: 30.r,
                                  backgroundColor: AppColors.whiteColor,
                                  backgroundImage: AssetImage(AppImagesDetails.personImg),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomBtnWidget(
                                  text: 'Log out',
                                  btnHeight: 40.w,
                                  btnWidth: 145.w,
                                  btnColor: AppColors.secondColor,
                                  img: AppImagesDetails.logoutImg,
                                  fontSize: AppFontDetails.mediumFontSize,
                                  textColor: AppColors.textColor,
                                  onTap: () {
                                    homeScreenCubit.logOut();
                                  },
                                ),
                                CustomBtnWidget(
                                  text: 'upload',
                                  btnHeight: 40.w,
                                  btnWidth: 145.w,
                                  btnColor: AppColors.secondColor,
                                  img: AppImagesDetails.uploadImg,
                                  fontSize: AppFontDetails.mediumFontSize,
                                  textColor: AppColors.textColor,
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => UploadDialogWidget(
                                        onTapGallery: () {
                                          homeScreenCubit.pickImage(source: ImageSource.gallery);
                                          Navigator.pop(context);
                                        },
                                        onTapCamera: () {
                                          homeScreenCubit.pickImage(source: ImageSource.camera);
                                          Navigator.pop(context);
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: state is GetGalleryImagesLoadingState
                                ? Center(
                                    child: CircularProgressIndicator(color: AppColors.mainColor),
                                  )
                                : homeScreenCubit.myGalleryResponse.images.imagesUrls.isNotEmpty
                                    ? GridView.count(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 20.w,
                                        crossAxisSpacing: 20.w,
                                        children: List.generate(
                                          homeScreenCubit
                                              .myGalleryResponse.images.imagesUrls.length,
                                          (index) => CachedNetworkImage(
                                            imageBuilder: (context, imageProvider) => ClipRRect(
                                              borderRadius: BorderRadius.circular(12.r),
                                              child: Image(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            imageUrl: homeScreenCubit
                                                .myGalleryResponse.images.imagesUrls[index],
                                            progressIndicatorBuilder: (context, url, progress) =>
                                                Center(
                                              child: CircularProgressIndicator(
                                                  value: progress.progress,
                                                  color: AppColors.complementaryColor1),
                                            ),
                                            errorWidget: (context, url, error) =>
                                                const Icon(Icons.error),
                                          ),
                                        ),
                                      )
                                    : Center(
                                        child: CustomTextWidget(
                                            text: 'No Images Yet',
                                            fontSize: AppFontDetails.mediumFontSize,
                                            fontWeight: AppFontDetails.boldFontWeight,
                                            textColor: AppColors.textColor)),
                          ),
                          if (state is UploadImageLoadingState) ...[
                            Center(
                                child: CircularProgressIndicator(
                              color: AppColors.mainColor,
                            ))
                          ]
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
