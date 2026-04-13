import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:partsrunner/core/constant/app_color.dart';
import 'package:partsrunner/core/routes/app_route_names.dart';
import 'package:partsrunner/core/widget/customButton.dart';
import 'package:partsrunner/features/request_delivery/presentation/providers/request_delivery_provider.dart';
import 'package:partsrunner/features/request_delivery/presentation/widgets/request_header.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  @override
  // void dispose() {
  //   // Invalidating the notifier triggers RequestDeliveryNotifier.dispose(),
  //   // which resets all form controllers and state providers.
  //   ref.invalidate(requestDeliveryNotifierProvider);
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final deliveryState = ref.watch(requestDeliveryNotifierProvider);

    ref.listen<RequestDeliveryState>(requestDeliveryNotifierProvider, (
      previous,
      next,
    ) {
      if (next is RequestDeliverySuccess) {
        _showSuccessBottomSheet(context);
      } else if (next is RequestDeliveryError) {
        _showErrorSnackBar(context, next.message);
      }
    });

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Checkout',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RequestHeader(title: 'Package Details'),
            _buildDetailColumn(
              'From',
              "${ref.read(supplierProvider)?.location}, ${ref.read(supplierProvider)?.street}, ${ref.read(supplierProvider)?.city}, ${ref.read(supplierProvider)?.zipCode}",
            ),
            const SizedBox(height: 16),
            _buildDetailColumn(
              'To',
              ref.read(deliveryAddressControllerProvider).text,
            ),
            const SizedBox(height: 16),
            _buildDetailColumn(
              'Package Weight',
              '${ref.read(packageWeightControllerProvider).text} KG',
            ),
            const SizedBox(height: 24),
            Divider(color: Colors.grey[300]),
            const SizedBox(height: 16),

            RequestHeader(title: 'Price Details'),
            const SizedBox(height: 16),
            _buildPriceRow('1 X Package', '\$180.00'),
            const SizedBox(height: 8),
            _buildPriceRow('Tax', '\$1.00'),
            const SizedBox(height: 16),
            Divider(color: Colors.grey[300]),
            const SizedBox(height: 16),
            _buildTotalRow(
              'Total Price',
              '\$178.00',
            ), // Kept as $178.00 per the UI mockup
            const SizedBox(height: 24),

            RequestHeader(title: 'Payment Method'),
            const SizedBox(height: 16),
            _buildPaymentOption(
              index: 0,
              title: '****_****_****_1234',
              subtitle: 'Expired on 12/25',
              icon: Icons.credit_card,
              iconColor: Colors.blue,
            ),
            const SizedBox(height: 12),
            _buildPaymentOption(
              index: 1,
              title: 'Card',
              icon: Icons.credit_card_outlined,
              iconColor: Colors.deepOrange,
              // onTap: () => _showAddNewCardBottomSheet(context),
            ),
            const SizedBox(height: 12),
            _buildPaymentOption(
              index: 2,
              title: 'Paypal',
              icon: Icons.paypal,
              iconColor: Colors.blue[800],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: CustomButton(
            text: "Pay Now",
            textColor: AppColor.white,
            backgroundColor: AppColor.primary,
            submit: (deliveryState is RequestDeliveryLoading)
                ? null
                : () => _submitDeliveryRequest(context),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
      ],
    );
  }

  Widget _buildPriceRow(String label, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
        Text(
          price,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildTotalRow(String label, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          price,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentOption({
    required int index,
    required String title,
    String? subtitle,
    required IconData icon,
    Color? iconColor,
    VoidCallback? onTap,
  }) {
    bool isSelected = index == ref.watch(paymentMethodProvider);
    return GestureDetector(
      onTap: () {
        ref.read(paymentMethodProvider.notifier).state = index;
        if (onTap != null) onTap();
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.deepOrange.withValues(alpha: 0.05)
              : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.deepOrange : Colors.grey[300]!,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ],
              ),
            ),
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: isSelected ? Colors.deepOrange : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  // void _showAddNewCardBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     backgroundColor: Colors.white,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
  //     ),
  //     builder: (context) {
  //       return Padding(
  //         padding: EdgeInsets.only(
  //           bottom: MediaQuery.of(context).viewInsets.bottom,
  //           left: 20,
  //           right: 20,
  //           top: 20,
  //         ),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Center(
  //               child: Container(
  //                 width: 40,
  //                 height: 4,
  //                 decoration: BoxDecoration(
  //                   color: Colors.grey[300],
  //                   borderRadius: BorderRadius.circular(10),
  //                 ),
  //               ),
  //             ),
  //             const SizedBox(height: 20),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 const Text(
  //                   'Add New Card',
  //                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //                 ),
  //                 TextButton(
  //                   onPressed: () => Navigator.pop(context),
  //                   child: const Text(
  //                     'Cancel',
  //                     style: TextStyle(
  //                       color: Colors.deepOrange,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             Divider(color: Colors.grey[300]),
  //             const SizedBox(height: 16),

  //             const Text(
  //               'Card Number',
  //               style: TextStyle(fontWeight: FontWeight.w600),
  //             ),
  //             const SizedBox(height: 8),
  //             _buildTextField('6718 XX78 8910 798X'),
  //             const SizedBox(height: 16),

  //             const Text(
  //               'Card Holder Name',
  //               style: TextStyle(fontWeight: FontWeight.w600),
  //             ),
  //             const SizedBox(height: 8),
  //             _buildTextField('John Smith'),
  //             const SizedBox(height: 16),

  //             Row(
  //               children: [
  //                 Expanded(
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       const Text(
  //                         'Expiry Date',
  //                         style: TextStyle(fontWeight: FontWeight.w600),
  //                       ),
  //                       const SizedBox(height: 8),
  //                       _buildTextField('10/2030'),
  //                     ],
  //                   ),
  //                 ),
  //                 const SizedBox(width: 16),
  //                 Expanded(
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       const Text(
  //                         'CVV',
  //                         style: TextStyle(fontWeight: FontWeight.w600),
  //                       ),
  //                       const SizedBox(height: 8),
  //                       _buildTextField('•••', obscureText: true),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             const SizedBox(height: 24),
  //             SizedBox(
  //               width: double.infinity,
  //               child: ElevatedButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 style: ElevatedButton.styleFrom(
  //                   backgroundColor: Colors.deepOrange,
  //                   padding: const EdgeInsets.symmetric(vertical: 16),
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(8),
  //                   ),
  //                 ),
  //                 child: const Text(
  //                   'Confirm',
  //                   style: TextStyle(
  //                     fontSize: 16,
  //                     fontWeight: FontWeight.bold,
  //                     color: Colors.white,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             const SizedBox(height: 20),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  void _submitDeliveryRequest(BuildContext context) {
    ref
        .read(requestDeliveryNotifierProvider.notifier)
        .submitDeliveryRequest(context);
  }

  void _showSuccessBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Icon(Icons.inventory_2, size: 100, color: Colors.brown[300]),
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Request for Delivery created\nsuccessfully',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'Use the tracking ID below to follow your delivery\nin real time.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    _buildTrackingDetailRow('Tracking ID:', 'SND-23901823'),
                    const SizedBox(height: 8),
                    _buildTrackingDetailRow(
                      'From:',
                      "${ref.read(supplierProvider)?.location}, ${ref.read(supplierProvider)?.street}, ${ref.read(supplierProvider)?.city}, ${ref.read(supplierProvider)?.zipCode}",
                    ),
                    const SizedBox(height: 8),
                    _buildTrackingDetailRow(
                      'Send to:',
                      ref.read(deliveryAddressControllerProvider).text,
                    ),
                    const SizedBox(height: 8),
                    _buildTrackingDetailRow('Pickup method:', 'Runner Pickup'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    context.goNamed(AppRouteNames.bottomNav);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Track Package',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

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

  // Widget _buildTextField(String hintText, {bool obscureText = false}) {
  //   return TextField(
  //     obscureText: obscureText,
  //     decoration: InputDecoration(
  //       hintText: hintText,
  //       hintStyle: const TextStyle(color: Colors.black54),
  //       contentPadding: const EdgeInsets.symmetric(
  //         horizontal: 16,
  //         vertical: 14,
  //       ),
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(8),
  //         borderSide: BorderSide(color: Colors.grey[200]!),
  //       ),
  //       enabledBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(8),
  //         borderSide: BorderSide(color: Colors.grey[300]!),
  //       ),
  //       focusedBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(8),
  //         borderSide: const BorderSide(color: Colors.deepOrange),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildTrackingDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
        ),
      ],
    );
  }
}
