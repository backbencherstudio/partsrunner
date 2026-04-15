import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:partsrunner/core/services/api_service/token_service.dart';
import 'package:partsrunner/core/constant/user_role.dart';
import 'package:partsrunner/core/routes/app_route_names.dart';
import 'package:partsrunner/features/auth/domain/entities/user_entity.dart';
import 'package:partsrunner/features/auth/presentation/providers/auth_provider.dart';
import 'package:partsrunner/features/bottom_nav/presentation/providers/bottom_nav_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key, this.user});
  final UserEntity? user;

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(userProvider);
    final currentUser = widget.user ?? userAsync.value;

    if (currentUser == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 70.h),
            Text(
              "Profile",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
              ),
            ),
            ClipOval(
              child: Image.asset(
                "assets/images/profile1.png",
                width: 100.w,
                height: 100.h,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              currentUser.name,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(currentUser.email),
            16.verticalSpace,
            Column(
              children: [
                _profileTab("assets/images/index1.png", "Edit Profile", () {
                  context.pushNamed(
                    AppRouteNames.editProfile,
                    extra: currentUser,
                  );
                }),
                Divider(),
                if (currentUser.type.toLowerCase() == UserRole.contractor.name)
                  _profileTab(
                    "assets/images/index2.png",
                    "Payment Management",
                    () {
                      context.pushNamed(AppRouteNames.paymentManagement);
                    },
                  )
                else
                  _profileTab(
                    "assets/images/index2.2.png",
                    "Delivery History",
                    () {
                      context.pushNamed(AppRouteNames.deliveryHistory);
                    },
                  ),
                Divider(),
                _profileTab("assets/images/settings.png", "Settings ", () {
                  context.pushNamed(AppRouteNames.settings);
                }),
                Divider(),
                _profileTab("assets/images/logout.png", "Log out", () async {
                  print("Logging out...");
                  await TokenService.deleteAll();
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.clear();
                  ref.invalidate(bottomNavProvider);
                  ref.invalidate(userProvider);
                  context.goNamed(AppRouteNames.login);
                  print("Logged out successfully");
                }),
                Divider(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileTab(String image, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Image.asset(image, height: 50.h, width: 50.w),
          Text(title),
          Spacer(),
          Icon(Icons.arrow_forward_ios_outlined),
        ],
      ),
    );
  }
}
