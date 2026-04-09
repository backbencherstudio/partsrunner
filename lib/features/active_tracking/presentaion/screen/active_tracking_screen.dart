import 'package:flutter/material.dart';
import 'package:partsrunner/features/active_tracking/presentaion/widgets/tracking_item.dart';

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

          return TrackingItem(item: item);
        },
      ),
    );
  }
}
