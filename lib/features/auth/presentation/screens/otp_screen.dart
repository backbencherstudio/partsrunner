import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:partsrunner/core/constant/app_color.dart';
import 'package:partsrunner/core/routes/app_route_names.dart';
import 'package:partsrunner/core/widget/customButton.dart';
import 'package:partsrunner/features/auth/presentation/providers/auth_provider.dart';
import 'package:partsrunner/features/auth/presentation/widgets/auth_header.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends ConsumerStatefulWidget {
  const OtpScreen({
    super.key,
    required this.previousRoute,
    this.email,
    this.phone,
    this.countryCode,
  });

  final String previousRoute;
  final String? email;
  final String? phone;
  final String? countryCode;

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final PinInputController _pinController = PinInputController();

  void _resendOtp() {
    final canResend = ref.read(canResendProvider);
    if (!canResend) return;

    ref.read(isResendingProvider.notifier).state = true;
    ref.read(canResendProvider.notifier).state = false;
    ref.read(resendTimerProvider.notifier).state = 30;

    ref
        .read(authNotifierProvider.notifier)
        .sendOtp(identifier: widget.email ?? '');

    _startResendTimer();
  }

  void _startResendTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;

      if (ref.watch(resendTimerProvider) > 0) {
        ref.read(resendTimerProvider.notifier).state--;
        _startResendTimer();
      } else {
        ref.read(canResendProvider.notifier).state = true;
        ref.read(isResendingProvider.notifier).state = false;
      }
    });
  }

  void _submit() {
    ref
        .read(authNotifierProvider.notifier)
        .verifyOtp(identifier: widget.email ?? '', otp: _pinController.text);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<AuthState>>(authNotifierProvider, (prev, next) {
      next.whenData((state) {
        if (state is AuthSuccess) {
          ref.read(authNotifierProvider.notifier).resetState();
          if (ref.read(isResendingProvider)) {
            ref.read(isResendingProvider.notifier).state = false;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('OTP resent successfully'),
                backgroundColor: Colors.green.shade700,
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else {
            if (widget.previousRoute == AppRouteNames.forgetPassword) {
              context.goNamed(
                AppRouteNames.newPassword,
                extra: {
                  'email': widget.email,
                  'phone': widget.phone,
                  'countryCode': widget.countryCode,
                  'otp': _pinController.text.trim(),
                },
              );
            } else {
              context.goNamed(AppRouteNames.completeInfo);
            }
          }
        } else if (state is AuthError) {
          ref.read(authNotifierProvider.notifier).resetState();
          if (ref.read(isResendingProvider)) {
            ref.read(isResendingProvider.notifier).state = false;
            ref.read(canResendProvider.notifier).state = true;
            ref.read(resendTimerProvider.notifier).state = 0;
          }
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

    final authAsync = ref.watch(authNotifierProvider);
    final isResending = ref.watch(isResendingProvider);
    final isContinueLoading = authAsync.isLoading && !isResending;
    final canResend = ref.watch(canResendProvider);
    final resendTimer = ref.watch(resendTimerProvider);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AuthHeader(
                hasLogo: false,
                title: "Enter OTP",
                subtitle:
                    "To verify your email address,\nplease enter the OTP sent to your email\n${widget.email}",
              ),
              24.verticalSpace,
              PinInput(
                pinController: _pinController,
                length: 6,
                builder: (context, cells) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: cells.map((cell) {
                      return Container(
                        width: 45.w,
                        height: 45.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
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

              GestureDetector(
                onTap: canResend ? _resendOtp : null,
                child: Text(
                  canResend ? "Resend Code" : "Resend Code (${resendTimer}s)",
                  style: TextStyle(
                    color: canResend ? Color(0xffFF4000) : Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              SizedBox(height: 20),

              CustomButton(
                text: isContinueLoading ? "Loading..." : "Continue",
                submit: isContinueLoading ? null : _submit,
                backgroundColor: Color(0xffFF4000),
                textColor: Colors.white,
              ),
              if (widget.previousRoute == AppRouteNames.forgetPassword) ...[
                8.verticalSpace,
                CustomButton(
                  icon: Icon(
                    Icons.arrow_back,
                    size: 20,
                    color: AppColor.primary,
                  ),
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
      ),
    );
  }
}
