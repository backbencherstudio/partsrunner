import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ActiveJobDetailsScreen(),
    ),
  );
}

class ActiveJobDetailsScreen extends StatefulWidget {
  const ActiveJobDetailsScreen({super.key});

  @override
  State<ActiveJobDetailsScreen> createState() => _ActiveJobDetailsScreenState();
}

class _ActiveJobDetailsScreenState extends State<ActiveJobDetailsScreen> {
  // Toggle this from 1 to 4 to see different screen states from your screenshots
  final int _currentStage = 2;

  @override
  Widget build(BuildContext context) {
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
            Text(
              'ID: VTY7162E',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
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
              child: JobProgressStepper(stage: _currentStage),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // 2. Status Card (Dynamic based on stage)
                    StatusCard(stage: _currentStage),
                    const SizedBox(height: 25),

                    // 3. Middle Content (Changes per screenshot)
                    _buildMiddleContent(),
                  ],
                ),
              ),
            ),

            // 4. Bottom Action Buttons
            Padding(
              padding: const EdgeInsets.all(20),
              child: _buildBottomActions(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiddleContent() {
    if (_currentStage == 1) {
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
    } else if (_currentStage == 2) {
      return const TimerSection();
    } else if (_currentStage == 3) {
      return const InfoSection(
        title: "Pickup Details",
        personLabel: "Counter Person",
        personName: "Arlene McCoy",
      );
    } else {
      return const Column(
        children: [
          InfoSection(
            title: "Delivery Details",
            personLabel: "Technician Name",
            personName: "Darlene Robertson",
          ),
          SizedBox(height: 20),
          SpecialInstructions(),
        ],
      );
    }
  }

  Widget _buildBottomActions() {
    if (_currentStage == 4) {
      return Column(
        children: [
          PrimaryButton(
            text: "Take Photo Proof",
            icon: Icons.camera_alt_outlined,
            onPressed: () {},
          ),
          const SizedBox(height: 12),
          PrimaryButton(
            text: "Mark as Delivered",
            isSecondary: true,
            onPressed: null, // Disabled as per screenshot
          ),
        ],
      );
    }

    String btnText = "I've Arrived";
    if (_currentStage == 2) btnText = "Package Acquired";
    if (_currentStage == 3) btnText = "Confirm Pickup";

    return PrimaryButton(text: btnText, onPressed: () {});
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
        _step(stage >= 2, "Accepted"),
        _line(stage >= 3),
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
  const StatusCard({super.key, required this.stage});

  @override
  Widget build(BuildContext context) {
    String stageText = "Stage $stage: ";
    String status = "Going to PICKUP";
    String title = "Ferguson Supply";
    String subtitle = "2847 Industrial Blvd, Austin, TX";

    if (stage == 2) {
      status = "Waiting Room";
      title = "Waiting for Parts...";
      subtitle = "At Ferguson Supply";
    }
    if (stage == 4) {
      status = "Delivery";
      title = "Deliver to: Apex Mechanical";
      subtitle = "1100 E 6th st, Austin TX 78702";
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
              Text(subtitle, style: const TextStyle(color: Colors.black54)),
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
  const InfoSection({
    super.key,
    required this.title,
    required this.personLabel,
    required this.personName,
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
  const SpecialInstructions({super.key});
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
