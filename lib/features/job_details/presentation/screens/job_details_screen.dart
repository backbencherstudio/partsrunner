import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:partsrunner/core/routes/app_route_names.dart';

class JobDetailsScreen extends StatelessWidget {
  const JobDetailsScreen({super.key});

  // Common constants for consistency
  static const Color primaryOrange = Color(0xFFFF4500);
  static const Color lightGreyBg = Color(0xFFFAFAFA);
  static const Color secondaryGrey = Color(0xFF757575);
  static const Color borderOrange = Color(0xFFFFE0D6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () {},
        ),
        title: Column(
          children: [
            const Text(
              'Job Details',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const Text(
              'ID: VTY7162E',
              style: TextStyle(color: secondaryGrey, fontSize: 12),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: borderOrange.withOpacity(0.5),
              width: 1.5,
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFEBE5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.delivery_dining,
                      color: primaryOrange,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "New Delivery Request",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "You're 1.2 miles from the pickup location.",
                          style: TextStyle(color: secondaryGrey, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Pickup Section
              _buildInfoCard(
                icon: Icons.location_on,
                label: "Pickup Location",
                placeName: "Auto Supply Co.",
                address: "2847 Industrial Blvd, Austin, TX",
                isVerified: true,
                trailingText: "1.2 M away",
              ),
              const SizedBox(height: 16),

              // Drop-off Section
              _buildInfoCard(
                icon: Icons.location_on,
                label: "Drop-off Location",
                placeName: "Acme Plumbing",
                address: "5634 Commerce St, Austin, TX",
              ),
              const SizedBox(height: 16),

              // Earnings Section
              _buildEarningsCard(),

              const SizedBox(height: 24),

              // Accept Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    context.pushNamed(AppRouteNames.activeJobDetails);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryOrange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Accept Delivery",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Decline Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFFF2F2F2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Decline",
                    style: TextStyle(
                      color: Color(0xFFBDBDBD),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for Location Cards
  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String placeName,
    required String address,
    bool isVerified = false,
    String? trailingText,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: lightGreyBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: primaryOrange, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    placeName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(width: 4),
                  if (isVerified)
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 16,
                    ),
                ],
              ),
              if (trailingText != null)
                Text(
                  trailingText,
                  style: const TextStyle(
                    color: primaryOrange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            address,
            style: const TextStyle(color: secondaryGrey, fontSize: 14),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: primaryOrange),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text(
                "View Live Map",
                style: TextStyle(
                  color: primaryOrange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget for Earnings Breakdown
  Widget _buildEarningsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: lightGreyBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: primaryOrange,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.attach_money,
                  color: Colors.white,
                  size: 14,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                "Earnings Breakdown",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _earningsRow("Base Pay:", "\$14.00"),
          const SizedBox(height: 8),
          _earningsRow("Distance Bonus:", "\$14.00"),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const Text(
                "\$14.00",
                style: TextStyle(
                  color: primaryOrange,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _earningsRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: secondaryGrey, fontSize: 15)),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ],
    );
  }
}
