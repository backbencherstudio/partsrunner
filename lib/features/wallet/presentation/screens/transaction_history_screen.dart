import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:partsrunner/core/constant/app_color.dart';
import 'package:partsrunner/core/routes/app_route_names.dart';
import '../providers/wallet_provider.dart';

class TransactionHistoryScreen extends ConsumerStatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  ConsumerState<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState
    extends ConsumerState<TransactionHistoryScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final withdrawHistoryAsync = ref.watch(withdrawHistoryProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Transaction History',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 20.sp,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Filter Tabs
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Row(
              children: [
                _buildTab(0, 'Today'),
                _buildTab(1, 'This Week'),
                _buildTab(2, 'This Month'),
              ],
            ),
          ),

          // List
          Expanded(
            child: withdrawHistoryAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
              data: (withdrawHistory) {
                // Note: WithdrawModel appears to be a single object, not a list
                // You may need to adjust this based on your actual API response structure
                // For now, showing a placeholder if the data structure is different
                return ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  itemCount: 1,
                  separatorBuilder: (context, index) => 16.verticalSpace,
                  itemBuilder: (context, index) {
                    return _buildTransactionCard(withdrawHistory);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(int index, String title) {
    bool isSelected = _selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColor.primary.withValues(alpha: 0.05)
                : Colors.white,
            borderRadius: BorderRadius.horizontal(
              left: index == 0 ? Radius.circular(8.r) : Radius.zero,
              right: index == 2 ? Radius.circular(8.r) : Radius.zero,
            ),
            border: Border.all(
              color: isSelected ? AppColor.primary : Colors.grey.shade200,
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? AppColor.primary : Colors.grey.shade400,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                fontSize: 14.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionCard(dynamic withdrawData) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(AppRouteNames.transactionDetails);
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColor.primary.withValues(alpha: 0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Withdrawal #${withdrawData?.id ?? 'N/A'}',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                12.horizontalSpace,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColor.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    withdrawData?.status ?? 'Pending',
                    style: TextStyle(
                      color: AppColor.primary,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            16.verticalSpace,
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black,
                  fontFamily: 'Inter',
                ),
                children: [
                  TextSpan(
                    text: 'Amount: ',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  TextSpan(
                    text: '\$${withdrawData?.amount?.toString() ?? '0.00'}',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            8.verticalSpace,
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black,
                  fontFamily: 'Inter',
                ),
                children: [
                  TextSpan(
                    text: 'Date: ',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  TextSpan(
                    text: withdrawData?.createdAt != null
                        ? '${withdrawData.createdAt.day}/${withdrawData.createdAt.month}/${withdrawData.createdAt.year}'
                        : 'N/A',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            16.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildIconText(Icons.account_balance_wallet, 'Wallet'),
                _buildIconText(
                  Icons.access_time,
                  withdrawData?.createdAt != null
                      ? '${withdrawData.createdAt.hour}:${withdrawData.createdAt.minute.toString().padLeft(2, '0')}'
                      : 'N/A',
                ),
                _buildIconText(
                  Icons.attach_money,
                  '\$${withdrawData?.amount?.toString() ?? '0.00'}',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18.sp, color: Colors.grey.shade700),
        4.horizontalSpace,
        Text(
          text,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
