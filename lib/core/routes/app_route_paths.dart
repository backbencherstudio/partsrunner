class AppRoutePaths {
  // Core
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String message = '/message';
  static const String bottomNav = '/bottomNav';
  static const String search = '/search';
  static const String notification = '/notification';
  static const String liveTracking = '/liveTracking/:id';

  // Auth
  static const String auth = '/auth';
  static const String selectRole = '/auth/selectRole';
  static const String signup = '/auth/signup';
  static const String otp = '/auth/otp';
  static const String completeInfo = '/auth/completeInfo';
  static const String login = '/auth/login';
  static const String forgetPassword = '/auth/forgetPassword';
  static const String newPassword = '/auth/newPassword';

  // Home
  static const String home = '/home';
  static const String requestNewDelivery = '/home/requestNewDelivery';
  static const String checkout = '/home/checkout';
  static const String jobDetails = '/home/jobDetails/:id';
  static const String activeJobDetails = '/home/activeJobDetails/:id';

  // Active Tracking
  static const String activeTracking = '/activeTracking';

  // Job
  static const String job = '/job';
  static const String packageDetails = '/job/packageDetails/:id';

  // Order
  static const String myOrder = '/myOrder';
  static const String orderDetails = '/myOrder/orderDetails/:id';

  // Wallet
  static const String wallet = '/wallet';
  static const String withdraw = '/wallet/withdraw';
  static const String transactionHistory = '/wallet/transactionHistory';
  static const String transactionDetails = '/wallet/transactionHistory/:id';

  // Profile
  static const String profile = '/profile';
  static const String editProfile = '/profile/edit';
  static const String deliveryHistory = '/profile/deliveryHistory';
  static const String paymentManagement = '/profile/paymentManagement';
  static const String settings = '/profile/settings';
}
