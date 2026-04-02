import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partsrunner/core/constant/app_color.dart';
import 'package:partsrunner/core/widget/customButton.dart';

class FloatingCard extends StatelessWidget {
  const FloatingCard({super.key, this.isContactor = false});

  final bool isContactor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            spreadRadius: 2,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: isContactor
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xffFFECE6),
                      ),
                      child: const Icon(
                        Icons.delivery_dining_rounded,
                        color: Color(0xffFF4000),
                        size: 32,
                      ),
                    ),
                    16.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Request New Delivery",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          4.verticalSpace,
                          Text(
                            "Schedule a parts pickup in seconds",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                16.verticalSpace,
                CustomButton(
                  borderRadius: 24.r,
                  text: "Start Plan",
                  submit: () {},
                  backgroundColor: AppColor.primary,
                  textColor: Colors.white,
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xffFFECE6),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColor.primary),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.circle,
                          color: AppColor.primary,
                          size: 16,
                        ),
                      ),
                    ),
                    16.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "You're Online",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          4.verticalSpace,
                          Text(
                            "We'll send delivery requests your way.",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: CustomButton(
                        borderRadius: 24.r,
                        text: "Start Plan",
                        submit: () {},
                        backgroundColor: AppColor.primary,
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
