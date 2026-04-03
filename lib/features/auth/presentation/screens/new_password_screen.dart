import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:partsrunner/core/routes/app_route_names.dart';
import 'package:partsrunner/core/widget/customButton.dart';
import 'package:partsrunner/core/widget/custom_text_fIeld.dart';
import 'package:partsrunner/features/auth/presentation/widgets/auth_header.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthHeader(
                  title: "New Password",
                  subtitle: "Please enter your new password",
                  hasLogo: false,
                ),
                24.verticalSpace,
                Text(
                  "Password",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                8.verticalSpace,
                CustomTextField(
                  hintText: "Password",
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password can't be empty";
                    }
                    if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                ),
                24.verticalSpace,
                Text(
                  "Confirm Password",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                8.verticalSpace,
                CustomTextField(
                  hintText: "Confirm Password",
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password can't be empty";
                    }
                    if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                ),
                24.verticalSpace,
                CustomButton(
                  text: "Create New Password",
                  submit: () {
                    context.goNamed(
                      AppRouteNames.message,
                      extra: {
                        'title': 'Password Reset',
                        'imagePath': 'assets/icons/success.png',
                        'message': 'Your password has been reset successfully',
                        'buttonText': 'Back to Login',
                        'routeName': AppRouteNames.login,
                      },
                    );
                  },
                  backgroundColor: Color(0xffFF4000),
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
