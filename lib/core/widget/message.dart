import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:partsrunner/core/widget/customButton.dart';

class Message extends StatelessWidget {
  const Message({
    super.key,
    required this.title,
    required this.message,
    required this.imagePath,
    required this.buttonText,
    this.routeName,
    this.earning,
  });

  final String title;
  final String message;
  final String imagePath;
  final String buttonText;
  final String? routeName;
  final String? earning;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 200, width: 200),
            20.verticalSpace,
            Text(
              title,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                fontFamily: 'Industry',
              ),
              textAlign: TextAlign.center,
            ),
            8.verticalSpace,
            Text(
              message,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            if (earning != null) ...[
              24.verticalSpace,
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.03),
                  border: Border.all(color: Colors.red.shade100),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Text(
                      earning.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text('Added To Balance'),
                  ],
                ),
              ),
            ],
            32.verticalSpace,
            CustomButton(
              text: buttonText,
              submit: () {
                if (routeName != null) {
                  context.goNamed(routeName!);
                }
              },
              backgroundColor: Color(0xffFF4000),
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
