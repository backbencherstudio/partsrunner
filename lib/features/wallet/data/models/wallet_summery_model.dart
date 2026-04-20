import 'package:partsrunner/core/helpers/helper_functions.dart';

class WalletSummeryModel {
  double? walletBalance;
  double? totalEarned;
  int? totalDeliveries;
  double? pendingWithdrawal;
  double? availableToWithdraw;
  bool? stripeConnected;

  WalletSummeryModel(
      {this.walletBalance,
      this.totalEarned,
      this.totalDeliveries,
      this.pendingWithdrawal,
      this.availableToWithdraw,
      this.stripeConnected});

  WalletSummeryModel.fromJson(Map<String, dynamic> json) {
    walletBalance = HelperFunctions.toDouble(json['wallet_balance']);
    totalEarned = HelperFunctions.toDouble(json['total_earned']);
    totalDeliveries = json['total_deliveries'];
    pendingWithdrawal = HelperFunctions.toDouble(json['pending_withdrawal']);
    availableToWithdraw = HelperFunctions.toDouble(json['available_to_withdraw']);
    stripeConnected = json['stripe_connected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wallet_balance'] = walletBalance;
    data['total_earned'] = totalEarned;
    data['total_deliveries'] = totalDeliveries;
    data['pending_withdrawal'] = pendingWithdrawal;
    data['available_to_withdraw'] = availableToWithdraw;
    data['stripe_connected'] = stripeConnected;
    return data;
  }
}
