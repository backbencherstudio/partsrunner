import 'package:flutter_dotenv/flutter_dotenv.dart';

/// API Endpoints for Dan Weimer App
/// Uses flutter_dotenv to load BASE_URL from .env file
///
/// Setup:
/// 1. Add to pubspec.yaml:
///      dependencies:
///        flutter_dotenv: ^5.2.1
///
///    flutter:
///      assets:
///        - .env
///
/// 2. In main.dart before runApp():
///      await dotenv.load(fileName: '.env');
///
/// 🔒 = Requires Authentication (Bearer Token)

class ApiEndpoints {
  ApiEndpoints._();

  // ─────────────────────────────────────────
  // BASE URL (loaded from .env)
  // ─────────────────────────────────────────
  static String get baseUrl =>
      dotenv.env['BASE_URL'] ?? 'https://danweimer.pixelstack.cloud';

  // ─────────────────────────────────────────
  // AUTH
  // ─────────────────────────────────────────
  static String get register => '$baseUrl/api/auth/register';
  static String get verifyEmail => '$baseUrl/api/auth/verify-email';
  static String get contractorCreate =>
      '$baseUrl/api/auth/contractor/create'; // 🔒
  static String get runnerCreate => '$baseUrl/api/auth/runner/create'; // 🔒
  static String get login => '$baseUrl/api/auth/login';
  static String get me => '$baseUrl/api/auth/me'; // 🔒 GET
  static String get updateUser => '$baseUrl/api/auth/update'; // 🔒 PATCH
  static String get forgotPassword => '$baseUrl/api/auth/forgot-password';
  static String get resendVerificationEmail =>
      '$baseUrl/api/auth/resend-verification-email';
  static String get resetPassword => '$baseUrl/api/auth/reset-password';
  static String get changePassword =>
      '$baseUrl/api/auth/change-password'; // 🔒
  static String get requestEmailChange =>
      '$baseUrl/api/auth/request-email-change'; // 🔒
  static String get changeEmail => '$baseUrl/api/auth/change-email'; // 🔒

  // ─────────────────────────────────────────
  // DEVICE TOKEN 🔒
  // ─────────────────────────────────────────
  static String get deviceTokenRegister => '$baseUrl/api/device-tokens'; // POST
  static String get deviceTokenDelete => '$baseUrl/api/device-tokens'; // DELETE
  static String get deviceTokenMe => '$baseUrl/api/device-tokens/me'; // GET

  // ─────────────────────────────────────────
  // CONTRACTOR DELIVERY 🔒
  // ─────────────────────────────────────────
  static String get contractorDeliveries =>
      '$baseUrl/api/contractor/deliveries'; // POST, GET
  static String get contractorDeliveriesHome =>
      '$baseUrl/api/contractor/deliveries/home';
  static String get contractorDeliveriesCurrentShipping =>
      '$baseUrl/api/contractor/deliveries/current-shipping';
  static String get contractorDeliveriesRecentShipping =>
      '$baseUrl/api/contractor/deliveries/recent-shipping';

  /// GET, PATCH, DELETE
  static String contractorDeliveryById(String id) =>
      '$baseUrl/api/contractor/deliveries/$id';

  // ─────────────────────────────────────────
  // RUNNER AVAILABILITY 🔒
  // ─────────────────────────────────────────
  static String get runnerGoOnline =>
      '$baseUrl/api/runner/availability/go-online';
  static String get runnerGoOffline =>
      '$baseUrl/api/runner/availability/go-offline';
  static String get runnerUpdateLocation =>
      '$baseUrl/api/runner/availability/update-location';

  // ─────────────────────────────────────────
  // RUNNER DELIVERY 🔒
  // ─────────────────────────────────────────
  static String get runnerDeliveries => '$baseUrl/api/delivery';
  static String get runnerDeliveryNewRequests =>
      '$baseUrl/api/delivery/new-requests';
  static String get runnerDeliveryHome => '$baseUrl/api/delivery/home';
  static String runnerDeliveryById(String id) => '$baseUrl/api/delivery/$id';
  static String get runnerAcceptOffer => '$baseUrl/api/delivery/accept-offer';
  static String get runnerRejectOffer => '$baseUrl/api/delivery/reject-offer';
  static String get runnerUpdateDeliveryStatus =>
      '$baseUrl/api/delivery/update-status';
  static String get runnerLiveLocation => '$baseUrl/api/delivery/live-location';

  // ─────────────────────────────────────────
  // RUNNER STRIPE CONNECT 🔒
  // ─────────────────────────────────────────
  static String get runnerStripeConnectAccount =>
      '$baseUrl/api/runner/stripe-connect/connect-account';
  static String get runnerStripeOnboardingLink =>
      '$baseUrl/api/runner/stripe-connect/onboarding-link';
  static String get runnerStripeConnectStatus =>
      '$baseUrl/api/runner/stripe-connect/status';

