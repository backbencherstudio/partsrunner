import 'dart:ui';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback submit;

  const CustomButton({
    super.key,
    required this.text,
    this.backgroundColor,
    this.textColor,
    required this.submit,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: submit,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xffFF4000), width: 2),
          color: backgroundColor,
        ),
        child: Center(
          child: Text(text, style: TextStyle(color: textColor, fontSize: 20)),
        ),
      ),
    );
  }
}
