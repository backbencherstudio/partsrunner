import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partsrunner/core/constant/user_role.dart';
import 'package:partsrunner/features/home/presentaion/widgets/contactor_home_widget.dart';
import 'package:partsrunner/features/home/presentaion/widgets/floating_card.dart';
import 'package:partsrunner/features/home/presentaion/widgets/home_header.dart';
import 'package:partsrunner/features/home/presentaion/widgets/runner_home_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.userRole});
  final UserRole userRole;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                HomeHeader(
                  height: widget.userRole == UserRole.contractor ? 300.h : 280.h,
                ),
                Positioned(
                  bottom: widget.userRole == UserRole.contractor ? -80 : -50,
                  left: 20,
                  right: 20,
                  child: widget.userRole == UserRole.contractor
                      ? FloatingCard(isContactor: true)
                      : FloatingCard(),
                ),
              ],
            ),
            if (widget.userRole == UserRole.contractor) ...[
              100.verticalSpace,
              ContactorHomeWidget(),
            ] else ...[
              80.verticalSpace,
              RunnerHomeWidget(),
            ],
            110.verticalSpace,
          ],
        ),
      ),
    );
  }
}
