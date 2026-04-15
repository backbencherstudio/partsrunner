import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:partsrunner/core/constant/app_color.dart';
import 'package:partsrunner/core/routes/app_route_names.dart';
import 'package:partsrunner/core/widget/customButton.dart';
import 'package:partsrunner/core/widget/custom_container.dart';
import 'package:partsrunner/core/models/delivery_model.dart';

class RequestCard extends StatelessWidget {
  const RequestCard({super.key, required this.request});

  final DeliveryModel request;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                child: Text(
                  "New Delivery Request",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          12.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request.packageName ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                      ),
                    ),
                    4.verticalSpace,
                    Text("ID: ${request.id}", overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              Expanded(
                child: Column(
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
                            text: " ${request.currentDistanceKm ?? 0} Miles",
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
                  text: " ${request.supplier?.street}",
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
                  text: " ${request.deliveryAddress}",
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
              context.pushNamed(AppRouteNames.jobDetails, extra: request.id);
            },
          ),
        ],
      ),
    );
  }
}
