import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:partsrunner/core/constant/app_color.dart';
import 'package:partsrunner/core/routes/app_route_names.dart';
import 'package:partsrunner/core/widget/customButton.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key, required this.previousRoute});

  final String previousRoute;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Enter OTP",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              textAlign: TextAlign.center,
              "To verify your email address,\nplease enter the OTP sent to your email\nkristin***i.com",
            ),
            SizedBox(height: 20),
            PinInput(
              length: 5,
              builder: (context, cells) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: cells.map((cell) {
                    return Container(
                      width: 50,
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: cell.isFocused
                            ? Color(0xffFFF4EE)
                            : Colors.grey[200],
                      ),
                      child: Center(
                        child: Text(
                          cell.character ?? '',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
              onCompleted: (pin) => print('PIN: $pin'),
            ),
            SizedBox(height: 20),

            Text(
              "Haven’t you got the OTP yet?",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 14),

            Text(
              "Resend Code",
              style: TextStyle(
                color: Color(0xffFF4000),
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 20),

            CustomButton(
              text: "Continue",
              submit: () {
                if (previousRoute == AppRouteNames.forgetPassword) {
                  context.goNamed(AppRouteNames.newPassword);
                } else {
                  context.goNamed(AppRouteNames.completeInfo);
                }
              },
              backgroundColor: Color(0xffFF4000),
              textColor: Colors.white,
            ),
            if (previousRoute == AppRouteNames.forgetPassword) ...[
              8.verticalSpace,
              CustomButton(
                icon: Icon(Icons.arrow_back, size: 20, color: AppColor.primary),
                text: "Back to Login",
                submit: () {
                  context.goNamed(AppRouteNames.login);
                },
                textColor: Color(0xffFF4000),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
