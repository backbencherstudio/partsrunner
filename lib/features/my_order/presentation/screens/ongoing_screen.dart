import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partsrunner/core/routes/app_route_names.dart';
import 'package:go_router/go_router.dart';
import 'package:partsrunner/core/widget/tracking_item.dart';
import 'package:partsrunner/features/my_order/presentation/providers/order_provider.dart';

class OngoingScreen extends ConsumerWidget {
  const OngoingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ongoingOrderProvider = ref.watch(ongoingOrdersProvider);
    return ongoingOrderProvider.when(
      data: (order) => ListView.builder(
        padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
        itemCount: order.length,
        itemBuilder: (context, index) {
          final item = order[index];
          return TrackingItem(item: item);
        },
      ),
      error: (error, stackTrace) => Center(child: Text(error.toString())),
      loading: () => Center(child: CircularProgressIndicator()),
    );
    // return Scaffold(
    //   backgroundColor: Colors.white,
    //   body: ListView(
    //     padding: const EdgeInsets.symmetric(horizontal: 16),
    //     children: [
    //       _buildWaitingCard(() {
    //         context.pushNamed(AppRouteNames.orderDetails);
    //       }),
    //       const SizedBox(height: 16),
    //       _buildActiveDeliveryCard(true, () {
    //         context.pushNamed(AppRouteNames.orderDetails);
    //       }),
    //       const SizedBox(height: 16),
    //       _buildActiveDeliveryCard(false, () {
    //         context.pushNamed(AppRouteNames.orderDetails);
    //       }),
    //       const SizedBox(height: 40),
    //     ],
    //   ),
    // );
  }

  Widget _buildWaitingCard(void Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[200]!),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              offset: const Offset(0, 4),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffFFECE6),
                  ),
                  child: Image.asset(
                    "assets/images/index2.png",
                    height: 24,
                    width: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Apple Watch Series 8",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "ID: VTY7162E",
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color(0xffEAF5FE),
                  ),
                  child: const Text(
                    "At Location",
                    style: TextStyle(color: Color(0xff068FFF), fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoRow("Runner: ", "Michael S.", "Price: ", "\$125.00"),
            const SizedBox(height: 8),
            _buildInfoRow("Supplier: ", "Auto Supply Co.", "ETA: ", "-"),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xffFFF2EE),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xffFFD6C9)),
              ),
              child: const Column(
                children: [
                  Text(
                    "The counter is preparing your order. You can call\nsupply house for any delays",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xffFF4000), fontSize: 12),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Runner is Waiting for Parts...",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "10:17",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: const Color(0xffFFD6C9)),
              ),
              child: const Center(
                child: Text(
                  "View Live Map",
                  style: TextStyle(
                    color: Color(0xffFFB5A1),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveDeliveryCard(bool addShadow, void Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[200]!),
          borderRadius: BorderRadius.circular(16),
          boxShadow: addShadow
              ? [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.05),
                    offset: const Offset(0, 4),
                    blurRadius: 10,
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    "Active Delivery: ID: VTY7162E",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color(0xffEAFDF2),
                  ),
                  child: const Text(
                    "In Progress",
                    style: TextStyle(color: Color(0xff22C55E), fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoRow("Runner: ", "Michael S.", "Price: ", "\$125.00"),
            const SizedBox(height: 8),
            _buildInfoRow("Supplier: ", "Auto Supply Co.", "ETA: ", "12 mins"),
            const SizedBox(height: 24),
            _buildStepper(),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: const Color(0xffFF4000)),
              ),
              child: const Center(
                child: Text(
                  "View Live Map",
                  style: TextStyle(
                    color: Color(0xffFF4000),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    String title1,
    String value1,
    String title2,
    String value2,
  ) {
    return Row(
      children: [
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black, fontSize: 14),
              children: [
                TextSpan(
                  text: title1,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: value1,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black, fontSize: 14),
              children: [
                TextSpan(
                  text: title2,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: value2,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStepper() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            const SizedBox(height: 16),
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: Color(0xffFF4000),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Picked Up",
              style: TextStyle(color: Color(0xffFFB5A1), fontSize: 12),
            ),
          ],
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            height: 2,
            color: const Color(0xffFF4000),
          ),
        ),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Color(0xffFFECE6),
                shape: BoxShape.circle,
              ),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Color(0xffFF4000),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.inventory_2_outlined,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "En Route",
              style: TextStyle(
                color: Color(0xffFF4000),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            height: 2,
            color: Colors.grey[200],
          ),
        ),
        Column(
          children: [
            const SizedBox(height: 16),
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Delivered",
              style: TextStyle(color: Colors.grey[400], fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }
}
