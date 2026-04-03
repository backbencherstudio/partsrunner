import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partsrunner/core/constant/app_color.dart';

class TransactionDetailsScreen extends StatelessWidget {
  const TransactionDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'Delivery #PR-3039',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            4.verticalSpace,
            Text(
              'Feb 22 1 2026 • 3:30 PM',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColor.primary.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColor.primary.withValues(alpha: 0.3)),
          ),
          child: Column(
            children: [
              // JOB SUMMARY Card
              _buildSectionCard(
                icon: Icons.location_on,
                title: 'JOB SUMMARY',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 14.sp, color: Colors.black, fontFamily: 'Inter'),
                        children: [
                          TextSpan(text: 'Pickup Location: ', style: TextStyle(fontWeight: FontWeight.w500)),
                          TextSpan(text: 'AutoZone – 3.2 miles', style: TextStyle(color: Colors.grey.shade600)),
                        ],
                      ),
                    ),
                    8.verticalSpace,
                    RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 14.sp, color: Colors.black, fontFamily: 'Inter'),
                        children: [
                          TextSpan(text: 'Drop-Off Location: ', style: TextStyle(fontWeight: FontWeight.w500)),
                          TextSpan(text: 'Acme HVAC – 7.5 miles', style: TextStyle(color: Colors.grey.shade600)),
                        ],
                      ),
                    ),
                    16.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildIconText(Icons.location_on_outlined, '9.7 miles'),
                        _buildIconText(Icons.access_time, '38 mins'),
                      ],
                    ),
                  ],
                ),
              ),
              16.verticalSpace,

              // Earnings Breakdown Card
              _buildSectionCard(
                icon: Icons.attach_money,
                title: 'Earnings Breakdown',
                child: Column(
                  children: [
                    _buildEarningsRow('Base Pay:', '\$14.00'),
                    8.verticalSpace,
                    _buildEarningsRow('Distance Bonus:', '\$14.00'),
                    12.verticalSpace,
                    Divider(color: Colors.grey.shade300),
                    12.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total:',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$14.00',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColor.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              16.verticalSpace,

              // Payment Status Card
              _buildSectionCard(
                icon: Icons.attach_money,
                title: 'Payment Status',
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: AppColor.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: AppColor.primary),
                  ),
                  child: Text(
                    'Available',
                    style: TextStyle(
                      color: AppColor.primary,
                      fontSize: 14.sp,
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

  Widget _buildSectionCard({required IconData icon, required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: AppColor.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: AppColor.primary, size: 20.sp),
              ),
              12.horizontalSpace,
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          16.verticalSpace,
          child,
        ],
      ),
    );
  }

  Widget _buildEarningsRow(String label, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey.shade600,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildIconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18.sp, color: Colors.grey.shade700),
        4.horizontalSpace,
        Text(
          text,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}