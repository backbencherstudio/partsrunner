import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:partsrunner/core/constant/app_color.dart';

class AppTheme {
  static ThemeData themeData = ThemeData(
    appBarTheme: AppBarTheme(backgroundColor: AppColor.white, elevation: 0),
    scaffoldBackgroundColor: Colors.white,
    textTheme: GoogleFonts.interTightTextTheme(),
  );
}
