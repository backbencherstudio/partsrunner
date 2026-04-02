import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partsrunner/core/constant/app_color.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, this.viewAll});

  final String title;
  final VoidCallback? viewAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: viewAll,
          child: Text(
            "View All",
            style: TextStyle(
              fontFamily: "Industry",
              color: AppColor.primary,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
          ),
        ),
      ],
    );
  }
}
