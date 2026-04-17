import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:partsrunner/core/constant/app_color.dart';

class AppTheme {
  static ThemeData themeData = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.white,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontFamily: 'industry',
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
    textTheme: GoogleFonts.interTightTextTheme(),
  );
}
