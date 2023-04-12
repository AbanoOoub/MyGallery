part of 'home_screen_cubit.dart';

@immutable
abstract class HomeScreenState {}

class HomeScreenInitial extends HomeScreenState {}

class GetGalleryImagesLoadingState extends HomeScreenState {}

class GetGalleryImagesSuccessState extends HomeScreenState {}

class GetGalleryImagesFailedState extends HomeScreenState {}

class GetGalleryImagesErrorState extends HomeScreenState {}

class UploadImageLoadingState extends HomeScreenState {}

class UploadImageSuccessState extends HomeScreenState {}

class UploadImageFailedState extends HomeScreenState {}

class UploadImageErrorState extends HomeScreenState {}

class LogOutSuccessState extends HomeScreenState {}
