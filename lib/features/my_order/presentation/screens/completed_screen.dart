import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:partsrunner/core/routes/app_route_names.dart';
import 'package:partsrunner/features/my_order/presentation/providers/order_provider.dart';

class CompletedScreen extends ConsumerWidget {
  const CompletedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completedOrderProvider = ref.watch(completedOrdersProvider);
    return completedOrderProvider.when(
      data: (order) => ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: order.length + 2,
        itemBuilder: (context, index) {
          return CompleteOrderCard(
            title:
                //  order[index].packageName ??
                "Apple Watch Series 8",
            orderId:
                //  order[index].id ??
                "VTY7162E",
            recipient:
                //  order[index].recipient ??
                "Sandy Permata",
            address:
                //  order[index].address ??
                "Jl.kenanga no 2 batang",
          );
        },
      ),
      error: (state, stackTrace) =>
          Center(child: Text("Failed to load orders. $state")),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class CompleteOrderCard extends StatelessWidget {
  const CompleteOrderCard({
    super.key,
    required this.title,
    required this.orderId,
    required this.recipient,
    required this.address,
  });

  final String title;
  final String orderId;
  final String recipient;
  final String address;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: () {
          context.pushNamed(AppRouteNames.orderDetails);
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[200]!),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.05),
                offset: const Offset(0, 4),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        Text(
                          title,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "ID: $orderId",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
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
                      color: const Color(0xffFFECE6),
                    ),
                    child: const Text(
                      "Completed",
                      style: TextStyle(color: Color(0xffFF4000), fontSize: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Recipient",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          recipient,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Address",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          address,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
