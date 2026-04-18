import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:partsrunner/core/constant/app_color.dart';
import 'package:partsrunner/core/constant/user_role.dart';
import 'package:partsrunner/core/routes/app_route_names.dart';
import 'package:partsrunner/core/widget/customButton.dart';
import 'package:partsrunner/core/widget/custom_dropdown.dart';
import 'package:partsrunner/core/widget/custom_text_fIeld.dart';
import 'package:partsrunner/features/auth/domain/entities/user_entity.dart';
import 'package:partsrunner/features/auth/presentation/widgets/mobile_phone_field.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key, required this.user});

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          "Edit Profile",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipOval(
                  child: Image.asset(
                    "assets/images/profile1.png",
                    width: 100.w,
                    height: 100.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                "Name",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              CustomTextField(
                hintText: "Enter your name",
                isPassword: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "name can't be empty";
                  }
                  return null;
                },
              ),
              16.verticalSpace,
              Text(
                "Email",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              CustomTextField(
                hintText: "Email",
                isPassword: false,
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
              MobilePhoneField(),
              20.verticalSpace,
              user.type.toLowerCase() == UserRole.runner.name
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        8.verticalSpace,
                        CustomTextField(
                          hintText: "Enter Vehicle Identification Number",
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Company Name",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        8.verticalSpace,
                        CustomTextField(hintText: "Enter Your Company Name"),
                        20.verticalSpace,
                        Text(
                          "Business Address",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        8.verticalSpace,
                        CustomTextField(hintText: "Enter Business Address"),
                      ],
                    ),
              24.verticalSpace,
              CustomButton(
                backgroundColor: AppColor.primary,
                textColor: Colors.white,
                text: "Update Profile",
                submit: () {
                  context.goNamed(
                    AppRouteNames.message,
                    extra: {
                      'title': 'Congratulation!',
                      'imagePath': 'assets/icons/success.png',
                      'message': "Your profile is updated.",
                      'buttonText': 'Back',
                      'routeName': AppRouteNames.bottomNav,
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
