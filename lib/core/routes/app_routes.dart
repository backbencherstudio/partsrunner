import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:partsrunner/core/routes/app_route_names.dart';
import 'package:partsrunner/core/routes/app_route_paths.dart';
import 'package:partsrunner/core/widget/message.dart';
import 'package:partsrunner/core/widget/error_screen.dart';
import 'package:partsrunner/features/active_tracking/presentaion/screen/active_tracking_screen.dart';
import 'package:partsrunner/features/active_jobs/presentations/screens/active_jobs_screens.dart';
import 'package:partsrunner/features/auth/presentation/screens/complete_info_screen.dart';
import 'package:partsrunner/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:partsrunner/features/auth/presentation/screens/login_Screen.dart';
import 'package:partsrunner/features/auth/presentation/screens/new_password_screen.dart';
import 'package:partsrunner/features/auth/presentation/screens/otp_screen.dart';
import 'package:partsrunner/features/auth/presentation/screens/select_role_screen.dart';
import 'package:partsrunner/features/auth/presentation/screens/signup_screen.dart';
import 'package:partsrunner/features/bottom_nav/presentation/screens/bottom_nav_screen.dart';
import 'package:partsrunner/features/live_tracking/presentation/screens/live_tracking_screens.dart';
import 'package:partsrunner/features/request_delivery/presentation/screens/checkout_screen.dart';
import 'package:partsrunner/features/home/presentation/screens/home_screen.dart';
import 'package:partsrunner/features/job_details/presentation/screens/active_job_details_screen.dart';
import 'package:partsrunner/features/job_details/presentation/screens/job_details_screen.dart';
import 'package:partsrunner/features/my_order/presentation/screens/my_order_screen.dart';
import 'package:partsrunner/features/my_order/presentation/screens/order_details_screen.dart';
import 'package:partsrunner/features/notification/presentation/screens/notication_screen.dart';
import 'package:partsrunner/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:partsrunner/features/package_details/presentation/screens/package_details_screen.dart';
import 'package:partsrunner/features/profile/presentation/screens/delivery_history_screen.dart';
import 'package:partsrunner/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:partsrunner/features/profile/presentation/screens/payment_management_screen.dart';
import 'package:partsrunner/features/profile/presentation/screens/profile_screen.dart';
import 'package:partsrunner/features/profile/presentation/screens/settings_screen.dart';
import 'package:partsrunner/features/request_delivery/presentation/screens/request_delivery_screen.dart';
import 'package:partsrunner/features/search/presentation/screens/search_result_screen.dart';
import 'package:partsrunner/features/splash/presentation/screens/splash_screen.dart';
import 'package:partsrunner/features/wallet/presentation/screens/transaction_details_screen.dart';
import 'package:partsrunner/features/wallet/presentation/screens/transaction_history_screen.dart';
import 'package:partsrunner/features/wallet/presentation/screens/wallet_screen.dart';
import 'package:partsrunner/features/wallet/presentation/screens/withdraw_screen.dart';

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
          final extra = state.extra as Map<String, dynamic>?;
          return Message(
            title: extra?['title'] ?? '',
            message: extra?['message'] ?? '',
            imagePath: extra?['imagePath'] ?? '',
            buttonText: extra?['buttonText'] ?? '',
            routeName: extra?['routeName'],
            earning: extra?['earning'],
          );
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
        builder: (context, state) => LiveTrackingScreens(id: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/notification',
        name: AppRouteNames.notification,
        builder: (context, state) => const NoticationScreen(),
      ),

      // Auth
      GoRoute(
        path: '/auth',
        name: AppRouteNames.auth,
        builder: (context, state) => const Placeholder(),
        routes: [
          GoRoute(
            path: 'selectRole',
            name: AppRouteNames.selectRole,
            builder: (context, state) => const SelectRoleScreen(),
          ),
          GoRoute(
            path: 'signup',
            name: AppRouteNames.signup,
            builder: (context, state) => const SignupScreen(),
          ),
          GoRoute(
            path: 'otp',
            name: AppRouteNames.otp,
            builder: (context, state) {
              final extra = state.extra as Map<String, dynamic>?;
              return OtpScreen(
                previousRoute: extra?['previousRoute'] ?? '',
                email: extra?['email'] ?? '',
                phone: extra?['phone'] ?? '',
                countryCode: extra?['countryCode'] ?? '',
              );
            },
          ),
          GoRoute(
            path: 'completeInfo',
            name: AppRouteNames.completeInfo,
            builder: (context, state) => const CompleteInfoScreen(),
          ),
          GoRoute(
            path: 'login',
            name: AppRouteNames.login,
            builder: (context, state) => const LoginScreen(),
          ),
          GoRoute(
            path: 'forgetPassword',
            name: AppRouteNames.forgetPassword,
            builder: (context, state) => const ForgotPasswordScreen(),
          ),
          GoRoute(
            path: 'newPassword',
            name: AppRouteNames.newPassword,
            builder: (context, state) {
              final extra = state.extra as Map<String, dynamic>?;
              return NewPasswordScreen(
                email: extra?['email'] ?? '',
                phone: extra?['phone'] ?? '',
                countryCode: extra?['countryCode'] ?? '',
                otp: extra?['otp'] ?? '',
              );
            },
          ),
        ],
      ),

      // Home
      GoRoute(
        path: '/home',
        name: AppRouteNames.home,
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: 'search',
            name: AppRouteNames.search,
            builder: (context, state) => const SearchResultScreen(),
          ),
          GoRoute(
            path: 'requestNewDelivery',
            name: AppRouteNames.requestNewDelivery,
            builder: (context, state) => const RequestDeliveryScreen(),
          ),
          GoRoute(
            path: 'checkout',
            name: AppRouteNames.checkout,
            builder: (context, state) => const CheckoutScreen(),
          ),
          GoRoute(
            path: 'jobDetails',
            name: AppRouteNames.jobDetails,
            builder: (context, state) =>
                JobDetailsScreen(id: state.extra as String),
          ),
          GoRoute(
            path: 'activeJobDetails',
            name: AppRouteNames.activeJobDetails,
            builder: (context, state) =>
                ActiveJobDetailsScreen(id: state.extra as String),
          ),
        ],
      ),

      // Active Tracking
      GoRoute(
        path: '/activeTracking',
        name: AppRouteNames.activeTracking,
        builder: (context, state) => const ActiveTrackingScreen(),
      ),

      // Job
      GoRoute(
        path: '/job',
        name: AppRouteNames.job,
        builder: (context, state) => const ActiveJobsScreen(),
        routes: [
          GoRoute(
            path: 'packageDetails',
            name: AppRouteNames.packageDetails,
            builder: (context, state) =>
                PackageDetailsScreen(id: state.extra as String),
          ),
        ],
      ),

      // Order
      GoRoute(
        path: '/myOrder',
        name: AppRouteNames.myOrder,
        builder: (context, state) => const MyOrderScreen(),
        routes: [
          GoRoute(
            path: 'orderDetails',
            name: AppRouteNames.orderDetails,
            builder: (context, state) =>
                OrderDetailsScreen(id: state.extra as String),
          ),
        ],
      ),

      // Wallet
      GoRoute(
        path: '/wallet',
        name: AppRouteNames.wallet,
        builder: (context, state) => const WalletScreen(),
        routes: [
          GoRoute(
            path: 'withdraw',
            name: AppRouteNames.withdraw,
            builder: (context, state) => const WithdrawScreen(),
          ),
          GoRoute(
            path: 'transactionHistory',
            name: AppRouteNames.transactionHistory,
            builder: (context, state) => const TransactionHistoryScreen(),
          ),
          GoRoute(
            path: 'transactionDetails',
            name: AppRouteNames.transactionDetails,
            builder: (context, state) => const TransactionDetailsScreen(),
          ),
        ],
      ),

      // Profile
      GoRoute(
        path: '/profile',
        name: AppRouteNames.profile,
        builder: (context, state) => const ProfileScreen(),
        routes: [
          GoRoute(
            path: 'editProfile',
            name: AppRouteNames.editProfile,
            builder: (context, state) => const EditProfileScreen(),
          ),
          GoRoute(
            path: 'deliveryHistory',
            name: AppRouteNames.deliveryHistory,
            builder: (context, state) => const DeliveryHistoryScreen(),
          ),
          GoRoute(
            path: 'paymentManagement',
            name: AppRouteNames.paymentManagement,
            builder: (context, state) => const PaymentManagementScreen(),
          ),
          GoRoute(
            path: 'settings',
            name: AppRouteNames.settings,
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => ErrorScreen(error: state.error),
  );
}
