import 'package:go_router/go_router.dart';
import 'package:partsrunner/core/routes/app_route_names.dart';
import 'package:partsrunner/core/routes/app_route_paths.dart';
import 'package:partsrunner/core/widget/error_screen.dart';
import 'package:partsrunner/features/auth/presentation/screens/signup_screen.dart';
import '../../features/auth/presentation/screens/login_Screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutePaths.splash,
    routes: [
      GoRoute(
        path: AppRoutePaths.splash,
        name: AppRouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.onboarding,
        name: AppRouteNames.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.login,
        name: AppRouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.signup,
        name: AppRouteNames.signup,
        builder: (context, state) => const SignupScreen(),
      ),
    ],
    errorBuilder: (context, state) => ErrorScreen(error: state.error),
  );
}

class SettingsScreen {
  const SettingsScreen();
}
