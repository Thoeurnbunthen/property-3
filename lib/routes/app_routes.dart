import '../app/screen/splash/splash_screen.dart';
import '../app/screen/home/home_screen.dart';
import '../app/screen/auth/login_screen.dart';
import '../app/screen/auth/register_screen.dart';

class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';

  static final routes = {
    splash: (context) => SplashScreen(),
    login: (context) => LoginScreen(),
    register: (context) => RegisterScreen(),
    home: (context) => HomeScreen(),
  };
}
