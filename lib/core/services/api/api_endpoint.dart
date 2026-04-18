import 'package:partsrunner/core/constant/app_constant.dart';

class ApiEndpoints {
  ApiEndpoints._();
  // ─────────────────────────────────────────
  // AUTH
  // ─────────────────────────────────────────
  static String get register => '${AppConstant.baseUrl}/api/auth/register';
  static String get verifyEmail => '${AppConstant.baseUrl}/api/auth/verify-email';
  static String get contractorCreate =>
      '${AppConstant.baseUrl}/api/auth/contractor/create'; // 🔒
  static String get runnerCreate => '${AppConstant.baseUrl}/api/auth/runner/create'; // 🔒
  static String get login => '${AppConstant.baseUrl}/api/auth/login';
  static String get me => '${AppConstant.baseUrl}/api/auth/me'; // 🔒 GET
  static String get updateUser => '${AppConstant.baseUrl}/api/auth/update'; // 🔒 PATCH
  static String get forgotPassword => '${AppConstant.baseUrl}/api/auth/forgot-password';
  static String get resendVerificationEmail =>
      '${AppConstant.baseUrl}/api/auth/resend-verification-email';
  static String get resetPassword => '${AppConstant.baseUrl}/api/auth/reset-password';
  static String get changePassword => '${AppConstant.baseUrl}/api/auth/change-password'; // 🔒
  static String get requestEmailChange =>
      '${AppConstant.baseUrl}/api/auth/request-email-change'; // 🔒
  static String get changeEmail => '${AppConstant.baseUrl}/api/auth/change-email'; // 🔒

  // ─────────────────────────────────────────
  // DEVICE TOKEN 🔒
  // ─────────────────────────────────────────
  static String get deviceTokenRegister => '${AppConstant.baseUrl}/api/device-tokens'; // POST
  static String get deviceTokenDelete => '${AppConstant.baseUrl}/api/device-tokens'; // DELETE
  static String get deviceTokenMe => '${AppConstant.baseUrl}/api/device-tokens/me'; // GET

  // ─────────────────────────────────────────
  // CONTRACTOR DELIVERY 🔒
  // ─────────────────────────────────────────
  static String get contractorDeliveries =>
      '${AppConstant.baseUrl}/api/contractor/deliveries'; // POST, GET
  static String get contractorActiveTracking =>
      '${AppConstant.baseUrl}/api/contractor/deliveries/active-tracking';
  static String get contractorSuppliers => '${AppConstant.baseUrl}/api/contractor/suppliers';
  static String get contractorDeliveriesHome =>
      '${AppConstant.baseUrl}/api/contractor/deliveries/home';
  static String get contractorDeliveriesCurrentShipping =>
      '${AppConstant.baseUrl}/api/contractor/deliveries/current-shipping';
  static String get contractorDeliveriesRecentShipping =>
      '${AppConstant.baseUrl}/api/contractor/deliveries/recent-shipping';
  static String get contractorDeliveriesOngoing =>
      '${AppConstant.baseUrl}/api/contractor/deliveries/ongoing-deliveries';
  static String get contractorDeliveriesCompleted =>
      '${AppConstant.baseUrl}/api/contractor/deliveries/completed-deliveries';

  /// GET, PATCH, DELETE
  static String contractorDeliveryById(String id) =>
      '${AppConstant.baseUrl}/api/contractor/deliveries/$id';

  // ─────────────────────────────────────────
  // RUNNER AVAILABILITY 🔒
  // ─────────────────────────────────────────
  static String get runnerGoOnline =>
      '${AppConstant.baseUrl}/api/runner/availability/go-online';
  static String get runnerGoOffline =>
      '${AppConstant.baseUrl}/api/runner/availability/go-offline';
  static String get runnerUpdateLocation =>
      '${AppConstant.baseUrl}/api/runner/availability/update-location';

  // ─────────────────────────────────────────
  // RUNNER DELIVERY 🔒
  // ─────────────────────────────────────────
  static String get runnerDeliveries => '${AppConstant.baseUrl}/api/delivery';
  static String get runnerOngoingDeliveries =>
      '${AppConstant.baseUrl}/api/delivery/ongoing-deliveries';
  static String get runnerCompletedDeliveries =>
      '${AppConstant.baseUrl}/api/delivery/completed-deliveries';
  static String get runnerCanceledDeliveries =>
      '${AppConstant.baseUrl}/api/delivery/cancelled-deliveries';
  static String get runnerDeliveryNewRequests =>
      '${AppConstant.baseUrl}/api/delivery/new-requests';
  static String get runnerDeliveryHome => '${AppConstant.baseUrl}/api/delivery/home';
  static String runnerDeliveryById(String id) => '${AppConstant.baseUrl}/api/delivery/$id';
  static String get runnerAcceptOffer => '${AppConstant.baseUrl}/api/delivery/accept-offer';
  static String get runnerRejectOffer => '${AppConstant.baseUrl}/api/delivery/reject-offer';
  static String get runnerUpdateDeliveryStatus =>
      '${AppConstant.baseUrl}/api/delivery/update-status';
  static String get runnerLiveLocation => '${AppConstant.baseUrl}/api/delivery/live-location';

  // ─────────────────────────────────────────
  // RUNNER STRIPE CONNECT 🔒
  // ─────────────────────────────────────────
  static String get runnerStripeConnectAccount =>
      '${AppConstant.baseUrl}/api/runner/stripe-connect/connect-account';
  static String get runnerStripeOnboardingLink =>
      '${AppConstant.baseUrl}/api/runner/stripe-connect/onboarding-link';
  static String get runnerStripeConnectStatus =>
      '${AppConstant.baseUrl}/api/runner/stripe-connect/status';

