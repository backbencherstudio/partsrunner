import 'package:flutter/material.dart';

enum OrderStatus { accepted, pickedUp, enRoute, delivered }

class OrderTracker extends StatelessWidget {
  final OrderStatus status;

  const OrderTracker({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    // Determine progress width factor based on status
    double progressFactor;
    switch (status) {
      case OrderStatus.accepted:
        progressFactor = 0;
        break;
      case OrderStatus.pickedUp:
        progressFactor = 0.0;
        break;
      case OrderStatus.enRoute:
        progressFactor = 0.5;
        break;
      case OrderStatus.delivered:
        progressFactor = 1.0;
        break;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Background Track
            Container(
              height: 3,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              color: Colors.grey.shade200,
            ),
            // Active Progress Track
            Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: progressFactor,
                child: Container(
                  height: 3,
                  margin: const EdgeInsets.only(left: 10),
                  color: Colors.deepOrange,
                ),
              ),
            ),
            // The Milestones
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildPoint(
                  isActive: status.index >= 0,
                  isCurrent: status == OrderStatus.pickedUp,
                  isIcon: status == OrderStatus.pickedUp,
                ),
                _buildPoint(
                  isActive: status.index >= 1,
                  isCurrent: status == OrderStatus.enRoute,
                  isIcon: status == OrderStatus.enRoute,
                ),
                _buildPoint(
                  isActive: status.index >= 2,
                  isCurrent: status == OrderStatus.delivered,
                  isIcon: status == OrderStatus.delivered,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 15),
        // Labels
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            status == OrderStatus.accepted
                ? _buildLabel(
                    'Accepted',
                    status.index == 0,
                    status == OrderStatus.accepted,
                  )
                : _buildLabel(
                    'Picked Up',
                    status.index >= 0,
                    status == OrderStatus.pickedUp,
                  ),
            _buildLabel(
              'En Route',
              status.index >= 1,
              status == OrderStatus.enRoute,
            ),
            _buildLabel(
              'Delivered',
              status.index >= 2,
              status == OrderStatus.delivered,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPoint({
    required bool isActive,
    required bool isCurrent,
    bool isIcon = false,
  }) {
    if (isIcon) {
      return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isActive ? Colors.deepOrange : Colors.grey.shade300,
          shape: BoxShape.circle,
          boxShadow: [
            if (isCurrent)
              BoxShadow(
                color: Colors.deepOrange.withOpacity(0.3),
                spreadRadius: 6,
                blurRadius: 2,
              ),
          ],
        ),
        child: const Icon(
          Icons.inventory_2_outlined,
          color: Colors.white,
          size: 18,
        ),
      );
    }

    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        color: isActive ? Colors.deepOrange : Colors.grey.shade300,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
    );
  }

  Widget _buildLabel(String text, bool isPassed, bool isCurrent) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
        color: isCurrent
            ? Colors.deepOrange
            : (isPassed ? Colors.deepOrange.withOpacity(0.5) : Colors.grey),
      ),
    );
  }
}
