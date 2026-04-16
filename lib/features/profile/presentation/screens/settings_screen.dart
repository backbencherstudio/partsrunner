import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:partsrunner/core/constant/app_color.dart';
import 'package:partsrunner/core/widget/customButton.dart';
import 'package:partsrunner/core/widget/custom_text_fIeld.dart';
import 'package:partsrunner/features/profile/presentation/providers/profile_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _pushNotificationEnabled = true;
  var _isChangingPassword = false;

  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

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
          "Settings",
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
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            // Push Notification String
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Push Notification",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                CupertinoSwitch(
                  value: _pushNotificationEnabled,
                  activeTrackColor: AppColor.primary,
                  onChanged: (value) {
                    setState(() {
                      _pushNotificationEnabled = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 30.h),
            // Change password section
            Text(
              "Change password",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 16.h),
            // Current Password
            _buildLabeledTextField(
              label: "Current Password",
              hintText: "Enter current password",
              controller: _currentPasswordController,
            ),
            SizedBox(height: 6.h),
            // New Password
            _buildLabeledTextField(
              label: "New Password",
              hintText: "Enter new password",
              controller: _newPasswordController,
            ),
            SizedBox(height: 6.h),
            // Confirm password
            _buildLabeledTextField(
              label: "Confirm password",
              hintText: "Enter confirm password",
              controller: _confirmPasswordController,
            ),
            30.verticalSpace,
            CustomButton(
              submit: () async {
                // Validate passwords match
                if (_newPasswordController.text !=
                    _confirmPasswordController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Passwords do not match')),
                  );
                  return;
                }

                // Validate fields are not empty
                if (_currentPasswordController.text.isEmpty ||
                    _newPasswordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill in all fields')),
                  );
                  return;
                }

                setState(() {
                  _isChangingPassword = true;
                });

                try {
                  final response = await ref.read(
                    changePasswordProvider((
                      oldPassword: _currentPasswordController.text,
                      newPassword: _newPasswordController.text,
                    )).future,
                  );

                  if (response['success'] == true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          response['message'] ??
                              'Password changed successfully',
                        ),
                      ),
                    );
                    // Clear the password fields
                    _currentPasswordController.clear();
                    _newPasswordController.clear();
                    _confirmPasswordController.clear();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          response['message'] ?? 'Failed to change password',
                        ),
                      ),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: ${e.toString()}')),
                  );
                } finally {
                  setState(() {
                    _isChangingPassword = false;
                  });
                }
              },
              text: _isChangingPassword ? 'Changing...' : 'Confirm',
              textColor: AppColor.white,
              backgroundColor: AppColor.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabeledTextField({
    required String label,
    required String hintText,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        CustomTextField(
          hintText: hintText,
          controller: controller,
          isPassword: true,
        ),
      ],
    );
  }
}
