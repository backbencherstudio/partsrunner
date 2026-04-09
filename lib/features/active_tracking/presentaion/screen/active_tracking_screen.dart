import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partsrunner/features/active_tracking/data/models/active_delivery_model.dart';
import 'package:partsrunner/features/active_tracking/presentaion/providers/active_tracking_provider.dart';
import 'package:partsrunner/features/active_tracking/presentaion/widgets/tracking_item.dart';

class ActiveTrackingScreen extends ConsumerStatefulWidget {
  const ActiveTrackingScreen({super.key});

  @override
  ConsumerState<ActiveTrackingScreen> createState() =>
      _ActiveTrackingScreenState();
}

class _ActiveTrackingScreenState extends ConsumerState<ActiveTrackingScreen> {
  late List<ActiveDeliveryModel> trackingItem;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final trackingItems = [
    //   {
    //     "name": "Apple Watch Series 8",
    //     "id": "VTY7162E",
    //     "runner": "Michael S.",
    //     "supplier": "Auto Supply Co.",
    //     "price": "\$125.00",
    //     "eta": "-",
    //     "status": "At Location",
    //     "statusColor": Colors.blue,
    //     "progress": 0.0,
    //     "message":
    //         "The counter is preparing your order. You can call supply house for any delays...\nRunner is Waiting for Parts...",
    //     "showTimer": true,
    //   },
    //   {
    //     "name": "Apple Watch Series 8",
    //     "id": "VTY7162E",
    //     "runner": "Michael S.",
    //     "supplier": "Auto Supply Co.",
    //     "price": "\$125.00",
    //     "eta": "12 mins",
    //     "status": "Available",
    //     "statusColor": Colors.purple,
    //     "progress": 0.33, // PickedUp
    //     "message": "",
    //   },
    //   {
    //     "name": "Apple Watch Series 8",
    //     "id": "VTY7162E",
    //     "runner": "Michael S.",
    //     "supplier": "Auto Supply Co.",
    //     "price": "\$125.00",
    //     "eta": "12 mins",
    //     "status": "In Progress",
    //     "statusColor": Colors.green,
    //     "progress": 0.66,
    //     "message": "",
    //   },
    // ];
    final activeDeliveryProvider = ref.watch(getActiveDeliveriesProvider);

    return activeDeliveryProvider.when(
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text("Error: $error")),
      data: (data) {
        print(data);
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
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];

              return TrackingItem(item: item);
            },
          ),
        );
      },
    );
  }
}
