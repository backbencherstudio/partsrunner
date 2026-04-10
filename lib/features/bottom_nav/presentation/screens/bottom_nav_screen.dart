import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:partsrunner/core/services/api_service/token_storage.dart';
import 'package:partsrunner/core/constant/user_role.dart';
import 'package:partsrunner/core/routes/app_route_names.dart';
import 'package:partsrunner/features/active_jobs/presentations/screens/active_jobs_screens.dart';
import 'package:partsrunner/features/wallet/presentation/screens/wallet_screen.dart';
import '../../../active_tracking/presentaion/screen/active_tracking_screen.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../my_order/presentation/screens/my_order_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../providers/bottom_nav_provider.dart';

class BottomNavScreen extends ConsumerStatefulWidget {
  const BottomNavScreen({super.key});

  @override
  ConsumerState<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends ConsumerState<BottomNavScreen> {
  Future<void> _handleLogout() async {
    ref.invalidate(bottomNavProvider);
    final tokenStorage = TokenStorage();
    await tokenStorage.removeToken();
    if (mounted) {
      context.goNamed(AppRouteNames.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(bottomNavProvider);
    final userAsync = ref.watch(userProvider);

    // Handle logout based on userAsync state
    if (userAsync.hasError) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _handleLogout();
      });
    }

    return userAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) =>
          Scaffold(body: Center(child: Text('Failed to load user data'))),
      data: (user) {
        final screens = [
          HomeScreen(user: user),
          user.type == "CONTRACTOR"
              ? const ActiveTrackingScreen()
              : ActiveJobsScreen(),
          user.type == "CONTRACTOR" ? const MyOrderScreen() : WalletScreen(),
          ProfileScreen(user: user),
        ];

        return Scaffold(
          extendBody: true,
          backgroundColor: const Color(0xffF6F7F7),
          body: screens[currentIndex],
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 72.h,
              margin: EdgeInsets.only(bottom: 15.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.3),
                    spreadRadius: 1.r,
                    blurRadius: 5.r,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(
                    "assets/images/index0.png",
                    0,
                    currentIndex,
                    ref,
                  ),
                  _buildNavItem(
                    user.type == "CONTRACTOR"
                        ? "assets/images/index1.png"
                        : "assets/images/index2.png",
                    1,
                    currentIndex,
                    ref,
                  ),
                  _buildNavItem(
                    user.type == "CONTRACTOR"
                        ? "assets/images/index2.png"
                        : "assets/images/index2.2.png",
                    2,
                    currentIndex,
                    ref,
                  ),
                  _buildNavItem(
                    "assets/images/profile.png",
                    3,
                    currentIndex,
                    ref,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem(
    String imagePath,
    int index,
    int currentIndex,
    WidgetRef ref,
  ) {
    bool isSelect = index == currentIndex;
    return GestureDetector(
      onTap: () {
        ref.read(bottomNavProvider.notifier).state = index;
      },
      child: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelect ? const Color(0xffFF4000) : Colors.transparent,
        ),
        child: Image.asset(
          imagePath,
          height: 40.h,
          color: isSelect ? const Color(0xffFFFFFF) : const Color(0xffFF4000),
        ),
      ),
    );
  }
}
