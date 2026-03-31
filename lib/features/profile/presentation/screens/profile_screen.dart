import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:partsrunner/core/routes/app_route_names.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
              "Mohammad Wahab",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text("wahab@gmail.com"),

            Column(
              children: [
                _profileTab("assets/images/index1.png", "Edit Profile", () {}),
                Divider(),
                _profileTab(
                  "assets/images/index2.png",
                  "Payment Management",
                  () {},
                ),
                Divider(),
                _profileTab("assets/images/setting.png", "Settings ", () {}),
                Divider(),
                _profileTab("assets/images/logout.png", "Log out", () {
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
