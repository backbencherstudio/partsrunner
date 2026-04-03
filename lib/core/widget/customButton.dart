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
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = submit == null;
    return Opacity(
      opacity: isDisabled ? 0.6 : 1.0,
      child: GestureDetector(
        onTap: submit,
        child: Container(
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
      ),
    );
  }
}
