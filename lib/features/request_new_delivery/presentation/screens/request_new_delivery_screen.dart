import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:partsrunner/core/routes/app_route_names.dart';

class RequestNewDeliveryScreen extends StatefulWidget {
  const RequestNewDeliveryScreen({super.key});

  @override
  State<RequestNewDeliveryScreen> createState() =>
      _RequestNewDeliveryScreenState();
}

class _RequestNewDeliveryScreenState extends State<RequestNewDeliveryScreen> {
  bool _isStepTwo = false;

  @override
  Widget build(BuildContext context) {
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
            if (_isStepTwo) {
              setState(() => _isStepTwo = false);
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
              child: _isStepTwo ? _buildStepTwo() : _buildStepOne(),
            ),
          ),
          _buildBottomButton(),
        ],
      ),
    );
  }

  // --- Step 1: Package & Sender Info ---
  Widget _buildStepOne() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Package Info'),
        _buildInputField(label: 'Package Name', hint: 'Enter package name'),
        _buildInputField(
          label: 'Weight',
          hint: 'e.g. 2.5',
          trailingIcon: Icons.keyboard_arrow_down,
        ),

        const SizedBox(height: 24),

        _buildSectionHeader('Sender'),
        _buildInputField(
          label: 'Supply House Name',
          hint: 'Enter supply house name',
          trailingIcon: Icons.keyboard_arrow_down,
        ),
        _buildInputField(
          label: 'Supply House Address',
          hint: 'Enter supply house address',
        ),
        _buildInputField(
          label: 'Counter Person Name',
          hint: 'Enter counter person name',
        ),
        _buildInputField(
          label: 'Pickup Date',
          hint: 'Jan 11, 2025',
          trailingIcon: Icons.calendar_today_outlined,
        ),
        _buildInputField(
          label: 'Pickup Time',
          hint: '10:15 AM',
          trailingIcon: Icons.access_time,
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
        _buildInputField(
          label: 'Technician Name',
          hint: 'Enter technician name',
        ),
        _buildInputField(label: 'Phone Number', hint: 'Enter phone number'),
        _buildInputField(
          label: 'Delivery Address',
          hint: 'Enter delivery address',
        ),

        const SizedBox(height: 24),

        _buildSectionHeader('Special Instructions'),
        _buildInputField(
          label: '',
          hint: 'Any special instructions for the runner...',
          maxLines: 4,
          maxLength: 200,
          showLabel: false,
        ),
      ],
    );
  }

  // --- Bottom Button ---
  Widget _buildBottomButton() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      color: Colors.white,
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            if (!_isStepTwo) {
              setState(() => _isStepTwo = true);
            } else {
              context.pushNamed(AppRouteNames.checkout);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF4500), // Orange Red Color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            elevation: 0,
          ),
          child: Text(
            _isStepTwo ? 'Checkout' : 'Next',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
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

  // --- Helper Widget for Text Fields ---
  Widget _buildInputField({
    required String label,
    required String hint,
    IconData? trailingIcon,
    int maxLines = 1,
    int? maxLength,
    bool showLabel = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showLabel) ...[
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
          ],
          TextField(
            maxLines: maxLines,
            maxLength: maxLength,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
              filled: true,
              fillColor: Colors.grey.shade50,
              counterText: maxLength != null
                  ? null
                  : "", // Default counter behavior if maxLength is given
              suffixIcon: trailingIcon != null
                  ? Icon(trailingIcon, color: Colors.grey.shade700, size: 20)
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
}