  // ─────────────────────────────────────────
  // RUNNER WITHDRAWAL 🔒
  // ─────────────────────────────────────────
  static String get runnerWithdrawalRequest =>
      '${AppConstant.baseUrl}/api/runner/withdrawal/request';
  static String get runnerWithdrawalHistory =>
      '${AppConstant.baseUrl}/api/runner/withdrawal/history';
  static String get runnerWalletSummary =>
      '${AppConstant.baseUrl}/api/runner/withdrawal/wallet-summary';
  static String get runnerEarningsOverview =>
      '${AppConstant.baseUrl}/api/runner/withdrawal/earnings-overview';

  // ─────────────────────────────────────────
  // PAYMENT
  // ─────────────────────────────────────────
  static String get stripeWebhook => '${AppConstant.baseUrl}/api/payment/stripe/webhook';
  static String get paypalSuccess => '${AppConstant.baseUrl}/api/payment/paypal/success';
  static String get paypalCancel => '${AppConstant.baseUrl}/api/payment/paypal/cancel';
  static String get paypalWebhook => '${AppConstant.baseUrl}/api/payment/paypal/webhook';

  // ─────────────────────────────────────────
  // ADMIN — Payment Transaction 🔒
  // ─────────────────────────────────────────
  static String get adminPaymentTransactions =>
      '${AppConstant.baseUrl}/api/admin/payment-transaction';
  static String adminPaymentTransactionById(String id) =>
      '${AppConstant.baseUrl}/api/admin/payment-transaction/$id'; // GET, DELETE

  // ─────────────────────────────────────────
  // ADMIN — User 🔒
  // ─────────────────────────────────────────
  static String get adminUsers => '${AppConstant.baseUrl}/api/admin/user'; // POST, GET
  static String adminUserById(String id) =>
      '${AppConstant.baseUrl}/api/admin/user/$id'; // GET, PATCH, DELETE
  static String adminApproveUser(String id) =>
      '${AppConstant.baseUrl}/api/admin/user/$id/approve';
  static String adminRejectUser(String id) =>
      '${AppConstant.baseUrl}/api/admin/user/$id/reject';

  // ─────────────────────────────────────────
  // ADMIN — Notification 🔒
  // ─────────────────────────────────────────
  static String get adminNotifications =>
      '${AppConstant.baseUrl}/api/admin/notification'; // GET, DELETE
  static String adminDeleteNotification(String id) =>
      '${AppConstant.baseUrl}/api/admin/notification/$id';

  // ─────────────────────────────────────────
  // ADMIN — Delivery Fee Config 🔒
  // ─────────────────────────────────────────
  static String get adminDeliveryFeeConfig =>
      '${AppConstant.baseUrl}/api/admin/delivery-fee-config'; // GET, PUT

  // ─────────────────────────────────────────
  // ADMIN — Contractor 🔒
  // ─────────────────────────────────────────
  static String get adminContractors => '${AppConstant.baseUrl}/api/admin/contractor';
  static String adminContractorById(String id) =>
      '${AppConstant.baseUrl}/api/admin/contractor/$id';
  static String adminSuspendContractor(String id) =>
      '${AppConstant.baseUrl}/api/admin/contractor/$id/suspend';
  static String adminActivateContractor(String id) =>
      '${AppConstant.baseUrl}/api/admin/contractor/$id/active';

  // ─────────────────────────────────────────
  // ADMIN — Runner 🔒
  // ─────────────────────────────────────────
  static String get adminRunners => '${AppConstant.baseUrl}/api/admin/runner';
  static String adminRunnerById(String id) => '${AppConstant.baseUrl}/api/admin/runner/$id';
  static String adminSuspendRunner(String id) =>
      '${AppConstant.baseUrl}/api/admin/runner/$id/suspend';
  static String adminActivateRunner(String id) =>
      '${AppConstant.baseUrl}/api/admin/runner/$id/active';

  // ─────────────────────────────────────────
  // ADMIN — Supplier 🔒
  // ─────────────────────────────────────────
  static String get adminSuppliers =>
      '${AppConstant.baseUrl}/api/admin/supplier'; // POST, GET
  static String adminSupplierById(String id) =>
      '${AppConstant.baseUrl}/api/admin/supplier/$id'; // GET, PATCH, DELETE

  // ─────────────────────────────────────────
  // ADMIN — Order 🔒
  // ─────────────────────────────────────────
  static String get adminOrders => '${AppConstant.baseUrl}/api/admin/order';
  static String adminOrderById(String id) => '${AppConstant.baseUrl}/api/admin/order/$id';

  // ─────────────────────────────────────────
  // ADMIN — Dashboard 🔒
  // ─────────────────────────────────────────
  static String get adminDashboard => '${AppConstant.baseUrl}/api/admin/dashboard';

  // ─────────────────────────────────────────
  // ADMIN — Withdrawal 🔒
  // ─────────────────────────────────────────
  static String get adminWithdrawals => '${AppConstant.baseUrl}/api/admin/withdrawal';
  static String adminApproveWithdrawal(String id) =>
      '${AppConstant.baseUrl}/api/admin/withdrawal/$id/approve';
  static String adminRejectWithdrawal(String id) =>
      '${AppConstant.baseUrl}/api/admin/withdrawal/$id/reject';
}
