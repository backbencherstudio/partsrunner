import 'package:flutter/material.dart';

import 'completed_screen.dart';
import 'ongoin_screen.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  bool isOngoing = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 60),

          const Text(
            "My Order",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),

          SizedBox(height: 20),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 27),
            child: Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Color(0xffF8FAFB),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isOngoing = true;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: isOngoing
                              ? Color(0xffFCF2EF)
                              : Color(0xffF8FAFB),
                        ),
                        child: Center(
                          child: Text(
                            "Ongoing",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: isOngoing ? Colors.orange : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isOngoing = false;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: !isOngoing
                              ? Color(0xffFCF2EF)
                              : Color(0xffF8FAFB),
                        ),
                        child: Center(
                          child: Text(
                            "Completed",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: !isOngoing ? Colors.orange : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 20),

          Expanded(
            child: Center(
              child: isOngoing ? OngoingScreen() : CompletedScreen(),
            ),
          ),
        ],
      ),
    );
  }
}