  // ─────────────────────────────────────────
  // RUNNER WITHDRAWAL 🔒
  // ─────────────────────────────────────────
  static String get runnerWithdrawalRequest =>
      '$baseUrl/api/runner/withdrawal/request';
  static String get runnerWithdrawalHistory =>
      '$baseUrl/api/runner/withdrawal/history';
  static String get runnerWalletSummary =>
      '$baseUrl/api/runner/withdrawal/wallet-summary';
  static String get runnerEarningsOverview =>
      '$baseUrl/api/runner/withdrawal/earnings-overview';

  // ─────────────────────────────────────────
  // PAYMENT
  // ─────────────────────────────────────────
  static String get stripeWebhook => '$baseUrl/api/payment/stripe/webhook';
  static String get paypalSuccess => '$baseUrl/api/payment/paypal/success';
  static String get paypalCancel => '$baseUrl/api/payment/paypal/cancel';
  static String get paypalWebhook => '$baseUrl/api/payment/paypal/webhook';

  // ─────────────────────────────────────────
  // ADMIN — Payment Transaction 🔒
  // ─────────────────────────────────────────
  static String get adminPaymentTransactions =>
      '$baseUrl/api/admin/payment-transaction';
  static String adminPaymentTransactionById(String id) =>
      '$baseUrl/api/admin/payment-transaction/$id'; // GET, DELETE

  // ─────────────────────────────────────────
  // ADMIN — User 🔒
  // ─────────────────────────────────────────
  static String get adminUsers => '$baseUrl/api/admin/user'; // POST, GET
  static String adminUserById(String id) =>
      '$baseUrl/api/admin/user/$id'; // GET, PATCH, DELETE
  static String adminApproveUser(String id) =>
      '$baseUrl/api/admin/user/$id/approve';
  static String adminRejectUser(String id) =>
      '$baseUrl/api/admin/user/$id/reject';

  // ─────────────────────────────────────────
  // ADMIN — Notification 🔒
  // ─────────────────────────────────────────
  static String get adminNotifications =>
      '$baseUrl/api/admin/notification'; // GET, DELETE
  static String adminDeleteNotification(String id) =>
      '$baseUrl/api/admin/notification/$id';

  // ─────────────────────────────────────────
  // ADMIN — Delivery Fee Config 🔒
  // ─────────────────────────────────────────
  static String get adminDeliveryFeeConfig =>
      '$baseUrl/api/admin/delivery-fee-config'; // GET, PUT

  // ─────────────────────────────────────────
  // ADMIN — Contractor 🔒
  // ─────────────────────────────────────────
  static String get adminContractors => '$baseUrl/api/admin/contractor';
  static String adminContractorById(String id) =>
      '$baseUrl/api/admin/contractor/$id';
  static String adminSuspendContractor(String id) =>
      '$baseUrl/api/admin/contractor/$id/suspend';
  static String adminActivateContractor(String id) =>
      '$baseUrl/api/admin/contractor/$id/active';

  // ─────────────────────────────────────────
  // ADMIN — Runner 🔒
  // ─────────────────────────────────────────
  static String get adminRunners => '$baseUrl/api/admin/runner';
  static String adminRunnerById(String id) => '$baseUrl/api/admin/runner/$id';
  static String adminSuspendRunner(String id) =>
      '$baseUrl/api/admin/runner/$id/suspend';
  static String adminActivateRunner(String id) =>
      '$baseUrl/api/admin/runner/$id/active';

  // ─────────────────────────────────────────
  // ADMIN — Supplier 🔒
  // ─────────────────────────────────────────
  static String get adminSuppliers =>
      '$baseUrl/api/admin/supplier'; // POST, GET
  static String adminSupplierById(String id) =>
      '$baseUrl/api/admin/supplier/$id'; // GET, PATCH, DELETE

  // ─────────────────────────────────────────
  // ADMIN — Order 🔒
  // ─────────────────────────────────────────
  static String get adminOrders => '$baseUrl/api/admin/order';
  static String adminOrderById(String id) => '$baseUrl/api/admin/order/$id';

  // ─────────────────────────────────────────
  // ADMIN — Dashboard 🔒
  // ─────────────────────────────────────────
  static String get adminDashboard => '$baseUrl/api/admin/dashboard';

  // ─────────────────────────────────────────
  // ADMIN — Withdrawal 🔒
  // ─────────────────────────────────────────
  static String get adminWithdrawals => '$baseUrl/api/admin/withdrawal';
  static String adminApproveWithdrawal(String id) =>
      '$baseUrl/api/admin/withdrawal/$id/approve';
  static String adminRejectWithdrawal(String id) =>
      '$baseUrl/api/admin/withdrawal/$id/reject';
}