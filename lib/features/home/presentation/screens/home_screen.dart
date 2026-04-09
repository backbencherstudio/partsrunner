import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partsrunner/core/constant/user_role.dart';
import 'package:partsrunner/features/home/presentation/providers/home_provider.dart';
import 'package:partsrunner/features/home/presentation/widgets/contactor_home_widget.dart';
import 'package:partsrunner/features/home/presentation/widgets/floating_card.dart';
import 'package:partsrunner/features/home/presentation/widgets/home_header.dart';
import 'package:partsrunner/features/home/presentation/widgets/runner_home_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key, required this.userRole});
  final UserRole userRole;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeNotifierProvider);
    final homeNotifier = ref.read(homeNotifierProvider.notifier);

    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeHeader(height: userRole == UserRole.contractor ? 300.h : 280.h),
            Transform.translate(
              offset: Offset(0, userRole == UserRole.contractor ? -80 : -50),
              child: Column(
                children: [
                  userRole == UserRole.contractor
                      ? FloatingCard(isContactor: true)
                      : FloatingCard(),
                  20.verticalSpace,
                  if (userRole == UserRole.contractor) ...[
                    ContactorHomeWidget(),
                  ] else ...[
                    RunnerHomeWidget(),
                  ],
                ],
              ),
            ),
            // 110.verticalSpace,
          ],
        ),
      ),
    );
  }
}
