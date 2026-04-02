import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partsrunner/core/widget/customButton.dart';

class ContactorHomeWidget extends StatelessWidget {
  const ContactorHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Current Shipping",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                "View All",
                style: TextStyle(
                  color: Color(0xffFF4000),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 8),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Active Delivery: VTY7162E",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "In Progress",
                        style: TextStyle(color: Colors.green, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  "Runner: Michael S. • Price: \$125.00 • Supplier: Auto Supply Co.",
                ),
                SizedBox(height: 12),
                // ETA progress bar simulation
                LinearProgressIndicator(value: 0.6, minHeight: 8),
                SizedBox(height: 8),
                Text("ETA 12 min", style: TextStyle(fontSize: 12)),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: "View Live Map",
                    submit: () {},
                    backgroundColor: Color(0xffFF4000),
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // Add Recent Shipping section similarly...
          // (you can copy-paste and adapt the pattern)
          SizedBox(
            height: 100,
          ), // extra space at bottom to test scroll (remove later)
        ],
      ),
    );
  }
}
