import '../app/screen/splash/splash_screen.dart';
import '../app/screen/home/home_screen.dart';
import '../app/screen/auth/login_screen.dart';
import '../app/screen/auth/register_screen.dart';
import '../app/screen/detail/detail_propertyscreen.dart';

class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const detail = '/detail';

  static final routes = {
    splash: (context) => SplashScreen(),
    login: (context) => LoginScreen(),
    register: (context) => RegisterScreen(),
    home: (context) => HomeScreen(),
    detail: (context) => DetailPropertyScreen(),
  };
}
