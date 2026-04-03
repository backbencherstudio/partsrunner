import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:partsrunner/core/constant/app_color.dart';
import 'package:partsrunner/core/constant/auth_method.dart';
import 'package:partsrunner/core/routes/app_route_names.dart';
import 'package:partsrunner/core/widget/custom_text_fIeld.dart';
import 'package:partsrunner/core/widget/customButton.dart';
import 'package:partsrunner/features/auth/presentation/providers/auth_provider.dart';
import 'package:partsrunner/features/auth/presentation/widgets/auth_header.dart';
import 'package:partsrunner/features/auth/presentation/widgets/auth_method_widget.dart';
import 'package:partsrunner/features/auth/presentation/widgets/mobile_phone_field.dart';
import 'package:partsrunner/features/auth/presentation/widgets/or_divider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final authMethod = ref.read(authMethodProvider);
    final identifier = authMethod == AuthMethod.phone
        ? _phoneController.text.trim()
        : _emailController.text.trim();

    ref
        .read(authNotifierProvider.notifier)
        .login(identifier: identifier, password: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    // Listen for auth state changes and react accordingly
    ref.listen<AsyncValue<AuthState>>(authNotifierProvider, (prev, next) {
      next.whenData((state) {
        if (state is AuthSuccess) {
          ref.read(authNotifierProvider.notifier).resetState();
          final user = state.user;
          print(user);
          // context.goNamed(
          //   AppRouteNames.message,
          //   extra: {
          //     'title': 'Success',
          //     'message':
          //         'Nice to see you again. Get your parts delivered with tracking parts in real-time!',
          //     'imagePath': 'assets/icons/success.png',
          //     'buttonText': 'Get Started',
          //     'routeName': AppRouteNames.bottomNav,
          //   },
          // );
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

    final authAsync = ref.watch(authNotifierProvider);
    final isLoading = authAsync.isLoading;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AuthHeader(
                    title: "Welcome to Parts Runner",
                    subtitle: "Login to your account",
                  ),
                  20.verticalSpace,
                  const AuthMethodWidget(),
                  24.verticalSpace,

                  // Email / Phone field (switches on auth method)
                  Consumer(
                    builder: (context, ref, child) {
                      final state = ref.watch(authMethodProvider);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              state == AuthMethod.email ? "Email" : "Phone",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          8.verticalSpace,
                          state == AuthMethod.phone
                              ? MobilePhoneField(
                                  phoneController: _phoneController,
                                )
                              : CustomTextField(
                                  hintText: "Enter your email",
                                  isPassword: false,
                                  controller: _emailController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Email can't be empty";
                                    }
                                    return null;
                                  },
                                ),
                        ],
                      );
                    },
                  ),

                  16.verticalSpace,

                  // Password
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  8.verticalSpace,
                  CustomTextField(
                    hintText: "Enter your password",
                    isPassword: true,
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password can't be empty";
                      }
                      return null;
                    },
                  ),

                  8.verticalSpace,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Consumer(
                        builder: (context, ref, child) {
                          final rememberMe = ref.watch(rememberMeProvider);
                          return GestureDetector(
                            onTap: () {
                              ref.read(rememberMeProvider.notifier).state =
                                  !rememberMe;
                            },
                            child: Row(
                              children: [
                                Icon(
                                  color: AppColor.primary,
                                  rememberMe
                                      ? Icons.check_circle
                                      : Icons.circle_outlined,
                                ),
                                4.horizontalSpace,
                                const Text("Remember me"),
                              ],
                            ),
                          );
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          context.goNamed(AppRouteNames.forgetPassword);
                        },
                        child: const Text(
                          "Forgot password?",
                          style: TextStyle(color: AppColor.primary),
                        ),
                      ),
                    ],
                  ),

                  24.verticalSpace,

                  CustomButton(
                    text: isLoading ? "Please wait..." : "Continue",
                    submit: isLoading ? null : _submit,
                    backgroundColor: const Color(0xffFF4000),
                    textColor: Colors.white,
                  ),
                  32.verticalSpace,
                  const OrDivider(),
                  24.verticalSpace,
                  CustomButton(
                    icon: Image.asset("assets/icons/google_icon.png"),
                    text: "Sign in with Google",
                    submit: isLoading
                        ? null
                        : () {
                            context.goNamed(AppRouteNames.bottomNav);
                          },
                    backgroundColor: const Color(
                      0x080e1e0d,
                    ).withValues(alpha: 0.05),
                    textColor: Colors.black,
                  ),
                  24.verticalSpace,
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: "Sign Up",
                          style: const TextStyle(
                            color: Color(0xffFF4000),
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              ref.invalidate(selectedRoleProvider);
                              context.pushNamed(AppRouteNames.selectRole);
                            },
                        ),
                      ],
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
