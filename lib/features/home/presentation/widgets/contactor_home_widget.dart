import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:partsrunner/core/constant/app_color.dart';
import 'package:partsrunner/core/routes/app_route_names.dart';
import 'package:partsrunner/core/widget/customButton.dart';
import 'package:partsrunner/core/widget/custom_container.dart';
import 'package:partsrunner/features/home/presentation/widgets/section_header.dart';
import 'package:partsrunner/features/activeTracking/presentaion/widgets/tracking_item.dart';

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
          TrackingItem(
            item: const {
              "name": "Apple Watch Series 8",
              "id": "VTY7162E",
              "runner": "Michael S.",
              "supplier": "Auto Supply Co.",
              "price": "\$125.00",
              "eta": "12 mins",
              "status": "In Progress",
              "statusColor": Colors.green,
              "progress": 0.66,
              "message": "",
            },
          ),
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
                          submit: () {
                            context.pushNamed(AppRouteNames.orderDetails);
                          },
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
