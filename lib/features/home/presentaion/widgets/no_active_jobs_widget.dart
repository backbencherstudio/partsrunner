import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partsrunner/core/constant/app_color.dart';

class NoActiveJobsWidget extends StatelessWidget {
  const NoActiveJobsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
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
          Text(
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
        ],
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
        border: Border.all(color: AppColor.primary.withValues(alpha: 0.2)),
      ),
      child: child,
    );
  }
}
