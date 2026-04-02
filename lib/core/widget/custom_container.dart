import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partsrunner/core/constant/app_color.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, this.child, this.height, this.width});

  final Widget? child;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: width,
      height: height,
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
