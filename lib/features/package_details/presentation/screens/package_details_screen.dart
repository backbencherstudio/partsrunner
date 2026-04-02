import 'package:flutter/material.dart';

class PackageDetailsScreen extends StatefulWidget {
  const PackageDetailsScreen({super.key});

  @override
  State<PackageDetailsScreen> createState() => _PackageDetailsScreenState();
}

class _PackageDetailsScreenState extends State<PackageDetailsScreen> {
  // Toggle this bool manually or using the floating action button to see the two states
  bool _isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Order Details',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTopCard(context),
            const SizedBox(height: 24),
            Divider(color: Colors.grey.shade200, height: 1),
            const SizedBox(height: 24),
            if (_isCompleted) _buildProofPhoto() else _buildTimeline(),
            const SizedBox(height: 32), // bottom padding
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isCompleted = !_isCompleted;
          });
        },
        tooltip: 'Toggle status for testing',
        backgroundColor: const Color(0xFFFF7A59),
        foregroundColor: Colors.white,
        child: const Icon(Icons.swap_horiz),
      ),
    );
  }

  Widget _buildTopCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _isCompleted
              ? const Color(0xFFFF7A59).withOpacity(0.2)
              : Colors.green.withOpacity(
                  0.2,
                ), // gentle border depending on state
        ),
        boxShadow: [
          BoxShadow(
            color: _isCompleted
                ? const Color(0xFFFF7A59).withOpacity(0.05)
                : Colors.green.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF7A59).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.inventory_2_outlined,
                    color: Color(0xFFFF7A59),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Apple Watch Series 8',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ID: VTY7162EY8',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 14,
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
                  color: _isCompleted
                      ? const Color(0xFFFF7A59).withOpacity(0.1)
                      : Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _isCompleted ? 'Completed' : 'In Progress',
                  style: TextStyle(
                    color: _isCompleted
                        ? const Color(0xFFFF7A59)
                        : Colors.green,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(child: _buildRichText('Date: ', '10/08/2026')),
              Expanded(child: _buildRichText('Distance: ', '125 Miles')),
            ],
          ),
          const SizedBox(height: 12),
          _buildRichText('Package Weight: ', '2.3 KG'),
          const SizedBox(height: 12),
          _buildRichText('Sender: ', 'Alexander'),
          const SizedBox(height: 12),
          _buildRichText('Pickup Location: ', 'AutoZone – 3.2 miles'),
          const SizedBox(height: 12),
          _buildRichText('Receiver: ', 'Jason'),
          const SizedBox(height: 12),
          _buildRichText('Drop-Off Location: ', 'Acme HVAC – 7.5 miles'),
        ],
      ),
    );
  }

  Widget _buildRichText(String label, String value) {
    return RichText(
      text: TextSpan(
        text: label,
        style: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w600,
          fontSize: 14,
          height: 1.4,
        ),
        children: [
          TextSpan(
            text: value,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProofPhoto() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Proof photo',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  'https://images.unsplash.com/photo-1549465220-1a8b9238cd48?q=80&w=600&auto=format&fit=crop', // placeholder sample
                  height: 180,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 180,
                    color: Colors.grey.shade200,
                    child: const Icon(
                      Icons.image_not_supported,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  'https://images.unsplash.com/photo-1580674285054-bed31e145f59?q=80&w=600&auto=format&fit=crop', // placeholder sample
                  height: 180,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 180,
                    color: Colors.grey.shade200,
                    child: const Icon(
                      Icons.image_not_supported,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTimeline() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Text(
                  'The package is being delivered from supply house to the receiver address',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.keyboard_arrow_up, color: Colors.grey.shade600),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '30 minutes ago',
            style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                _buildTimelineItem(
                  title: 'In Supply house',
                  subtitle: 'Package received and being processed.',
                  date: 'Jan 2, 2026',
                  isLast: false,
                ),
                _buildTimelineItem(
                  title: 'In Transit',
                  subtitle: 'Package is on the way to the destination.',
                  date: 'Jan 2, 2026',
                  isLast: false,
                ),
                _buildTimelineItem(
                  title: 'On Delivery',
                  subtitle: 'Delivering the package to the receiver.',
                  date: '25 minutes estimation',
                  isLast: false,
                ),
                _buildTimelineItem(
                  title: 'Delivered',
                  subtitle: '',
                  date: '',
                  isLast: true,
                  isIconOnly: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required String title,
    required String subtitle,
    required String date,
    required bool isLast,
    bool isIconOnly = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width:
                24, // Ensures both the icon and the connection line align effectively properly inside this constrained width.
            child: Column(
              children: [
                if (isIconOnly)
                  Icon(
                    Icons.location_on_outlined,
                    color: Colors.grey.shade500,
                    size: 24,
                  )
                else
                  Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF7A59),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(Icons.check, color: Colors.white, size: 12),
                    ),
                  ),
                if (!isLast)
                  Expanded(
                    child: CustomPaint(
                      painter: DashedLinePainter(),
                      child: const SizedBox(
                        width: 2,
                      ), // Provides explicit bounds
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
                if (subtitle.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
                if (date.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                  ),
                ],
                const SizedBox(height: 20), // Spacing to the next item
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 4, dashSpace = 4, startY = 4;
    final paint = Paint()
      ..color = const Color(0xFFFF7A59)
      ..strokeWidth = 1.5;

    // adjust canvas width alignment to be centered
    final double startX = size.width / 2;

    while (startY < size.height) {
      canvas.drawLine(
        Offset(startX, startY),
        Offset(startX, startY + dashHeight),
        paint,
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
