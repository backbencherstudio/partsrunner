import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:partsrunner/core/constant/user_role.dart';
import 'package:partsrunner/core/routes/app_route_names.dart';
import 'package:partsrunner/features/auth/presentation/providers/auth_provider.dart';
import 'package:partsrunner/features/auth/presentation/widgets/auth_header.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectRoleScreen extends ConsumerWidget {
  const SelectRoleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedRole = ref.watch(selectedRoleProvider);
    final pref = SharedPreferences.getInstance();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                16.verticalSpace,
                AuthHeader(
                  title: "How Would You Like to Start?",
                  subtitle:
                      "Select the option that best describes you to access the features and services tailored specifically to your needs.",
                ),
                48.verticalSpace,
                _roleCard(
                  title: "Contractor",
                  description:
                      "Find runner easily, create delivery requests, track runners with ETAs.",
                  isSelected: selectedRole == UserRole.contractor,
                  onTap: () async {
                    ref.read(selectedRoleProvider.notifier).state =
                        UserRole.contractor;
                    await pref.then(
                      (value) =>
                          value.setString('userRole', UserRole.contractor.name),
                    );
                    if (context.mounted) {
                      context.goNamed(AppRouteNames.signup);
                    }
                  },
                ),
                20.verticalSpace,
                _roleCard(
                  title: "Runner",
                  description:
                      "Accept jobs, confirm pickups, upload delivery photos, and receive payments in-app.",
                  isSelected: selectedRole == UserRole.runner,
                  onTap: () async {
                    ref.read(selectedRoleProvider.notifier).state =
                        UserRole.runner;
                    await pref.then(
                      (value) =>
                          value.setString('userRole', UserRole.runner.name),
                    );
                    if (context.mounted) {
                      context.goNamed(AppRouteNames.signup);
                    }
                  },
                ),
                48.verticalSpace,
                Text(
                  textAlign: TextAlign.center,
                  "This site is protected by Parts Runner Google Privacy Policy and Terms of Service apply",
                  style: TextStyle(color: Colors.black54),
                ),
                8.verticalSpace,
                Text(
                  "Support • Privacy Policy",
                  style: TextStyle(color: Color(0xffFF4000)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _roleCard({
    required String title,
    required String description,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? const Color(0xffFF4000) : Colors.grey,
          ),
          color: isSelected ? const Color(0xfffff0f0) : Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? const Color(0xffFF4000)
                          : Colors.black,
                    ),
                  ),
                  4.verticalSpace,
                  Text(
                    description,
                    style: TextStyle(fontSize: 13.sp, color: Colors.black54),
                  ),
                ],
              ),
            ),
            8.horizontalSpace,
            Icon(
              Icons.arrow_forward,
              color: isSelected ? const Color(0xffFF4000) : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
