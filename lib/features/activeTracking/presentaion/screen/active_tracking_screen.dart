import 'package:flutter/material.dart';

class ActiveTrackingScreen extends StatelessWidget {
  const ActiveTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final trackingItems = [
      {
        "name": "Apple Watch Series 8",
        "id": "VTY7162E",
        "runner": "Michael S.",
        "supplier": "Auto Supply Co.",
        "price": "\$125.00",
        "eta": "-",
        "status": "At Location",
        "statusColor": Colors.blue,
        "progress": 0.0,
        "message":
            "The counter is preparing your order. You can call supply house for any delays...\nRunner is Waiting for Parts...",
        "showTimer": true,
      },
      {
        "name": "Apple Watch Series 8",
        "id": "VTY7162E",
        "runner": "Michael S.",
        "supplier": "Auto Supply Co.",
        "price": "\$125.00",
        "eta": "12 mins",
        "status": "Available",
        "statusColor": Colors.purple,
        "progress": 0.33, // PickedUp
        "message": "",
      },
      {
        "name": "Apple Watch Series 8",
        "id": "VTY7162E",
        "runner": "Michael S.",
        "supplier": "Auto Supply Co.",
        "price": "\$125.00",
        "eta": "12 mins",
        "status": "In Progress",
        "statusColor": Colors.green,
        "progress": 0.66,
        "message": "",
      },
    ];

    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text("Active Tracking"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.fromLTRB(16, 12, 16, 24),
        itemCount: trackingItems.length,
        itemBuilder: (context, index) {
          final item = trackingItems[index];

          final name = item['name'] as String;
          final id = item['id'] as String;
          final runner = item['runner'] as String;
          final supplier = item['supplier'] as String;
          final price = item['price'] as String;
          final eta = item['eta'] as String;
          final status = item['status'] as String;
          final statusColor = item['statusColor'] as Color;
          final progress = (item['progress'] as num).toDouble();
          final message = item['message'] as String? ?? '';
          final showTimer = item['showTimer'] as bool? ?? false;

          final hasMessage = message.trim().isNotEmpty;

          return Container(
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.watch_outlined,
                          color: Colors.orange,
                          size: 28,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4),
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
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.12),
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

                  const Divider(
                    height: 24,
                    thickness: 1,
                    color: Color(0xFFF0F0F0),
                  ),

                  // Details
                  _InfoRow(label: "Runner", value: runner),
                  _InfoRow(label: "Supplier", value: supplier),
                  _InfoRow(label: "Price", value: price),
                  _InfoRow(label: "ETA", value: eta),

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
                          color: Colors.orange.shade200,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            message.trim(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.redAccent,
                              fontSize: 14,
                              height: 1.4,
                            ),
                          ),
                          if (showTimer) ...[
                            const SizedBox(height: 12),
                            const Text(
                              "10:17",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ] else ...[
                    // Progress with 3 steps look
                    Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            LinearProgressIndicator(
                              value: progress,
                              minHeight: 8,
                              backgroundColor: Colors.grey.shade200,
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _ProgressDot(
                                  active: progress >= 0.33,
                                  label: "PickedUp",
                                ),
                                _ProgressDot(
                                  active: progress >= 0.66,
                                  label: "InRoute",
                                ),
                                _ProgressDot(
                                  active: progress >= 0.99,
                                  label: "Delivered",
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "PickedUp",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              "InRoute",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              "Delivered",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],

                  const SizedBox(height: 20),

                  // Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        "View Live Map",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _InfoRow({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Text(
            "$label:",
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _ProgressDot({required bool active, required String label}) {
    return Column(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? Colors.orange : Colors.grey.shade300,
            border: Border.all(
              color: active ? Colors.orange.shade700 : Colors.grey.shade400,
              width: 3,
            ),
          ),
        ),
      ],
    );
  }
}
