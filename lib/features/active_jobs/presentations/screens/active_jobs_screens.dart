import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:partsrunner/core/models/delivery_model.dart';
import 'package:partsrunner/core/routes/app_route_names.dart';
import '../../../../core/constant/app_color.dart';
import '../providers/active_jobs_provider.dart';

class ActiveJobsScreen extends ConsumerWidget {
  const ActiveJobsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTabIndex = ref.watch(selectedTabIndexProvider);
    final tabs = ['All', 'Ongoing', 'Completed', 'Canceled'];

    FutureProvider<List<DeliveryModel>> getCurrentProvider() {
      switch (selectedTabIndex) {
        case 0:
          return getAllDeliveriesProvider;
        case 1:
          return getOngoingDeliveriesProvider;
        case 2:
          return getCompletedDeliveriesProvider;
        case 3:
          return getCanceledDeliveriesProvider;
        default:
          return getAllDeliveriesProvider;
      }
    }

    final deliveriesAsync = ref.watch(getCurrentProvider());
    return Scaffold(
      backgroundColor:
          Colors.white, // assuming a white background for the screen
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Active Job',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          // Tab bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                // subtract horizontal padding and roughly borders
                final double buttonWidth = (constraints.maxWidth - 6) / 4;
                return ToggleButtons(
                  isSelected: List.generate(
                    tabs.length,
                    (index) => index == selectedTabIndex,
                  ),
                  onPressed: (index) {
                    ref.read(selectedTabIndexProvider.notifier).state = index;
                  },
                  color: Colors.grey.shade500,
                  selectedColor: AppColor.primary,
                  fillColor: AppColor.primary.withOpacity(0.05),
                  borderColor: Colors.grey.shade200,
                  selectedBorderColor: AppColor.primary,
                  borderRadius: BorderRadius.circular(6),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                  constraints: BoxConstraints(
                    minWidth: buttonWidth,
                    minHeight: 44, // reasonably tall tabs
                  ),
                  children: tabs.map((tab) => Text(tab)).toList(),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          // List of Cards
          Expanded(
            child: deliveriesAsync.when(
              data: (deliveries) {
                if (deliveries.isEmpty) {
                  return const Center(
                    child: Text(
                      'No deliveries found',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  itemCount: deliveries.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final delivery = deliveries[index];
                    return _DeliveryCard(delivery: delivery);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text(
                  'Error: ${error.toString()}',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DeliveryCard extends StatelessWidget {
  final DeliveryModel delivery;

  const _DeliveryCard({required this.delivery});

  Color _getStatusColor(String? status) {
    if (status == null) return Colors.grey;
    final s = status.toLowerCase();
    if (s == 'in progress' || s == 'en_route') {
      return Colors.green;
    } else if (s == 'available' || s == 'pending') {
      return const Color(0xFF9B51E0); // a purple tone
    } else if (s == 'completed' || s == 'delivered') {
      return const Color(0xFFFF7A59); // reddish/orange tone from image
    } else if (s == 'canceled') {
      return Colors.red;
    }
    return Colors.grey;
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'N/A';
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(delivery.status);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header info
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColor.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.inventory_2_outlined,
                    color: AppColor.primary,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      delivery.packageName ?? 'Unknown Package',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ID: ${delivery.id ?? 'N/A'}',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
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
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  delivery.status ?? 'Unknown',
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Date & Distance Row
          Row(
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: 'Date: ',
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                    children: [
                      TextSpan(
                        text: _formatDate(delivery.pickupDate),
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: 'Distance: ',
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                    children: [
                      TextSpan(
                        text:
                            '${delivery.estimatedDistanceKm?.toStringAsFixed(1) ?? 'N/A'} km',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Location
          RichText(
            text: TextSpan(
              text: 'Delivery Location: ',
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
              children: [
                TextSpan(
                  text: delivery.deliveryAddress ?? 'N/A',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // View Details Button
          OutlinedButton(
            onPressed: () {
              context.pushNamed(AppRouteNames.packageDetails);
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColor.primary,
              side: const BorderSide(color: AppColor.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: const Text(
              'View Details',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
