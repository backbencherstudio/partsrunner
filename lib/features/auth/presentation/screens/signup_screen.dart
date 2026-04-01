import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:partsrunner/core/routes/app_route_names.dart';
import 'package:partsrunner/core/widget/customButton.dart';
import 'package:partsrunner/core/widget/custom_text_fIeld.dart';
import 'package:partsrunner/features/auth/presentation/widgets/auth_header.dart';
import 'package:partsrunner/features/auth/presentation/widgets/mobile_phone_field.dart';
import 'package:partsrunner/features/auth/presentation/widgets/or_divider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final passwordController = TextEditingController();
    final emailController = TextEditingController();
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        AuthHeader(
                          title: "Create Your Account",
                          subtitle: "Sign up and enjoy your experience",
                        ),
                        24.verticalSpace,
                      ],
                    ),
                  ),
                  16.verticalSpace,
                  Text(
                    "Name",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  CustomTextField(
                    hintText: "Enter your name",
                    isPassword: false,
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "name can't be empty";
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 15),

                  Text(
                    "Email",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  CustomTextField(
                    hintText: "Email",
                    isPassword: false,
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email can't be empty";
                      }
                      if (!RegExp(
                        r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",
                      ).hasMatch(value)) {
                        return "Enter a valid email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Mobile number",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  MobilePhoneField(phoneController: phoneController),
                  SizedBox(height: 15),
                  Text(
                    "Password",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  CustomTextField(
                    hintText: "Password",
                    isPassword: true,
                    controller: passwordController,
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
                  SizedBox(height: 15),

                  Text(
                    "Confirm Password",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  CustomTextField(
                    hintText: "Confirm Password",
                    isPassword: true,
                    controller: passwordController,
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
                  SizedBox(height: 15),
                  CustomButton(
                    text: "Create Account",
                    submit: () {
                      context.goNamed(
                        AppRouteNames.otp,
                        extra: AppRouteNames.signup,
                      );
                    },
                    backgroundColor: Color(0xffFF4000),
                    textColor: Colors.white,
                  ),
                  32.verticalSpace,
                  OrDivider(),
                  24.verticalSpace,
                  CustomButton(
                    icon: Image.asset("assets/icons/google_icon.png"),
                    text: "Sign up with Google",
                    submit: () {
                      context.goNamed(AppRouteNames.completeInfo);
                    },
                    backgroundColor: Color(0x080e1e0d).withOpacity(0.05),
                    textColor: Colors.black,
                  ),
                  24.verticalSpace,
                  Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "If Already have Account ?  ",
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text: "Login",
                            style: TextStyle(
                              color: Color(0xffFF4000),
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.goNamed(AppRouteNames.login);
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                  38.verticalSpace,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
