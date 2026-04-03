import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:partsrunner/core/constant/app_color.dart';
import 'package:partsrunner/core/constant/auth_method.dart';
import 'package:partsrunner/features/auth/presentation/providers/auth_provider.dart';

class AuthMethodWidget extends ConsumerWidget {
  const AuthMethodWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authMethodProvider);
    return Container(
      height: 60.h,
      width: 211.w,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                ref.read(authMethodProvider.notifier).state = AuthMethod.email;
              },
              child: Container(
                margin: const EdgeInsets.all(4),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: state == AuthMethod.email
                      ? AppColor.primary
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      state == AuthMethod.email
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      size: 16,
                      color: state == AuthMethod.email
                          ? Colors.white
                          : Colors.grey,
                    ),
                    8.horizontalSpace,
                    Text(
                      "Email",
                      style: GoogleFonts.inter(
                        color: state == AuthMethod.email
                            ? Colors.white
                            : Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Expanded(
            child: GestureDetector(
              onTap: () {
                ref.read(authMethodProvider.notifier).state = AuthMethod.phone;
              },
              child: Container(
                margin: const EdgeInsets.all(4),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: state == AuthMethod.phone
                      ? AppColor.primary
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      state == AuthMethod.phone
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      size: 16,
                      color: state == AuthMethod.phone
                          ? Colors.white
                          : Colors.grey,
                    ),
                    8.horizontalSpace,
                    Text(
                      "Phone",
                      style: GoogleFonts.inter(
                        color: state == AuthMethod.phone
                            ? Colors.white
                            : Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
