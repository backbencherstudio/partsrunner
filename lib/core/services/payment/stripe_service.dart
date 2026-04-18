import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  StripeService._privateConstructor();
  static final StripeService instance = StripeService._privateConstructor();

  Future<void> initialize(String publishableKey) async {
    Stripe.publishableKey = publishableKey;
    await Stripe.instance.applySettings();
  }

  Future<bool> processPayment({
    required BuildContext context,
    required String clientSecret,
    String merchantName = 'PartRunner',
  }) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: merchantName,
          style: ThemeMode.system,
        ),
      );

      final result = await Stripe.instance.presentPaymentSheet(
        options: PaymentSheetPresentOptions(
          
        )
      );
      print(result);
      debugPrint("Payment Successfully Completed!");
      return true;
    } on StripeException catch (e) {
      debugPrint("Stripe Error: ${e.error.localizedMessage}");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Payment Failed: ${e.error.localizedMessage}'),
          ),
        );
      }
      return false;
    } catch (e) {
      debugPrint("General Payment Error: $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An unexpected error occurred.')),
        );
      }
      return false;
    }
  }
}
