import 'package:flutter/material.dart';
import 'package:partsrunner/core/constant/app_color.dart';
import 'package:partsrunner/core/models/delivery_model.dart';

class RunnerLiveCard extends StatelessWidget {
  const RunnerLiveCard({super.key, required this.order});

  final DeliveryModel order;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.white,
          border: Border.all(color: Colors.deepOrange.shade100, width: 12),
          borderRadius: BorderRadius.circular(20),
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section: Icon and Title
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Color(0xFFFFF0EB),
                  child: Icon(
                    Icons.inventory_2_outlined,
                    color: Colors.deepOrangeAccent,
                    size: 30,
                  ),
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.packageName!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'ID: ${order.id}',
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 15),
            Divider(thickness: 1, color: Colors.grey[200]),
            SizedBox(height: 15),

            // Time and Distance Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'Total Time: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: '${order.estimatedTimeMin} minutes',
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'Distance: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: '${order.currentDistanceKm} Miles',
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Sender Details
            _buildInfoRow('Sender:', order.supplier!.name!),
            _buildInfoRow(
              'From:',
              '${order.supplier!.location}, ${order.supplier!.street}, ${order.supplier!.city}, ${order.supplier!.zipCode}',
              isAddress: true,
            ),

            SizedBox(height: 15),

            // Receiver Details
            _buildInfoRow('Receiver:', order.technicianName!),
            _buildInfoRow('To:', order.deliveryAddress!, isAddress: true),
          ],
        ),
      ),
    );
  }

  // Helper method for details rows
  Widget _buildInfoRow(String label, String value, {bool isAddress = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label ', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: isAddress ? Colors.blueGrey : Colors.blueGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
