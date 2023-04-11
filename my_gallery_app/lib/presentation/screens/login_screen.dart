import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_gallery_app/business_logic/login_screen_logic/login_screen_cubit.dart';
import 'package:my_gallery_app/presentation/widgets/custom_text_btn_widget.dart';
import 'package:my_gallery_app/presentation/widgets/custom_text_form_field_widget.dart';
import 'package:my_gallery_app/presentation/widgets/custom_text_widget.dart';
import 'package:my_gallery_app/utils/app_colors.dart';
import 'package:my_gallery_app/utils/app_images_details.dart';
import 'package:my_gallery_app/utils/app_routes.dart';

import '../../utils/app_font_details.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginScreenCubit(),
      child: BlocConsumer<LoginScreenCubit, LoginScreenState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is LoginSuccessState) {
            Navigator.pushReplacementNamed(context, AppRoutes.homeScreenRoute);
          }
        },
        builder: (context, state) {
          LoginScreenCubit loginScreenCubit = LoginScreenCubit.get(context);
          return Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                AppImagesDetails.loginBackgroundImg,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                body: Center(
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomTextWidget(
                              text: 'My \n Gallery',
                              fontSize: 40.sp,
                              maxLines: 2,
                              fontWeight: AppFontDetails.boldFontWeight,
                              textColor: AppColors.textColor),
                          Padding(
                            padding: EdgeInsets.all(25.w),
                            child: Container(
                              height: 388.w,
                              width: 345.w,
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor.withOpacity(0.5),
                                borderRadius: BorderRadius.all(Radius.circular(20.r)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(20.w),
                                child: Form(
                                  key: loginScreenCubit.loginFormKey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CustomTextWidget(
                                          text: 'Log in',
                                          fontSize: 30.sp,
                                          fontWeight: AppFontDetails.boldFontWeight,
                                          textColor: AppColors.textColor),
                                      CustomTextFormFieldWidget(
                                          controller: loginScreenCubit.userNameController,
                                          hint: 'User Name',
                                          fillColor: AppColors.whiteColor,
                                          textInputType: TextInputType.text,
                                          textColor: AppColors.textColor,
                                          hintColor: AppColors.textColor.withOpacity(0.5),
                                          validator: (String? value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Required';
                                            }
                                            return null;
                                          }),
                                      CustomTextFormFieldWidget(
                                          controller: loginScreenCubit.passwordController,
                                          hint: 'Password',
                                          obscureText: true,
                                          fillColor: AppColors.whiteColor,
                                          textInputType: TextInputType.text,
                                          textColor: AppColors.textColor,
                                          hintColor: AppColors.textColor.withOpacity(0.5),
                                          validator: (String? value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Required';
                                            }
                                            return null;
                                          }),
                                      state is LoginLoadingState
                                          ? Center(
                                              child: CircularProgressIndicator(
                                                  color: AppColors.mainColor),
                                            )
                                          : SizedBox(
                                              width: double.infinity,
                                              height: 55.w,
                                              child: CustomTextBtnWidget(
                                                  text: 'Submit',
                                                  onPressed: () {
                                                    if (loginScreenCubit.loginFormKey.currentState!
                                                        .validate()) {
                                                      loginScreenCubit.login(
                                                          userName: loginScreenCubit
                                                              .userNameController.text,
                                                          password: loginScreenCubit
                                                              .passwordController.text);
                                                    }
                                                  },
                                                  backgroundColor: AppColors.mainColor,
                                                  textColor: AppColors.whiteColor,
                                                  borderRadius:
                                                      BorderRadius.all(Radius.circular(10.r)),
                                                  fontSize: AppFontDetails.mediumFontSize),
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
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
