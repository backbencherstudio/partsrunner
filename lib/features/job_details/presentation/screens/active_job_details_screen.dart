import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:partsrunner/core/models/delivery_model.dart';
import 'package:partsrunner/core/routes/app_route_names.dart';
import 'package:partsrunner/features/job_details/presentation/providers/job_details_provider.dart';

class ActiveJobDetailsScreen extends ConsumerStatefulWidget {
  const ActiveJobDetailsScreen({super.key, required this.id});

  final String id;

  @override
  ConsumerState<ActiveJobDetailsScreen> createState() =>
      _ActiveJobDetailsScreenState();
}

class _ActiveJobDetailsScreenState
    extends ConsumerState<ActiveJobDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final currentStage = ref.watch(activeJobStageProvider);
    final jobDetails = ref.watch(getRequestById(widget.id));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        centerTitle: true,
        title: Column(
          children: [
            const Text(
              'Active Job Details',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            jobDetails.when(
              data: (job) => Text(
                'ID: ${job.id}',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
              ),
              loading: () => const Text(
                'ID: Loading...',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              error: (_, _) => const Text(
                'ID: Error',
                style: TextStyle(color: Colors.red, fontSize: 13),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            // 1. Progress Stepper
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: JobProgressStepper(stage: currentStage),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // 2. Status Card (Dynamic based on stage)
                    StatusCard(stage: currentStage, jobDetails: jobDetails),
                    const SizedBox(height: 25),

                    // 3. Middle Content (Changes per screenshot)
                    _buildMiddleContent(currentStage, jobDetails),
                  ],
                ),
              ),
            ),

            // 4. Bottom Action Buttons
            Padding(
              padding: const EdgeInsets.all(20),
              child: jobDetails.when(
                data: (job) => _buildBottomActions(currentStage, job),
                loading: () => const SizedBox(),
                error: (_, _) => const SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiddleContent(
    int currentStage,
    AsyncValue<DeliveryModel> jobDetails,
  ) {
    if (currentStage == 1) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Text(
          "Tap below once you are physically at the counter and ready to receive the parts",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.4),
        ),
      );
    } else if (currentStage == 2) {
      return const TimerSection();
    } else if (currentStage == 3) {
      return InfoSection(
        title: "Pickup Details",
        personLabel: "Counter Person",
        personName: "Counter Staff",
        jobDetails: jobDetails,
      );
    } else {
      return Column(
        children: [
          InfoSection(
            title: "Delivery Details",
            personLabel: "Technician Name",
            personName: "Technician",
            jobDetails: jobDetails,
          ),
          const SizedBox(height: 20),
          SpecialInstructions(jobDetails: jobDetails),
        ],
      );
    }
  }

  Widget _buildBottomActions(int currentStage, DeliveryModel jobDetails) {
    if (currentStage == 4) {
      return Column(
        children: [
          PrimaryButton(
            text: "Take Photo Proof",
            icon: Icons.camera_alt_outlined,
            onPressed: () {
              
            },
          ),
          const SizedBox(height: 12),
          PrimaryButton(
            text: "Mark as Delivered",
            isSecondary: true,
            onPressed: () async {
              await ref.read(
                updateRequestStatus((
                  id: widget.id,
                  status: "DELIVERED",
                  proofFile: null,
                )).future,
              );
              if (context.mounted) {
                context.goNamed(
                  AppRouteNames.message,
                  extra: {
                    'title': 'Delivery Complete',
                    'message': 'Your delivery has been marked as complete.',
                    'imagePath': 'assets/icons/success.png',
                    'buttonText': 'Back to Home',
                    'earning': jobDetails.totalAmount,
                    'routeName': AppRouteNames.bottomNav,
                  },
                );
              }
            },
          ),
        ],
      );
    }

    String btnText = "I've Arrived";
    String status = "";
    if (currentStage == 1) {
      btnText = "I've Arrived";
      status = "PICKED_UP";
    }
    if (currentStage == 2) {
      btnText = "Package Acquired";
      status = "EN_ROUTE";
    }
    if (currentStage == 3) {
      btnText = "Confirm Pickup";
      status = "EN_ROUTE";
    }

    return PrimaryButton(
      text: btnText,
      onPressed: () async {
        // Call API to update status before changing stage
        if (status.isNotEmpty) {
          await ref.read(
            updateRequestStatus((
              id: widget.id,
              status: status,
              proofFile: null,
            )).future,
          );
        }
        ref.read(activeJobStageProvider.notifier).state = currentStage + 1;
      },
    );
  }
}

