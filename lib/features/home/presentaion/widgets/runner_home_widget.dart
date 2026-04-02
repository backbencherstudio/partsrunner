import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partsrunner/core/widget/customButton.dart';
import 'package:partsrunner/features/home/presentaion/widgets/no_active_jobs_widget.dart';
import 'package:partsrunner/features/home/presentaion/widgets/runner_report_item.dart';

class RunnerHomeWidget extends StatelessWidget {
  const RunnerHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Row(
            children: [
              RunnerReportItem(
                icon: Icons.payment,
                title: "Todays Earnings",
                value: "\$0.00",
              ),
              12.horizontalSpace,
              RunnerReportItem(
                icon: Icons.delivery_dining_rounded,
                title: "Todays Deliveries",
                value: "0",
              ),
            ],
          ),
          24.verticalSpace,
          // NoActiveJobsWidget(),
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => CustomContainer(
              child: Column(
                children: [
                  Row(children: []),
                  Row(children: []),
                  Row(children: []),
                  Row(children: []),
                  Row(children: []),
                  CustomButton(text: "View Details", submit: () {}),
                ],
              ),
            ),
            separatorBuilder: (_, _) => 12.verticalSpace,
            itemCount: 5,
          ),
        ],
      ),
    );
  }
}
