import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:partsrunner/core/helpers/helper_functions.dart';
import 'package:partsrunner/core/routes/app_route_names.dart';
import 'package:partsrunner/core/widget/customButton.dart';
import 'package:partsrunner/core/widget/custom_text_fIeld.dart';
import 'package:partsrunner/features/auth/presentation/providers/auth_provider.dart';
import 'package:partsrunner/features/auth/presentation/widgets/auth_header.dart';
import 'package:partsrunner/features/auth/presentation/widgets/mobile_phone_field.dart';
import 'package:partsrunner/features/auth/presentation/widgets/or_divider.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _countryController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _countryController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final userRole = ref.read(selectedRoleProvider);
    print(userRole);
    super.initState();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final userRole = ref.read(selectedRoleProvider);
    if (userRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a role first'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    ref
        .read(authNotifierProvider.notifier)
        .signup(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          countryCode: _countryController.text.trim(),
          phone: _phoneController.text.trim(),
          password: _passwordController.text,
          role: userRole.name,
        );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<AuthState>>(authNotifierProvider, (prev, next) {
      next.whenData((state) {
        if (state is AuthSuccess) {
          ref.read(authNotifierProvider.notifier).resetState();
          context.goNamed(
            AppRouteNames.otp,
            extra: {
              "previousRoute": AppRouteNames.signup,
              "email": _emailController.text.trim(),
            },
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

    final authAsync = ref.watch(authNotifierProvider);
    final isLoading = authAsync.isLoading;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  16.verticalSpace,
                  Center(
                    child: AuthHeader(
                      title: "Create Your Account",
                      subtitle: "Sign up and enjoy your experience",
                    ),
                  ),
                  24.verticalSpace,
                  Text(
                    "Name",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  8.verticalSpace,
                  CustomTextField(
                    hintText: "Enter your name",
                    isPassword: false,
                    controller: _nameController,
                    validator: (value) => HelperFunctions.validateName(value),
                  ),
                  24.verticalSpace,
                  Text(
                    "Email",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  8.verticalSpace,
                  CustomTextField(
                    hintText: "Email",
                    isPassword: false,
                    controller: _emailController,
                    validator: (value) => HelperFunctions.validateEmail(value),
                  ),
                  24.verticalSpace,
                  const Text(
                    "Mobile number",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  8.verticalSpace,
                  MobilePhoneField(
                    phoneController: _phoneController,
                    countryController: _countryController,
                  ),
                  24.verticalSpace,
                  const Text(
                    "Password",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  8.verticalSpace,
                  CustomTextField(
                    hintText: "Password",
                    isPassword: true,
                    controller: _passwordController,
                    validator: (value) =>
                        HelperFunctions.validatePassword(value),
                  ),
                  24.verticalSpace,
                  const Text(
                    "Confirm Password",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  8.verticalSpace,
                  CustomTextField(
                    hintText: "Confirm Password",
                    isPassword: true,
                    controller: _confirmPasswordController,
                    validator: (value) =>
                        HelperFunctions.validateConfirmPassword(
                          value,
                          _passwordController.text,
                        ),
                  ),
                  24.verticalSpace,
                  CustomButton(
                    text: isLoading ? "Creating account..." : "Create Account",
                    submit: isLoading ? null : _submit,
                    backgroundColor: const Color(0xffFF4000),
                    textColor: Colors.white,
                  ),
                  24.verticalSpace,
                  const OrDivider(),
                  24.verticalSpace,
                  CustomButton(
                    icon: Image.asset("assets/icons/google_icon.png"),
                    text: "Sign up with Google",
                    submit: isLoading
                        ? null
                        : () {
                            context.goNamed(AppRouteNames.completeInfo);
                          },
                    backgroundColor: const Color(
                      0x080e1e0d,
                    ).withValues(alpha: 0.05),
                    textColor: Colors.black,
                  ),
                  24.verticalSpace,
                  Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: "Already have an account?  ",
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text: "Login",
                            style: const TextStyle(
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