// --- SUB-WIDGETS ---

class JobProgressStepper extends StatelessWidget {
  final int stage;
  const JobProgressStepper({super.key, required this.stage});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _step(true, "Requested"),
        _line(stage >= 2),
        _step(stage >= 1, "Accepted"),
        _line(stage >= 2),
        _step(stage >= 3, "Pickup", isCurrent: stage < 4),
        _line(stage >= 4),
        _step(stage >= 4, "En Route"),
        _line(false),
        _step(false, "Delivered"),
      ],
    );
  }

  Widget _step(bool active, String label, {bool isCurrent = false}) {
    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: active ? Colors.deepOrange : Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: active ? Colors.deepOrange : Colors.grey.shade300,
            ),
          ),
          child: Icon(
            isCurrent
                ? Icons.inventory_2_outlined
                : (active ? Icons.check : Icons.inventory_2_outlined),
            size: 16,
            color: active ? Colors.white : Colors.grey.shade300,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: active ? Colors.deepOrange : Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _line(bool active) {
    return Expanded(
      child: Container(
        height: 2,
        color: active ? Colors.deepOrange : Colors.grey.shade200,
        margin: const EdgeInsets.only(bottom: 15),
      ),
    );
  }
}

class StatusCard extends StatelessWidget {
  final int stage;
  final AsyncValue<DeliveryModel> jobDetails;
  const StatusCard({super.key, required this.stage, required this.jobDetails});

  @override
  Widget build(BuildContext context) {
    String stageText = "Stage $stage: ";
    String status = "Going to PICKUP";
    String title = "Ferguson Supply";
    String subtitle = "2847 Industrial Blvd, Austin, TX";

    jobDetails.when(
      data: (job) {
        if (job.supplier != null) {
          title = job.supplier!.name ?? 'Unknown Supplier';
          subtitle =
              '${job.supplier!.location ?? ''}, ${job.supplier!.street ?? ''}, ${job.supplier!.city ?? ''}';
        }
      },
      loading: () {},
      error: (_, _) {},
    );

    if (stage == 2) {
      status = "Waiting Room";
      title = "Waiting for Parts...";
      subtitle = "At supplier location";
    }
    if (stage == 4) {
      status = "Delivery";
      jobDetails.when(
        data: (job) {
          title = "Deliver to: ${job.technicianName ?? 'Unknown'}";
          subtitle = job.deliveryAddress ?? 'Unknown address';
        },
        loading: () {},
        error: (_, _) {},
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1EE),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.deepOrange.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
              children: [
                TextSpan(text: stageText),
                TextSpan(
                  text: status.toUpperCase(),
                  style: const TextStyle(color: Colors.deepOrange),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.deepOrange, size: 18),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  subtitle,
                  style: const TextStyle(color: Colors.black54),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TimerSection extends StatelessWidget {
  const TimerSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            const SizedBox(
              width: 150,
              height: 150,
              child: CircularProgressIndicator(
                value: 0.3,
                strokeWidth: 6,
                color: Colors.deepOrange,
                backgroundColor: Color(0xFFF5F5F5),
              ),
            ),
            const Column(
              children: [
                Text(
                  "00:17",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
                Text("Time at counter", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class InfoSection extends StatelessWidget {
  final String title, personLabel, personName;
  final AsyncValue<DeliveryModel> jobDetails;
  const InfoSection({
    super.key,
    required this.title,
    required this.personLabel,
    required this.personName,
    required this.jobDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            _tile(Icons.person_outline, personLabel, personName),
            const SizedBox(width: 10),
            _tile(Icons.access_time, "Pickup Time", "10:15 AM"),
          ],
        ),
      ],
    );
  }

  Widget _tile(IconData icon, String label, String val) {
    return Expanded(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.black54),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  val,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SpecialInstructions extends StatelessWidget {
  final AsyncValue<DeliveryModel> jobDetails;
  const SpecialInstructions({super.key, required this.jobDetails});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.error_outline, color: Colors.blue),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Special Instructions",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Deliver to back entrance near loading dock.",
                  style: TextStyle(color: Colors.black54, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isSecondary;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.isSecondary = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSecondary
              ? Colors.grey.shade100
              : Colors.deepOrange,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: TextStyle(
                color: isSecondary ? Colors.grey : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
