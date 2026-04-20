import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partsrunner/core/models/delivery_model.dart';
import 'package:partsrunner/features/live_tracking/presentation/widgets/delivery_tracker_card.dart';

class ContractorLiveCard extends StatelessWidget {
  const ContractorLiveCard({super.key, required this.order});

  final DeliveryModel? order;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.deepOrange.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.timer, color: Colors.red),
              SizedBox(width: 8),
              Flexible(
                child: Text(
                  "The package is estimated to arrive within the next ${order!.estimatedTimeMin} minutes.",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
          8.verticalSpace,
          DeliveryTrackerCard(order: order!),
        ],
      ),
    );
  }
}
