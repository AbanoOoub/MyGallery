import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_gallery_app/data/constants/app_constants.dart';
import 'package:my_gallery_app/helpers/bloc_observer.dart';
import 'package:my_gallery_app/helpers/dio.dart';
import 'package:my_gallery_app/helpers/shared_pref.dart';
import 'package:my_gallery_app/utils/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await DioHelper.init();
  Bloc.observer = MyBlocObserver();
  ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return ScreenUtilInit(
      splitScreenMode: false,
      designSize: const Size(428, 926),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Gallery',
        initialRoute: CacheHelper.getData(key: AppConstantKeys.isLoginKey) ?? false
            ? AppRoutes.homeScreenRoute
            : AppRoutes.loginScreenRoute,
        routes: AppRoutes.routes,
      ),
    );
  }
}
