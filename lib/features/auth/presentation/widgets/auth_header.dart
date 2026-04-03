import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
    this.hasLogo = true,
    required this.title,
    this.subtitle,
  });

  final bool hasLogo;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          if (hasLogo) ...[
            Image.asset("assets/icons/logo.png", width: 120.w),
            16.verticalSpace,
          ],
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Industry',
            ),
            textAlign: TextAlign.center,
          ),
          8.verticalSpace,
          Text(
            subtitle!,
            style: GoogleFonts.interTight(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
