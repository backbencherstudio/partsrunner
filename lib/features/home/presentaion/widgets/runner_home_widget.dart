import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partsrunner/features/home/presentaion/widgets/no_active_jobs_widget.dart';
import 'package:partsrunner/features/home/presentaion/widgets/request_card.dart';
import 'package:partsrunner/features/home/presentaion/widgets/runner_report_item.dart';

class RunnerHomeWidget extends StatefulWidget {
  const RunnerHomeWidget({super.key});

  @override
  State<RunnerHomeWidget> createState() => _RunnerHomeWidgetState();
}

class _RunnerHomeWidgetState extends State<RunnerHomeWidget> {
  late bool hasRequest;
  @override
  void initState() {
    hasRequest = getRequest();
    super.initState();
  }

  bool getRequest() {
    return true;
  }

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
          hasRequest
              ? ListView.separated(
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => RequestCard(),
                  separatorBuilder: (_, _) => 12.verticalSpace,
                  itemCount: 5,
                )
              : NoActiveJobsWidget(),
        ],
      ),
    );
  }
}
