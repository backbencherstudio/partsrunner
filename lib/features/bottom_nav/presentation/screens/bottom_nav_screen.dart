import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partsrunner/core/constant/user_role.dart';
import 'package:partsrunner/features/active_jobs/presentations/screens/active_jobs_screens.dart';
import 'package:partsrunner/features/wallet/presentation/screens/wallet_screen.dart';
import '../../../activeTracking/presentaion/screen/active_tracking_screen.dart';
import '../../../home/presentaion/screens/home_screen.dart';
import '../../../my_order/presentation/screens/my_order_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../providers/bottom_nav_provider.dart';

class BottomNavScreen extends ConsumerStatefulWidget {
  const BottomNavScreen({super.key});

  @override
  ConsumerState<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends ConsumerState<BottomNavScreen> {
  late UserRole _userRole;

  @override
  void initState() {
    getUserRole();
    super.initState();
  }

  Future getUserRole() async {
    _userRole = UserRole.contractor;
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(bottomNavProvider);

    final screens = [
      HomeScreen(userRole: _userRole),
      _userRole == UserRole.contractor
          ? const ActiveTrackingScreen()
          : ActiveJobsScreen(),
      _userRole == UserRole.contractor ? const MyOrderScreen() : WalletScreen(),
      ProfileScreen(userRole: _userRole),
    ];

    return Scaffold(
      extendBody: true,
      backgroundColor: Color(0xffF6F7F7),
      body: screens[currentIndex],
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
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
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem("assets/images/index0.png", 0, currentIndex, ref),
              _buildNavItem(
                _userRole == UserRole.contractor
                    ? "assets/images/index1.png"
                    : "assets/images/index2.png",
                1,
                currentIndex,
                ref,
              ),
              _buildNavItem(
                _userRole == UserRole.contractor
                    ? "assets/images/index2.png"
                    : "assets/images/index2.2.png",
                2,
                currentIndex,
                ref,
              ),
              _buildNavItem("assets/images/profile.png", 3, currentIndex, ref),
            ],
          ),
        ),
      ),
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
          color: isSelect ? Color(0xffFF4000) : Colors.transparent,
        ),
        child: Image.asset(
          imagePath,
          height: 40.h,
          color: isSelect ? Color(0xffFFFFFF) : Color(0xffFF4000),
        ),
      ),
    );
  }
}
