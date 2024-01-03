import 'package:get/get.dart';
import 'package:patient_app/view/screens/drawer/appoint_screen.dart';
import 'package:patient_app/view/screens/main/main_screen.dart';
import '../view/screens/auth/login_screen.dart';
import '../view/screens/auth/signup_screen.dart';
import '../view/screens/main/splash_screen.dart';

class AppRoutes {

  static const login = '/login';
  static const splash = '/splash';
  static const main = '/main';
  static const home = '/home';


  static final routes = [
    GetPage(
      name: '/login',
      page: () => LoginScreen(),
    ),
    GetPage(
      name: '/signup',
      page: () => SignupScreen(),
    ),
    GetPage(
      name: '/main',
      page: () => MainScreen(),
    ),
    GetPage(
      name: '/splash',
      page: () => SplashScreen(),
    ),


  ];

}