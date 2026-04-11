import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:partsrunner/core/constant/user_role.dart';
import 'package:partsrunner/core/routes/app_route_names.dart';
import 'package:partsrunner/features/auth/domain/entities/user_entity.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.user});

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: user.type == UserRole.contractor.name ? 300.h : 280.h,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/header.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.only(top: 50),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black.withValues(alpha: 0.7)],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Text(
                      user.name.substring(0, 2).toUpperCase(),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  12.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Good morning, ${user.name}!",
                        style: TextStyle(
                          color: Color(0xffF86816),
                          fontSize: 16,
                        ),
                      ),
                      1.verticalSpace,
                      Text(
                        user.type.toLowerCase() == UserRole.contractor.name
                            ? "Find Your Runner?"
                            : "Find Your Parts?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      context.pushNamed(AppRouteNames.notification);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                      child: const Icon(
                        Icons.notifications_none_outlined,
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(6),
                    child: GestureDetector(
                      onTap: () {
                        context.goNamed(AppRouteNames.search);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xffFFECE6),
                        ),
                        child: const Icon(
                          Icons.search,
                          color: Color(0xffFF4000),
                          size: 26,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
