import 'package:my_gallery_app/presentation/screens/home_screen.dart';
import 'package:my_gallery_app/presentation/screens/login_screen.dart';

class AppRoutes {
  static String loginScreenRoute = 'loginScreen';
  static String homeScreenRoute = 'homeScreen';

  static get routes {
    return {
      loginScreenRoute: (context) => const LoginScreen(),
      homeScreenRoute: (context) => const HomeScreen(),
    };
  }
}
