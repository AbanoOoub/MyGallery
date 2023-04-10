import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_gallery_app/utils/app_routes.dart';

void main() {
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
    return ScreenUtilInit(
      splitScreenMode: false,
      designSize: const Size(428, 926),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Gallery',
        initialRoute: AppRoutes.loginScreenRoute,
        routes: AppRoutes.routes,
      ),
    );
  }
}
