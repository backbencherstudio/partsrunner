import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:partsrunner/core/constant/user_role.dart';
import 'package:partsrunner/core/routes/app_route_names.dart';
import 'package:partsrunner/features/bottom_nav/presentation/providers/bottom_nav_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key, required this.userRole});
  final UserRole userRole;

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
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
              "S M Al Fuad Nur",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text("contact@alfuad.me"),

            Column(
              children: [
                _profileTab("assets/images/index1.png", "Edit Profile", () {
                  context.pushNamed(AppRouteNames.editProfile);
                }),
                Divider(),
                if (widget.userRole == UserRole.contractor)
                  _profileTab(
                    "assets/images/index2.png",
                    "Payment Management",
                    () {
                      context.pushNamed(AppRouteNames.paymentManagement);
                    },
                  ),
                if (widget.userRole == UserRole.runner)
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
                  ref.invalidate(bottomNavProvider);
                  context.goNamed(AppRouteNames.login);
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
