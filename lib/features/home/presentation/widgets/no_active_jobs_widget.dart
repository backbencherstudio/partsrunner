import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partsrunner/core/constant/app_color.dart';
import 'package:partsrunner/core/widget/custom_container.dart';
import 'package:partsrunner/features/bottom_nav/presentation/providers/bottom_nav_provider.dart';

class NoActiveJobsWidget extends ConsumerWidget {
  const NoActiveJobsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomContainer(
      height: 300.h,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColor.primary.withValues(alpha: 0.2),
                width: 10,
              ),
            ),
            child: Icon(
              Icons.document_scanner,
              color: AppColor.primary,
              size: 30.sp,
            ),
          ),
          24.verticalSpace,
          Text(
            "No Active Jobs",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontFamily: 'Industry',
              fontSize: 24.sp,
            ),
          ),
          8.verticalSpace,
          Text(
            "Accept a job to start your workflow",
            style: TextStyle(fontSize: 16.sp),
          ),
          8.verticalSpace,
          GestureDetector(
            onTap: () {
              ref.read(bottomNavProvider.notifier).state = 1;
            },
            child: Text(
              "View Job History",
              style: TextStyle(
                fontFamily: 'Industry',
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: AppColor.primary,
                decoration: TextDecoration.underline,
                decorationColor: AppColor.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
