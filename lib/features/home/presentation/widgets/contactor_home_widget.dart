import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:partsrunner/core/constant/app_color.dart';
import 'package:partsrunner/core/routes/app_route_names.dart';
import 'package:partsrunner/core/widget/customButton.dart';
import 'package:partsrunner/core/widget/custom_container.dart';
import 'package:partsrunner/features/home/presentation/providers/home_provider.dart';
import 'package:partsrunner/features/home/presentation/widgets/floating_card.dart';
import 'package:partsrunner/features/home/presentation/widgets/section_header.dart';
import 'package:partsrunner/core/widget/tracking_item.dart';

class ContactorHomeWidget extends ConsumerWidget {
  const ContactorHomeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shippingSummary = ref.watch(shippingSummaryProvider);
    return shippingSummary.when(
      data: (data) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            FloatingCard(isContactor: true),
            20.verticalSpace,
            SectionHeader(title: "Current Shipping", viewAll: () {}),
            16.verticalSpace,
            ...data.currentShipping.map((e) => TrackingItem(item: e)),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
      ),
      error: (error, stackTrace) => Center(child: Text(error.toString())),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}
