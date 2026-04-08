import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partsrunner/core/widget/custom_text_fIeld.dart';
import 'package:partsrunner/features/request_delivery/presentation/providers/request_delivery_provider.dart';
import 'package:partsrunner/features/request_delivery/presentation/widgets/section_header.dart';

class StepTwo extends ConsumerWidget {
  const StepTwo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RequestInputHeader(title: 'Receiver'),
        CustomTextField(
          hintText: 'Enter technician name',
          label: 'Technician Name',
          controller: ref.read(technicianNameControllerProvider),
        ),
        CustomTextField(
          hintText: 'Phone Number',
          label: 'Enter phone number',
          controller: ref.read(technicianPhoneControllerProvider),
        ),
        CustomTextField(
          hintText: 'Enter delivery address',
          label: 'Delivery Address',
          controller: ref.read(deliveryAddressControllerProvider),
        ),

        const SizedBox(height: 24),

        RequestInputHeader(title: 'Special Instructions'),
        _buildSpecialInstructionsField(ref),
      ],
    );
  }

  // --- Special Instructions Field ---
  Widget _buildSpecialInstructionsField(WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        maxLines: 4,
        maxLength: 200,
        controller: ref.read(specialInstructionsControllerProvider),
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
}
