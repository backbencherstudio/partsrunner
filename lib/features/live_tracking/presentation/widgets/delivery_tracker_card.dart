import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partsrunner/core/models/delivery_model.dart';
import 'package:partsrunner/features/my_order/presentation/screens/order_details_screen.dart';

class DeliveryTrackerCard extends StatelessWidget {
  const DeliveryTrackerCard({super.key, required this.order});

  final DeliveryModel order;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // --- 1. Profile Section ---
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: Image.asset(
                  'assets/images/profile1.png',
                ).image,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.runner?.user?.name ?? '',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Runner',
                    style: TextStyle(fontSize: 14, color: Colors.blueGrey[400]),
                  ),
                ],
              ),
            ],
          ),
          8.verticalSpace,
          const Divider(color: Color(0xFFEEEEEE), thickness: 1),
          8.verticalSpace,

          // --- 2. Timeline Section ---

          // Step 1: On Delivery
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon and Line Column
              Column(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF5722), // Deep Orange
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                  // Dashed Line
                  SizedBox(
                    height: 60, // Height of the gap
                    child: CustomPaint(painter: DashedLinePainter()),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              // Content Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'On Delivery',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blueGrey[400],
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Runner is delivering the package.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${order.estimatedTimeMin} minutes estimation',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blueGrey[400],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Step 2: Delivered
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 24,
                child: Icon(
                  Icons.location_on_outlined,
                  color: Colors.blueGrey[400],
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'Delivered',
                style: TextStyle(fontSize: 14, color: Colors.blueGrey[400]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
