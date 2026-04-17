import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:partsrunner/core/constant/app_color.dart';
import 'package:partsrunner/core/entities/delivery.dart';
import 'package:partsrunner/core/routes/app_route_names.dart';
import 'package:partsrunner/core/widget/customButton.dart';
import 'package:partsrunner/core/widget/custom_container.dart';
import 'package:partsrunner/features/bottom_nav/presentation/providers/bottom_nav_provider.dart';
import 'package:partsrunner/features/home/presentation/providers/home_provider.dart';
import 'package:partsrunner/features/home/presentation/widgets/floating_card.dart';
import 'package:partsrunner/features/home/presentation/widgets/section_header.dart';
import 'package:partsrunner/core/widget/tracking_item.dart';
import 'package:partsrunner/features/my_order/presentation/providers/order_provider.dart';

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
            SectionHeader(
              title: "Current Shipping",
              viewAll: () {
                ref.read(bottomNavProvider.notifier).state = 2;
                ref.read(orderTabProvider.notifier).state = true;
              },
            ),
            16.verticalSpace,
            ...data.currentShipping.map((e) => TrackingItem(item: e)),
            24.verticalSpace,
            SectionHeader(
              title: "Recent Shipping",
              viewAll: () {
                ref.read(bottomNavProvider.notifier).state = 2;
                ref.read(orderTabProvider.notifier).state = false;
              },
            ),
            16.verticalSpace,
            ...data.recentShipping.map((e) => RecentShipping(item: e)),
          ],
        ),
      ),
      error: (error, stackTrace) => Center(child: Text(error.toString())),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}

class RecentShipping extends StatelessWidget {
  const RecentShipping({super.key, required this.item});

  final Delivery item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CustomContainer(
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
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.packageName!,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Text(
                            "\$${item.totalAmount}",
                            style: TextStyle(
                              color: AppColor.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "ID: ${item.id}",
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey),
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
                      context.pushNamed(
                        AppRouteNames.orderDetails,
                        extra: item.id,
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
