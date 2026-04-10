import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partsrunner/core/widget/customButton.dart';
import 'package:partsrunner/core/widget/order_tracker.dart';
import 'package:partsrunner/features/active_tracking/data/models/active_delivery_model.dart';

enum Status { available, inProgress, atLocation }

// ---------------------------------------------------------------------------
// Riverpod: countdown timer state + notifier
// ---------------------------------------------------------------------------

class TrackingTimerState {
  final int remainingSeconds;
  final bool isRunning;

  const TrackingTimerState({
    required this.remainingSeconds,
    required this.isRunning,
  });

  String get formattedTime {
    final m = remainingSeconds ~/ 60;
    final s = remainingSeconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  TrackingTimerState copyWith({int? remainingSeconds, bool? isRunning}) {
    return TrackingTimerState(
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      isRunning: isRunning ?? this.isRunning,
    );
  }
}

class TrackingTimerNotifier extends FamilyNotifier<TrackingTimerState, String> {
  static const int _initialSeconds = 10 * 60; // 10:00
  Timer? _timer;

  @override
  TrackingTimerState build(String itemId) {
    // Cancel any running timer when the provider is disposed/rebuilt.
    ref.onDispose(() => _timer?.cancel());
    return const TrackingTimerState(
      remainingSeconds: _initialSeconds,
      isRunning: false,
    );
  }

  void start() {
    if (state.isRunning) return;
    state = state.copyWith(isRunning: true);
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (state.remainingSeconds > 0) {
        state = state.copyWith(remainingSeconds: state.remainingSeconds - 1);
      } else {
        stop();
      }
    });
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
    state = state.copyWith(isRunning: false);
  }

  void reset() {
    stop();
    state = const TrackingTimerState(
      remainingSeconds: _initialSeconds,
      isRunning: false,
    );
  }
}

/// Family provider keyed by item ID so each tracking item has its own timer.
final trackingTimerProvider =
    NotifierProviderFamily<TrackingTimerNotifier, TrackingTimerState, String>(
      TrackingTimerNotifier.new,
    );

// ---------------------------------------------------------------------------
// Widget
// ---------------------------------------------------------------------------

class TrackingItem extends ConsumerStatefulWidget {
  final ActiveDeliveryModel item;

  const TrackingItem({super.key, required this.item});

  @override
  ConsumerState<TrackingItem> createState() => _TrackingItemState();
}

class _TrackingItemState extends ConsumerState<TrackingItem> {
  OrderStatus _getStatus(String status) {
    if (status.toLowerCase().contains('picked_up')) {
      return OrderStatus.pickedUp;
    }
    if (status.toLowerCase().contains('en_route')) {
      return OrderStatus.enRoute;
    }
    return OrderStatus.delivered;
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final itemId = item.id.toString();

    final name = item.packageName;
    final id = item.id;
    final runner = item.runner?.user?.name;
    final supplier = item.supplier?.name;
    final price = item.totalAmount;
    final eta = item.estimatedTimeMin;
    final status = item.status;
    final message =
        'The counter is preparing your order. You can call supply house for any delays\nRunner is Waiting for Parts...';
    final showTimer = item.estimatedTimeMin! == 0;

    // Listen to estimatedTimeMin changes and start/stop the timer reactively.
    ref.listen<bool>(trackingTimerProvider(itemId).select((_) => showTimer), (
      previous,
      next,
    ) {
      final notifier = ref.read(trackingTimerProvider(itemId).notifier);
      if (next) {
        notifier.start();
      } else {
        notifier.stop();
        notifier.reset();
      }
    });

    // Manually trigger the initial start/stop since ref.listen doesn't support fireImmediately.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final notifier = ref.read(trackingTimerProvider(itemId).notifier);
      if (showTimer) {
        notifier.start();
      } else {
        notifier.stop();
        notifier.reset();
      }
    });

    final timerState = ref.watch(trackingTimerProvider(itemId));

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
                        name!,
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
                    color: status!.toLowerCase().contains('en_route')
                        ? Colors.green.withOpacity(0.12)
                        : status.toLowerCase().contains('delivered')
                        ? Colors.purple.withOpacity(0.12)
                        : Colors.blue.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status.toLowerCase().contains('en_route')
                        ? 'In Progress'
                        : status.toLowerCase().contains('delivered')
                        ? 'At Location'
                        : 'Available',
                    style: TextStyle(
                      color: status.toLowerCase().contains('en_route')
                          ? Colors.green
                          : status.toLowerCase().contains('delivered')
                          ? Colors.purple
                          : Colors.blue,
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
                      _buildInfoText("Runner: ", runner!),
                      const SizedBox(height: 8),
                      _buildInfoText("Supplier: ", supplier!),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildInfoText("Price: ", price!),
                      const SizedBox(height: 8),
                      _buildInfoText("ETA: ", eta.toString()),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Message or Progress
            if (showTimer) ...[
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
                    const SizedBox(height: 12),
                    Text(
                      timerState.formattedTime,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              OrderTracker(status: _getStatus(status)),
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
