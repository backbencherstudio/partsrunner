import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:partsrunner/core/constant/app_color.dart';
import 'package:partsrunner/core/routes/app_route_names.dart';
import 'package:partsrunner/core/widget/customButton.dart';
import 'package:partsrunner/features/auth/presentation/providers/auth_provider.dart';
import 'package:partsrunner/features/auth/presentation/widgets/auth_header.dart';
import 'package:partsrunner/features/auth/presentation/widgets/mobile_phone_field.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _sendOtp() {
    final identifier = _phoneController.text.trim();
    if (identifier.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your phone number'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    ref
        .read(authNotifierProvider.notifier)
        .sendOtp(identifier: identifier);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<AuthState>>(authNotifierProvider, (prev, next) {
      next.whenData((state) {
        if (state is AuthSuccess) {
          ref.read(authNotifierProvider.notifier).resetState();
          context.goNamed(
            AppRouteNames.otp,
            extra: AppRouteNames.forgetPassword,
          );
        } else if (state is AuthError) {
          ref.read(authNotifierProvider.notifier).resetState();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red.shade700,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      });
    });

    final isLoading = ref.watch(authNotifierProvider).isLoading;

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
                      "Please enter your phone number to receive an OTP",
                  hasLogo: false,
                ),
                24.verticalSpace,
                const Text(
                  "Mobile number",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                8.verticalSpace,
                MobilePhoneField(phoneController: _phoneController),
                24.verticalSpace,
                CustomButton(
                  backgroundColor: AppColor.primary,
                  textColor: Colors.white,
                  text: isLoading ? "Sending OTP..." : "Send OTP",
                  submit: isLoading ? null : _sendOtp,
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
                  submit: isLoading
                      ? null
                      : () {
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
