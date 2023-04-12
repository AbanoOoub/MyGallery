import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_gallery_app/data/constants/app_constants.dart';
import 'package:my_gallery_app/helpers/dio.dart';
import 'package:my_gallery_app/helpers/shared_pref.dart';
import 'package:my_gallery_app/network/api_responses/login_response.dart';
import 'package:my_gallery_app/network/api_urls/end_points.dart';

part 'login_screen_state.dart';

class LoginScreenCubit extends Cubit<LoginScreenState> {
  LoginScreenCubit() : super(LoginScreenInitial());

  static LoginScreenCubit get(context) => BlocProvider.of(context);

  final GlobalKey<FormState> loginFormKey = GlobalKey();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late final LoginResponse loginResponse;

  void login({required String userName, required String password}) {
    emit(LoginLoadingState());
    DioHelper.postData(
      endPoint: NetworkEndPoints.loginEndPoint,
      body: FormData.fromMap({
        'email': userName,
        'password': password,
      }),
    ).then((value) {
      if (value.data['token'] != null) {
        loginResponse = LoginResponse.fromJson(value.data);
        saveDataLocally();
        emit(LoginSuccessState());
      } else {
        debugPrint(value.data.toString());
        // Fluttertoast.showToast(msg: 'User Name or Password is Wrong, Try Again!');
        Fluttertoast.showToast(msg: value.data['error_message']);
        emit(LoginFailedState());
      }
    }).catchError((onError) {
      emit(LoginErrorState());
      debugPrint(onError.toString());
    });
  }

  void saveDataLocally() {
    CacheHelper.saveData(key: AppConstantKeys.isLoginKey, val: true);
    CacheHelper.saveData(key: AppConstantKeys.tokenKey, val: loginResponse.token);
    CacheHelper.saveData(key: AppConstantKeys.userNameKey, val: loginResponse.user.name);
  }
}
