import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:partsrunner/core/constant/app_color.dart';
import 'package:partsrunner/core/routes/app_route_names.dart';
import 'package:partsrunner/core/widget/customButton.dart';
import 'package:partsrunner/core/widget/custom_dropdown.dart';
import 'package:partsrunner/core/widget/custom_text_fIeld.dart';
import 'package:partsrunner/features/request_delivery/presentation/providers/request_delivery_provider.dart';
import 'package:partsrunner/features/request_delivery/domain/entities/supplier_entity.dart';

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

  @override
  Widget build(BuildContext context) {
    final isStepTwo = ref.watch(isStepTwoProvider);
    final suppliers = ref.watch(suppliersProvider);
    final suppliersLoading = ref.watch(suppliersLoadingProvider);
    final suppliersError = ref.watch(suppliersErrorProvider);
    final isFormValid = ref.watch(isFormValidProvider);

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
        title: const Text(
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
              child: isStepTwo
                  ? _buildStepTwo()
                  : _buildStepOne(suppliers, suppliersLoading, suppliersError),
            ),
          ),
          CustomButton(
            margin: EdgeInsets.all(20.h),
            backgroundColor: isFormValid ? AppColor.primary : Colors.grey,
            textColor: AppColor.white,
            text: isStepTwo ? 'Checkout' : 'Next',
            submit: () {
              if (!isStepTwo) {
                ref.read(isStepTwoProvider.notifier).state = true;
              } else {
                context.pushNamed(AppRouteNames.checkout);
              }
            },
          ),
          // _buildBottomButton(),
        ],
      ),
    );
  }

  // --- Step 1: Package & Sender Info ---
  Widget _buildStepOne(
    List<SupplierEntity>? suppliers,
    bool suppliersLoading,
    String? suppliersError,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Package Info'),
        CustomTextField(hintText: 'Enter package name', label: 'Package Name'),
        CustomTextField(hintText: 'eg. 2.5', label: 'Weight'),

        const SizedBox(height: 24),

        _buildSectionHeader('Sender'),
        _buildSupplierDropdown(suppliers, suppliersLoading, suppliersError),
        _buildSenderTextField(
          hintText: 'Enter counter person name',
          label: 'Counter Person Name',
          key: 'name',
        ),
        _buildSenderTextField(
          hintText: 'Jan 11, 2025',
          label: 'Pickup Date',
          key: 'pickupDate',
          suffix: Icons.calendar_today_outlined,
        ),
        _buildSenderTextField(
          hintText: '10:15 AM',
          label: 'Pickup Time',
          key: 'pickupTime',
          suffix: Icons.access_time,
        ),
      ],
    );
  }

  // --- Step 2: Receiver Info ---
  Widget _buildStepTwo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Receiver'),
        _buildReceiverTextField(
          label: 'Technician Name',
          hint: 'Enter technician name',
          key: 'name',
        ),
        _buildReceiverTextField(
          label: 'Phone Number',
          hint: 'Enter phone number',
          key: 'phone',
          keyboardType: TextInputType.phone,
        ),
        _buildReceiverTextField(
          label: 'Delivery Address',
          hint: 'Enter delivery address',
          key: 'address',
        ),

        const SizedBox(height: 24),

        _buildSectionHeader('Special Instructions'),
        _buildSpecialInstructionsField(),
      ],
    );
  }

  // --- Helper Widget for Section Headers ---
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  // --- Package Text Fields ---
  Widget _buildPackageTextField({
    required String hintText,
    required String label,
    required String key,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            keyboardType: keyboardType,
            onChanged: (value) {
              ref
                  .read(requestDeliveryNotifierProvider.notifier)
                  .updatePackageInfo(key, value);
            },
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
              filled: true,
              fillColor: Colors.grey.shade50,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: Color(0xFFFF4500)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Sender Text Fields ---
  Widget _buildSenderTextField({
    required String hintText,
    required String label,
    required String key,
    IconData? suffix,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            keyboardType: keyboardType,
            onChanged: (value) {
              ref
                  .read(requestDeliveryNotifierProvider.notifier)
                  .updateSenderInfo(key, value);
            },
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
              filled: true,
              fillColor: Colors.grey.shade50,
              suffixIcon: suffix != null
                  ? Icon(suffix, color: Colors.grey.shade700, size: 20)
                  : null,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: Color(0xFFFF4500)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Receiver Text Fields ---
  Widget _buildReceiverTextField({
    required String label,
    required String hint,
    required String key,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            keyboardType: keyboardType,
            onChanged: (value) {
              ref
                  .read(requestDeliveryNotifierProvider.notifier)
                  .updateReceiverInfo(key, value);
            },
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
              filled: true,
              fillColor: Colors.grey.shade50,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: Color(0xFFFF4500)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Special Instructions Field ---
  Widget _buildSpecialInstructionsField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        maxLines: 4,
        maxLength: 200,
        onChanged: (value) {
          ref
              .read(requestDeliveryNotifierProvider.notifier)
              .updateSpecialInstructions(value);
        },
        decoration: InputDecoration(
          hintText: 'Any special instructions for the runner...',
          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
          filled: true,
          fillColor: Colors.grey.shade50,
          counterText: "",
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Color(0xFFFF4500)),
          ),
        ),
      ),
    );
  }

  // --- Supplier Dropdown ---
  Widget _buildSupplierDropdown(
    List<SupplierEntity>? suppliers,
    bool isLoading,
    String? error,
  ) {
    if (isLoading) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.grey.shade600,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Loading suppliers...',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              ),
            ],
          ),
        ),
      );
    }

    if (error != null) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.red.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.error_outline, color: Colors.red.shade600, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Failed to load suppliers',
                  style: TextStyle(color: Colors.red.shade600, fontSize: 14),
                ),
              ),
              IconButton(
                icon: Icon(Icons.refresh, color: Colors.red.shade600, size: 20),
                onPressed: () {
                  ref
                      .read(requestDeliveryNotifierProvider.notifier)
                      .getSuppliers();
                },
              ),
            ],
          ),
        ),
      );
    }

    if (suppliers == null || suppliers.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Text(
            'No suppliers available',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Supply House',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            hint: const Text('Select supply house'),
            items: suppliers.map((supplier) {
              return DropdownMenuItem<String>(
                value: supplier.id,
                child: Text(supplier.name),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                ref
                    .read(requestDeliveryNotifierProvider.notifier)
                    .updatePackageInfo('supplierId', value);
              }
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade50,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: Color(0xFFFF4500)),
              ),
            ),
          ),
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
