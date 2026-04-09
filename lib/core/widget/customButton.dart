import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback? submit;
  final Widget? icon;
  final double? borderRadius;
  final Border? border;
  final double? textSize;
  final EdgeInsetsGeometry? margin;

  const CustomButton({
    super.key,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.submit,
    this.icon,
    this.borderRadius,
    this.border,
    this.textSize,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: submit,
      child: Container(
        margin: margin,
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
          color: backgroundColor,
          border: border,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[icon!, 10.horizontalSpace],
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: textSize ?? 20.sp,
                fontFamily: 'Industry',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
