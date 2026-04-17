import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'completed_screen.dart';
import 'ongoing_screen.dart';
import '../providers/order_provider.dart';

class MyOrderScreen extends ConsumerWidget {
  const MyOrderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Order",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xffF8FAFB),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          ref.read(orderTabProvider.notifier).state = true;
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ref.watch(orderTabProvider)
                                ? Colors.white
                                : Colors.transparent,
                            border: ref.watch(orderTabProvider)
                                ? Border.all(color: const Color(0xffFF4000))
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              "Ongoing",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: ref.watch(orderTabProvider)
                                    ? const Color(0xffFF4000)
                                    : Colors.grey[400],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          ref.read(orderTabProvider.notifier).state = false;
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: !ref.watch(orderTabProvider)
                                ? Colors.white
                                : Colors.transparent,
                            border: !ref.watch(orderTabProvider)
                                ? Border.all(color: const Color(0xffFF4000))
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              "Completed",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: !ref.watch(orderTabProvider)
                                    ? const Color(0xffFF4000)
                                    : Colors.grey[400],
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
            16.verticalSpace,
            Expanded(
              child: ref.watch(orderTabProvider)
                  ? const OngoingScreen()
                  : const CompletedScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
