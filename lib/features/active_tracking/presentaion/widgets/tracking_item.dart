import 'package:flutter/material.dart';
import 'package:partsrunner/core/widget/customButton.dart';
import 'package:partsrunner/core/widget/order_tracker.dart';
import 'package:partsrunner/features/active_tracking/data/models/active_delivery_model.dart';

class TrackingItem extends StatelessWidget {
  final ActiveDeliveryModel item;

  const TrackingItem({super.key, required this.item});

  OrderStatus _getStatus(double progress) {
    if (progress >= 0.99) return OrderStatus.delivered;
    if (progress >= 0.66) return OrderStatus.enRoute;
    return OrderStatus.pickedUp;
  }

  @override
  Widget build(BuildContext context) {
    final name = item.packageName;
    final id = item.id;
    final runner = item.runner.id;
    final supplier = item.supplier.name;
    final price = item.totalAmount;
    final eta = "item";
    final status = item.status;
    final statusColor = Colors.greenAccent;
    final progress = '';
    final message = '';
    final showTimer = false;

    final hasMessage = message.trim().isNotEmpty;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.inventory_2_outlined,
                    color: Colors.deepOrange,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "ID: $id",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoText("Runner: ", runner),
                      const SizedBox(height: 8),
                      _buildInfoText("Supplier: ", supplier),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildInfoText("Price: ", price),
                      const SizedBox(height: 8),
                      _buildInfoText("ETA: ", eta),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Message or Progress
            if (hasMessage) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3F0),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.deepOrange.shade200,
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      message.split('\n').first.trim(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                    if (message.contains('\n')) ...[
                      const SizedBox(height: 8),
                      Text(
                        message.split('\n').last.trim(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                    if (showTimer) ...[
                      const SizedBox(height: 12),
                      const Text(
                        "10:17",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ] else ...[
              OrderTracker(status: _getStatus(20)),
            ],

            const SizedBox(height: 20),

            // Button
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: "View Live Map",
                backgroundColor: Colors.white,
                textColor: Colors.deepOrange,
                border: Border.all(color: Colors.deepOrange, width: 1.5),
                borderRadius: 24,
                textSize: 16,
                submit: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoText(String label, String value) {
    return Text.rich(
      TextSpan(
        text: label,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 13,
          color: Colors.black87,
        ),
        children: [
          TextSpan(
            text: value,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
