import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:partsrunner/core/constant/app_color.dart';
import 'package:partsrunner/core/constant/user_role.dart';
import 'package:partsrunner/core/routes/app_route_names.dart';
import 'package:partsrunner/core/widget/customButton.dart';
import 'package:partsrunner/core/widget/custom_dropdown.dart';
import 'package:partsrunner/core/widget/custom_text_fIeld.dart';
import 'package:partsrunner/features/auth/presentation/providers/auth_provider.dart';
import 'package:partsrunner/features/auth/presentation/widgets/auth_header.dart';

class CompleteInfoScreen extends ConsumerWidget {
  const CompleteInfoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedRole = ref.read(selectedRoleProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthHeader(
                  title: "Create Your Account",
                  subtitle: "Sign up and enjoy your experience",
                  hasLogo: false,
                ),
                24.verticalSpace,
                if (selectedRole == UserRole.contractor) ...[
                  Text(
                    "Company Name",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  8.verticalSpace,
                  CustomTextField(hintText: "Enter Your Company Name"),
                  20.verticalSpace,
                  Text(
                    "Business Address",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  8.verticalSpace,
                  CustomTextField(hintText: "Enter Business Address"),
                ] else ...[
                  Text(
                    "Runner Name",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  8.verticalSpace,
                  CustomTextField(hintText: "Enter Your Runner Name"),
                  20.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Vehicle Type",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            8.verticalSpace,
                            CustomDropdown(
                              hintText: "Select",
                              items: [
                                DropdownMenuItem(
                                  value: "truck",
                                  child: Text("Truck"),
                                ),
                                DropdownMenuItem(
                                  value: "car",
                                  child: Text("Car"),
                                ),
                                DropdownMenuItem(
                                  value: "bike",
                                  child: Text("Bike"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      10.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Vehical Model",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            8.verticalSpace,
                            CustomDropdown(
                              hintText: "Select",
                              items: [
                                DropdownMenuItem(
                                  value: "model1",
                                  child: Text("Model 1"),
                                ),
                                DropdownMenuItem(
                                  value: "model2",
                                  child: Text("Model 2"),
                                ),
                                DropdownMenuItem(
                                  value: "model3",
                                  child: Text("Model 3"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  20.verticalSpace,
                  Text(
                    "Vehicle Identification Number: ",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  8.verticalSpace,
                  CustomTextField(
                    hintText: "Enter Vehicle Identification Number",
                  ),
                ],
                24.verticalSpace,
                CustomButton(
                  backgroundColor: AppColor.primary,
                  textColor: Colors.white,
                  text: "Create Account",
                  submit: () {
                    context.goNamed(
                      AppRouteNames.message,
                      extra: {
                        'title': 'Congratulation!',
                        'imagePath': 'assets/icons/success.png',
                        'message':
                            "Your account is created complete. Let's get started!",
                        'buttonText': 'Get Started',
                        'routeName': AppRouteNames.bottomNav,
                      },
                    );
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
