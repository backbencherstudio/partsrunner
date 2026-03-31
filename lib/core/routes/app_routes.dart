import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:partsrunner/core/routes/app_route_names.dart';
import 'package:partsrunner/core/routes/app_route_paths.dart';
import 'package:partsrunner/core/widget/error_screen.dart';
import 'package:partsrunner/features/bottom_nav/presentation/screens/bottom_nav_screen.dart';
import 'package:partsrunner/features/home/presentaion/screens/home_screen.dart';
import 'package:partsrunner/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:partsrunner/features/splash/presentation/screens/splash_screen.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutePaths.splash,
    routes: [
      // Core
      GoRoute(
        path: '/',
        name: AppRouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        name: AppRouteNames.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/message',
        name: AppRouteNames.message,
        builder: (context, state) {
          return const Placeholder();
        },
      ),
      GoRoute(
        path: '/bottomNav',
        name: AppRouteNames.bottomNav,
        builder: (context, state) => const BottomNavScreen(),
      ),
      GoRoute(
        path: '/liveTracking/:id',
        name: AppRouteNames.liveTracking,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        path: '/notification',
        name: AppRouteNames.notification,
        builder: (context, state) => const Placeholder(),
      ),

      // Auth
      GoRoute(
        path: '/auth',
        name: AppRouteNames.auth,
        builder: (context, state) => const Placeholder(),
        routes: [
          GoRoute(
            path: 'selectRole', // ✅ no leading /
            name: AppRouteNames.selectRole,
            builder: (context, state) => const Placeholder(),
          ),
          GoRoute(
            path: 'signup',
            name: AppRouteNames.signup,
            builder: (context, state) => const Placeholder(),
          ),
          GoRoute(
            path: 'otp',
            name: AppRouteNames.otp,
            builder: (context, state) => const Placeholder(),
          ),
          GoRoute(
            path: 'completeInfo',
            name: AppRouteNames.completeInfo,
            builder: (context, state) => const Placeholder(),
          ),
          GoRoute(
            path: 'login',
            name: AppRouteNames.login,
            builder: (context, state) => const Placeholder(),
          ),
          GoRoute(
            path: 'forgetPassword',
            name: AppRouteNames.forgetPassword,
            builder: (context, state) => const Placeholder(),
          ),
          GoRoute(
            path: 'newPassword',
            name: AppRouteNames.newPassword,
            builder: (context, state) => const Placeholder(),
          ),
        ],
      ),

      // Home
      GoRoute(
        path: '/home',
        name: AppRouteNames.home,
        builder: (context, state) => HomeScreen(),
        routes: [
          GoRoute(
            path: 'requestNewDelivery', // ✅ no leading /
            name: AppRouteNames.requestNewDelivery,
            builder: (context, state) => const Placeholder(),
          ),
          GoRoute(
            path: 'checkout',
            name: AppRouteNames.checkout,
            builder: (context, state) => const Placeholder(),
          ),
          GoRoute(
            path: 'jobDetails',
            name: AppRouteNames.jobDetails,
            builder: (context, state) => const Placeholder(),
          ),
          GoRoute(
            path: 'activeJobDetails',
            name: AppRouteNames.activeJobDetails,
            builder: (context, state) => const Placeholder(),
          ),
        ],
      ),

      // Active Tracking
      GoRoute(
        path: '/activeTracking',
        name: AppRouteNames.activeTracking,
        builder: (context, state) => const Placeholder(),
      ),

      // Job
      GoRoute(
        path: '/job',
        name: AppRouteNames.job,
        builder: (context, state) => const Placeholder(),
        routes: [
          GoRoute(
            path: 'packageDetails', // ✅ no leading /
            name: AppRouteNames.packageDetails,
            builder: (context, state) => const Placeholder(),
          ),
        ],
      ),

      // Order
      GoRoute(
        path: '/myOrder',
        name: AppRouteNames.myOrder,
        builder: (context, state) => const Placeholder(),
        routes: [
          GoRoute(
            path: 'orderDetails', // ✅ no leading /
            name: AppRouteNames.orderDetails,
            builder: (context, state) => const Placeholder(),
          ),
        ],
      ),

      // Wallet
      GoRoute(
        path: '/wallet',
        name: AppRouteNames.wallet,
        builder: (context, state) => const Placeholder(),
        routes: [
          GoRoute(
            path: 'withdraw', // ✅ no leading /
            name: AppRouteNames.withdraw,
            builder: (context, state) => const Placeholder(),
          ),
          GoRoute(
            path: 'transactionHistory',
            name: AppRouteNames.transactionHistory,
            builder: (context, state) => const Placeholder(),
          ),
          GoRoute(
            path: 'transactionDetails',
            name: AppRouteNames.transactionDetails,
            builder: (context, state) => const Placeholder(),
          ),
        ],
      ),

      // Profile
      GoRoute(
        path: '/profile',
        name: AppRouteNames.profile,
        builder: (context, state) => const Placeholder(),
        routes: [
          GoRoute(
            path: 'editProfile', // ✅ no leading /
            name: AppRouteNames.editProfile,
            builder: (context, state) => const Placeholder(),
          ),
          GoRoute(
            path: 'deliveryHistory',
            name: AppRouteNames.deliveryHistory,
            builder: (context, state) => const Placeholder(),
          ),
          GoRoute(
            path: 'paymentManagement',
            name: AppRouteNames.paymentManagement,
            builder: (context, state) => const Placeholder(),
          ),
          GoRoute(
            path: 'settings',
            name: AppRouteNames.settings,
            builder: (context, state) => const Placeholder(),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => ErrorScreen(error: state.error),
  );
}
