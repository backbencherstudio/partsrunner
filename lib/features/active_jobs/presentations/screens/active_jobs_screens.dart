import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:partsrunner/core/routes/app_route_names.dart';
import '../../../../core/constant/app_color.dart';

class ActiveJobsScreen extends StatefulWidget {
  const ActiveJobsScreen({super.key});

  @override
  State<ActiveJobsScreen> createState() => _ActiveJobsScreenState();
}

class _ActiveJobsScreenState extends State<ActiveJobsScreen> {
  int _selectedTabIndex = 0;
  final List<String> _tabs = ['All', 'Ongoing', 'Completed', 'Canceled'];

  @override
  Widget build(BuildContext context) {
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
                    _tabs.length,
                    (index) => index == _selectedTabIndex,
                  ),
                  onPressed: (index) {
                    setState(() {
                      _selectedTabIndex = index;
                    });
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
                  children: _tabs.map((tab) => Text(tab)).toList(),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          // List of Cards
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: mockJobs.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final job = mockJobs[index];
                return _JobCard(job: job);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _JobCard extends StatelessWidget {
  final JobModel job;

  const _JobCard({required this.job});

  Color _getStatusColor(String status) {
    final s = status.toLowerCase();
    if (s == 'in progress') {
      return Colors.green;
    } else if (s == 'available') {
      return const Color(0xFF9B51E0); // a purple tone
    } else if (s == 'completed') {
      return const Color(0xFFFF7A59); // reddish/orange tone from image
    }
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(job.status);

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
                      job.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ID: ${job.id}',
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
                  job.status,
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
                        text: job.dateStr,
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
                        text: '${job.distance} Miles',
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
              text: 'Supplier Location: ',
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
              children: [
                TextSpan(
                  text: job.location,
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

// Mock Data
class JobModel {
  final String title;
  final String id;
  final String dateStr;
  final int distance;
  final String location;
  final String status;

  const JobModel({
    required this.title,
    required this.id,
    required this.dateStr,
    required this.distance,
    required this.location,
    required this.status,
  });
}

const mockJobs = [
  JobModel(
    title: 'Apple Watch Series 8',
    id: 'VTY7162E',
    dateStr: '10/08/2026',
    distance: 125,
    location: '102 Ocean Road, Melbourne.',
    status: 'In Progress',
  ),
  JobModel(
    title: 'Apple Watch Series 8',
    id: 'VTY7162E',
    dateStr: '10/08/2026',
    distance: 125,
    location: '102 Ocean Road, Melbourne.',
    status: 'Available',
  ),
  JobModel(
    title: 'Apple Watch Series 8',
    id: 'VTY7162E',
    dateStr: '10/08/2026',
    distance: 125,
    location: '102 Ocean Road, Melbourne.',
    status: 'Completed',
  ),
  JobModel(
    title: 'Apple Watch Series 8',
    id: 'VTY7162E',
    dateStr: '10/08/2026',
    distance: 125,
    location: '102 Ocean Road, Melbourne.',
    status: 'Completed',
  ),
];
