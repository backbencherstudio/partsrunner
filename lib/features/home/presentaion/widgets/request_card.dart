import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:partsrunner/core/constant/app_color.dart';
import 'package:partsrunner/core/routes/app_route_names.dart';
import 'package:partsrunner/core/widget/customButton.dart';
import 'package:partsrunner/core/widget/custom_container.dart';

class RequestCard extends StatelessWidget {
  const RequestCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: AppColor.primary.withValues(alpha: 0.2),
                ),
                child: Icon(
                  Icons.delivery_dining_rounded,
                  color: AppColor.primary,
                ),
              ),
              16.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "New Delivery Request",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    4.verticalSpace,
                    Text(
                      "You’re 1.2 miles from the pickup location.",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ],
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
                  Text(
                    "Apple Watch Series 8",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                    ),
                  ),
                  4.verticalSpace,
                  Text("ID: VTY7162EY8"),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "Distance:",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                      ),
                      children: [
                        TextSpan(
                          text: " 125 Miles",
                          style: TextStyle(fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  4.verticalSpace,
                  Text.rich(
                    TextSpan(
                      text: "Price:",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                      ),
                      children: [
                        TextSpan(
                          text: " \$125.00",
                          style: TextStyle(fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          12.verticalSpace,
          Text.rich(
            TextSpan(
              text: "Pickup Location:",
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
              children: [
                TextSpan(
                  text: " AutoZone – 3.2 miles",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          8.verticalSpace,
          Text.rich(
            TextSpan(
              text: "Drop-Off Location:",
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
              children: [
                TextSpan(
                  text: " Acme HVAC – 7.5 miles",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          12.verticalSpace,
          CustomButton(
            borderRadius: 30.r,
            border: Border.all(color: AppColor.primary, width: 2),
            text: "View Details",
            textColor: AppColor.primary,
            submit: () {
              context.pushNamed(AppRouteNames.jobDetails);
            },
          ),
        ],
      ),
    );
  }
}
