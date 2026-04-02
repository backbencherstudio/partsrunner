import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partsrunner/core/constant/app_color.dart';

import 'package:partsrunner/core/widget/customButton.dart';
import 'package:partsrunner/core/widget/custom_container.dart';
import 'package:partsrunner/core/widget/order_tracker.dart';
import 'package:partsrunner/features/home/presentaion/widgets/section_header.dart';

class ContactorHomeWidget extends StatelessWidget {
  const ContactorHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          SectionHeader(title: "Current Shipping", viewAll: () {}),
          16.verticalSpace,
          CurrentShippingCard(),
          24.verticalSpace,
          SectionHeader(title: "Recent Shipping", viewAll: () {}),
          16.verticalSpace,
          ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => CustomContainer(
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 48.h,
                        width: 48.w,
                        decoration: BoxDecoration(
                          color: AppColor.primary.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.dashboard_outlined,
                          color: AppColor.primary,
                        ),
                      ),
                      20.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Apple Watch Series 8",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("ID: VTY7162E"),
                                Text(
                                  "\$125.00",
                                  style: TextStyle(
                                    color: AppColor.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  12.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          textSize: 14.sp,
                          border: Border.all(color: Colors.grey),
                          textColor: Colors.grey,
                          borderRadius: 100,
                          text: "Reorder",
                          submit: () {},
                        ),
                      ),
                      12.horizontalSpace,
                      Expanded(
                        child: CustomButton(
                          textSize: 14.sp,
                          border: Border.all(color: AppColor.primary),
                          textColor: AppColor.primary,
                          borderRadius: 100,
                          text: "View Details",
                          submit: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            separatorBuilder: (_, _) => 16.verticalSpace,
            itemCount: 5,
          ),
        ],
      ),
    );
  }
}

class CurrentShippingCard extends StatelessWidget {
  const CurrentShippingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Active Delivery: ID: VTY7162E",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "In Progress",
                  style: TextStyle(color: Colors.green, fontSize: 12),
                ),
              ),
            ],
          ),
          12.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "Runner: ",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                      ),
                      children: [
                        TextSpan(
                          text: 'Michael S.',
                          style: TextStyle(fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  8.verticalSpace,
                  Text.rich(
                    TextSpan(
                      text: "Supplier: ",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                      ),
                      children: [
                        TextSpan(
                          text: 'Auto Supply Co.',
                          style: TextStyle(fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "Price: ",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                      ),
                      children: [
                        TextSpan(
                          text: '\$125.00',
                          style: TextStyle(fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  8.verticalSpace,
                  Text.rich(
                    TextSpan(
                      text: "ETA: ",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                      ),
                      children: [
                        TextSpan(
                          text: '12 mins',
                          style: TextStyle(fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          16.verticalSpace,
          OrderTracker(status: OrderStatus.delivered),
          // LinearProgressIndicator(value: 0.6, minHeight: 8),
          16.verticalSpace,
          CustomButton(
            borderRadius: 100,
            border: Border.all(color: AppColor.primary, width: 1),
            textColor: AppColor.primary,
            text: 'View Live Map',
            submit: () {},
          ),
        ],
      ),
    );
  }
}
