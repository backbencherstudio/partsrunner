import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partsrunner/core/constant/user_role.dart';
import 'package:partsrunner/features/bottom_nav/domain/entities/user_entity.dart';
import 'package:partsrunner/features/home/presentation/providers/home_provider.dart';
import 'package:partsrunner/features/home/presentation/widgets/contactor_home_widget.dart';
import 'package:partsrunner/features/home/presentation/widgets/floating_card.dart';
import 'package:partsrunner/features/home/presentation/widgets/home_header.dart';
import 'package:partsrunner/features/home/presentation/widgets/runner_home_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key, required this.user});
  final UserEntity user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeHeader(user: user),
            Transform.translate(
              offset: Offset(
                0,
                user.type.toLowerCase() == UserRole.contractor.name ? -80 : -50,
              ),
              child: Column(
                children: [
                  user.type.toLowerCase() == UserRole.contractor.name
                      ? FloatingCard(isContactor: true)
                      : FloatingCard(),
                  20.verticalSpace,
                  if (user.type.toLowerCase() == UserRole.contractor.name) ...[
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
