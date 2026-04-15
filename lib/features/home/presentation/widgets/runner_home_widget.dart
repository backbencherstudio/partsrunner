import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partsrunner/core/models/delivery_model.dart';
import 'package:partsrunner/features/home/presentation/providers/home_provider.dart';
import 'package:partsrunner/features/home/presentation/widgets/floating_card.dart';
import 'package:partsrunner/features/home/presentation/widgets/no_active_jobs_widget.dart';
import 'package:partsrunner/features/home/presentation/widgets/request_card.dart';
import 'package:partsrunner/features/home/presentation/widgets/runner_report_item.dart';

class RunnerHomeWidget extends ConsumerStatefulWidget {
  const RunnerHomeWidget({super.key});

  @override
  ConsumerState<RunnerHomeWidget> createState() => _RunnerHomeWidgetState();
}

class _RunnerHomeWidgetState extends ConsumerState<RunnerHomeWidget> {
  @override
  void initState() {
    ref.read(onlineStatusProvider.notifier).state = false;
    super.initState();
  }

  bool getRequest() {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final deliveryRunner = ref.watch(deliveryRunnerProvider);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          FloatingCard(),
          20.verticalSpace,
          Row(
            children: [
              RunnerReportItem(
                icon: Icons.payment,
                title: "Todays Earnings",
                value: deliveryRunner.when(
                  data: (data) => "\$${data.todayEarning}",
                  error: (error, stackTrace) => "\$0",
                  loading: () => "\$0",
                ),
              ),
              12.horizontalSpace,
              RunnerReportItem(
                icon: Icons.delivery_dining_rounded,
                title: "Todays Deliveries",
                value: deliveryRunner.when(
                  data: (data) => "${data.todayDeliveries}",
                  error: (error, stackTrace) => "0",
                  loading: () => "0",
                ),
              ),
            ],
          ),
          24.verticalSpace,
          ref
              .watch(periodicNewRequestProvider)
              .when(
                data: (data) => data.isNotEmpty
                    ? ListView.separated(
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                            RequestCard(request: data[index]),
                        separatorBuilder: (_, _) => 12.verticalSpace,
                        itemCount: data.length,
                      )
                    : NoActiveJobsWidget(),
                loading: () => NoActiveJobsWidget(),
                error: (error, stackTrace) => NoActiveJobsWidget(),
              ),
          60.verticalSpace,
        ],
      ),
    );
  }
}
