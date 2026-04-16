import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partsrunner/core/constant/app_color.dart';
import 'package:partsrunner/core/widget/customButton.dart';
import '../providers/wallet_provider.dart';

class WithdrawScreen extends ConsumerStatefulWidget {
  const WithdrawScreen({super.key});

  @override
  ConsumerState<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends ConsumerState<WithdrawScreen> {
  int _selectedOption = 0;
  final TextEditingController _customAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final walletSummaryAsync = ref.watch(walletSummaryProvider);
    final withdrawRequestAsync = ref.watch(withdrawRequestProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Withdraw Earnings',
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: walletSummaryAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
          data: (walletSummary) {
            final availableBalance = walletSummary.availableToWithdraw ?? 0.0;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Available To Withdraw Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 24.h),
                  decoration: BoxDecoration(
                    color: AppColor.primary.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: AppColor.primary.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Available To Withdraw',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      8.verticalSpace,
                      Text(
                        '\$${availableBalance.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      8.verticalSpace,
                      Text(
                        'Minimum withdrawal amount: \$20',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColor.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                24.verticalSpace,

                // Select Amount Section
                Text(
                  'Select Amount',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                16.verticalSpace,

                // Option 1
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedOption = 0;
                      _customAmountController.text = '';
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: _selectedOption == 0
                            ? AppColor.primary
                            : Colors.grey.shade200,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Withdraw Full Balance',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        4.verticalSpace,
                        Text(
                          '\$${availableBalance.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColor.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                12.verticalSpace,

                // Option 2
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedOption = 1;
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: _selectedOption == 1
                            ? AppColor.primary
                            : Colors.grey.shade200,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Enter Custom Amount',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        12.verticalSpace,
                        TextField(
                          controller: _customAmountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade50,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide.none,
                            ),
                            hintText: '\$ 0.00',
                            hintStyle: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey.shade600,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 12.h,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _selectedOption = 1;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                24.verticalSpace,

                // Choose Payout Method Section
                Text(
                  'Choose Payout Method',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                16.verticalSpace,

                // Payout Method Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColor.primary.withValues(alpha: 0.02),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppColor.primary),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Text(
                          'VISA',
                          style: TextStyle(
                            color: Colors.blue.shade800,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                      16.horizontalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '****_****_****_1234',
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          4.verticalSpace,
                          Text(
                            'Expired on 12/25',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                16.verticalSpace,

                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Add New Bank Account',
                    style: TextStyle(
                      color: AppColor.primary,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColor.primary,
                    ),
                  ),
                ),
                48.verticalSpace,

                withdrawRequestAsync.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => CustomButton(
                    text: 'Confirm Withdrawal',
                    textColor: Colors.white,
                    backgroundColor: AppColor.primary,
                    submit: () {},
                  ),
                  data: (_) => CustomButton(
                    text: 'Confirm Withdrawal',
                    textColor: _canWithdraw(availableBalance)
                        ? Colors.white
                        : Colors.grey.shade400,
                    backgroundColor: _canWithdraw(availableBalance)
                        ? AppColor.primary
                        : Colors.grey.shade100,
                    submit: _canWithdraw(availableBalance)
                        ? () {
                            final amount = _selectedOption == 0
                                ? availableBalance
                                : double.tryParse(
                                        _customAmountController.text,
                                      ) ??
                                      0.0;
                            ref
                                .read(withdrawRequestProvider.notifier)
                                .requestWithdraw(amount);
                          }
                        : () {},
                  ),
                ),
                24.verticalSpace,
              ],
            );
          },
        ),
      ),
    );
  }

  bool _canWithdraw(double availableBalance) {
    if (_selectedOption == 0) {
      return availableBalance >= 20;
    } else {
      final amount = double.tryParse(_customAmountController.text) ?? 0.0;
      return amount >= 20 && amount <= availableBalance;
    }
  }

  @override
  void dispose() {
    _customAmountController.dispose();
    super.dispose();
  }
}
