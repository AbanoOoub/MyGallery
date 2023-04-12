import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_gallery_app/data/constants/app_constants.dart';
import 'package:my_gallery_app/helpers/dio.dart';
import 'package:my_gallery_app/helpers/shared_pref.dart';
import 'package:my_gallery_app/network/api_responses/my_gallery_response.dart';
import 'package:my_gallery_app/network/api_urls/end_points.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(HomeScreenInitial());

  static HomeScreenCubit get(context) => BlocProvider.of(context);

  late MyGalleryResponse myGalleryResponse;

  void getGalleryImages() {
    emit(GetGalleryImagesLoadingState());
    DioHelper.getData(
            endPoint: NetworkEndPoints.galleryEndPoint,
            token: CacheHelper.getData(key: AppConstantKeys.tokenKey))
        .then((value) {
      if (value.statusCode == 200) {
        myGalleryResponse = MyGalleryResponse.fromJson(value.data);
        emit(GetGalleryImagesSuccessState());
      } else {
        emit(GetGalleryImagesFailedState());
      }
    }).catchError((onError) {
      debugPrint(onError.toString());
      emit(GetGalleryImagesErrorState());
    });
  }

  void uploadImg({required String path, required String name}) async {
    emit(UploadImageLoadingState());

    DioHelper.postData(
      endPoint: NetworkEndPoints.uploadEndPoint,
      token: CacheHelper.getData(key: AppConstantKeys.tokenKey),
      body: FormData.fromMap({
        "img": await MultipartFile.fromFile(path, filename: name),
      }),
    ).then((value) {
      if (value.statusCode == 200) {
        getGalleryImages();
        emit(UploadImageSuccessState());
      }
      Fluttertoast.showToast(msg: value.data['message']);
    }).catchError((onError) {
      Fluttertoast.showToast(msg: 'Something Wrong, Try Again!');
      debugPrint(onError.toString());
      emit(UploadImageErrorState());
    });
  }

  void pickImage({required ImageSource source}) async {
    final ImagePicker picker = ImagePicker();
    await picker
        .pickImage(
      source: source,
    )
        .then((value) {
      if (value != null) {
        uploadImg(path: value.path, name: value.name);
      }
    }).catchError((onError) {
      debugPrint(onError.toString());
    });
  }

  void logOut() {
    CacheHelper.saveData(key: AppConstantKeys.isLoginKey, val: false);
    CacheHelper.saveData(key: AppConstantKeys.tokenKey, val: '');
    emit(LogOutSuccessState());
  }
}
