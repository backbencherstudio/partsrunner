import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partsrunner/core/constant/user_role.dart';
import 'package:partsrunner/features/auth/domain/entities/user_entity.dart';
import 'package:partsrunner/features/auth/presentation/providers/auth_provider.dart';
import 'package:partsrunner/features/home/presentation/widgets/contactor_home_widget.dart';
import 'package:partsrunner/features/home/presentation/widgets/home_header.dart';
import 'package:partsrunner/features/home/presentation/widgets/runner_home_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key, this.user});
  final UserEntity? user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProvider);
    final currentUser = user ?? userAsync.value;

    return Scaffold(
      body: currentUser == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomeHeader(user: currentUser),
                  Transform.translate(
                    offset: Offset(
                      0,
                      currentUser.type.toLowerCase() == UserRole.contractor.name
                          ? -80
                          : -50,
                    ),
                    child:
                        currentUser.type.toLowerCase() ==
                            UserRole.contractor.name
                        ? ContactorHomeWidget()
                        : RunnerHomeWidget(),
                  ),
                  60.verticalSpace,
                ],
              ),
            ),
    );
  }
}
