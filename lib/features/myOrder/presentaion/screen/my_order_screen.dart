import 'package:flutter/material.dart';

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

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 27),
            child: Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xffF8FAFB),
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: isOngoing
                              ? const Color(0xffFCF2EF)
                              : const Color(0xffF8FAFB),
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: !isOngoing
                              ? const Color(0xffFCF2EF)
                              : const Color(0xffF8FAFB),
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

          const SizedBox(height: 20),

          /// Example Content Change
          Expanded(
            child: Center(
              child: Text(
                isOngoing ? "Ongoing Orders List" : "Completed Orders List",
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
