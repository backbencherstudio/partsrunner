import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../home/presentaion/screen/home_screen.dart';
import '../provider/parent_screen_provider.dart';

class ParentScreen extends ConsumerWidget {
  const ParentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavProvider);

    final screens = [
      const HomeScreen(),
      const HomeScreen(),
      const HomeScreen(),
      const HomeScreen(),
    ];

    return Scaffold(
      backgroundColor: Color(0xffF6F7F7),
      body: screens[currentIndex],
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.3),
                spreadRadius: 1.r,
                blurRadius: 5.r,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem("assets/images/index0.png", 0, currentIndex, ref),
              _buildNavItem("assets/images/index1.png", 1, currentIndex, ref),
              _buildNavItem("assets/images/index2.png", 2, currentIndex, ref),
              _buildNavItem("assets/images/profile.png", 3, currentIndex, ref),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    String imagePath,
    int index,
    int currentIndex,
    WidgetRef ref,
  ) {
    bool isSelect = index == currentIndex;
    return GestureDetector(
      onTap: () {
        ref.read(bottomNavProvider.notifier).state = index;
      },
      child: Container(
        padding:  EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelect ? Color(0xffFF4000) : Colors.transparent,
        ),
        child: Image.asset(
          imagePath,
          height: 40.h,
          color: isSelect ? Color(0xffFFFFFF) : Color(0xffFF4000),
        ),
      ),
    );
  }
}
