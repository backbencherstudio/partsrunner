import 'package:flutter/cupertino.dart';
import 'package:partsrunner/core/routes/route_name.dart';

import '../../features/auth/login/presentaion/login_Screen.dart';
import '../../features/auth/signup/presentaion/signup_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/role_select/select_role_screen.dart';
import '../../features/splash/splash_screen.dart';
class AppRoutes {

  static final Map<String,WidgetBuilder> routes ={

    RouteNames.splashScreen: (context) => const SplashScreen(),
    RouteNames.onboardingScreen: (context) => const OnboardingScreen(),
    RouteNames.selectRoleScreen: (context) => const SelectRoleScreen(),
    RouteNames.signupScreen: (context) => const SignupScreen(),
    RouteNames.loginScreen: (context) => const LoginScreen(),


  };

}