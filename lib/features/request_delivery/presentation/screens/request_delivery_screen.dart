import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:partsrunner/core/constant/app_color.dart';
import 'package:partsrunner/core/routes/app_route_names.dart';
import 'package:partsrunner/core/widget/customButton.dart';
import 'package:partsrunner/features/request_delivery/presentation/providers/request_delivery_provider.dart';
import 'package:partsrunner/features/request_delivery/presentation/widgets/Step_two.dart';
import 'package:partsrunner/features/request_delivery/presentation/widgets/step_one.dart';

class RequestDeliveryScreen extends ConsumerStatefulWidget {
  const RequestDeliveryScreen({super.key});

  @override
  ConsumerState<RequestDeliveryScreen> createState() =>
      _RequestDeliveryScreenState();
}

class _RequestDeliveryScreenState extends ConsumerState<RequestDeliveryScreen> {
  final List<String> supplyhouseName = [];

  @override
  void initState() {
    super.initState();
    // Load suppliers when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(requestDeliveryNotifierProvider.notifier).getSuppliers();
    });
  }

  void submit() {
    context.pushNamed(AppRouteNames.checkout);
  }

  @override
  Widget build(BuildContext context) {
    final isStepTwo = ref.watch(isStepTwoProvider);

    ref.listen<RequestDeliveryState>(requestDeliveryNotifierProvider, (
      previous,
      next,
    ) {
      if (next is RequestDeliveryError) {
        _showErrorSnackBar(context, next.message);
      }
    });

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
          onPressed: () {
            if (isStepTwo) {
              ref.read(isStepTwoProvider.notifier).state = false;
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: Text(
          'Request New Delivery',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: isStepTwo ? const StepTwo() : const StepOne(),
            ),
          ),
          CustomButton(
            margin: EdgeInsets.all(20.h),
            backgroundColor: AppColor.primary,
            textColor: AppColor.white,
            text: isStepTwo ? 'Checkout' : 'Next',
            submit: () {
              if (!isStepTwo) {
                ref.read(isStepTwoProvider.notifier).state = true;
              } else {
                submit();
                // context.goNamed(AppRouteNames.checkout);
              }
            },
          ),
          // _buildBottomButton(),
        ],
      ),
    );
  }

  // --- Error SnackBar ---
  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
