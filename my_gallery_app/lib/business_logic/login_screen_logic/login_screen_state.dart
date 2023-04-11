part of 'login_screen_cubit.dart';

@immutable
abstract class LoginScreenState {}

class LoginScreenInitial extends LoginScreenState {}

class LoginSuccessState extends LoginScreenState {}

class LoginLoadingState extends LoginScreenState {}

class LoginFailedState extends LoginScreenState {}

class LoginErrorState extends LoginScreenState {}
