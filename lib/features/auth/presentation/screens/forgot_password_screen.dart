import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:partsrunner/core/constant/app_color.dart';
import 'package:partsrunner/core/routes/app_route_names.dart';
import 'package:partsrunner/core/widget/customButton.dart';
import 'package:partsrunner/features/auth/presentation/widgets/auth_header.dart';
import 'package:partsrunner/features/auth/presentation/widgets/mobile_phone_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(24.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthHeader(
                  title: "Forgot Password",
                  subtitle:
                      "Please enter your email address or phone number to reset password",
                  hasLogo: false,
                ),
                24.verticalSpace,
                Text(
                  "Mobile number",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                8.verticalSpace,
                MobilePhoneField(),
                24.verticalSpace,
                CustomButton(
                  backgroundColor: AppColor.primary,
                  textColor: Colors.white,
                  text: "Send OTP",
                  submit: () {
                    context.goNamed(
                      AppRouteNames.otp,
                      extra: AppRouteNames.forgetPassword,
                    );
                  },
                ),
                8.verticalSpace,
                CustomButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 20,
                    color: AppColor.primary,
                  ),
                  textColor: AppColor.primary,
                  text: "Back to Login",
                  submit: () {
                    context.goNamed(AppRouteNames.login);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
