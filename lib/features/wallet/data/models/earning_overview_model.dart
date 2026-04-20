import 'package:partsrunner/core/helpers/helper_functions.dart';

class EarningOverviewModel {
  double? availableBalance;
  double? pendingEarnings;
  double? totalEarned;
  int? deliveriesCompleted;
  int? confirmationPeriodDays;

  EarningOverviewModel({
    this.availableBalance,
    this.pendingEarnings,
    this.totalEarned,
    this.deliveriesCompleted,
    this.confirmationPeriodDays,
  });

  EarningOverviewModel.fromJson(Map<String, dynamic> json) {
    availableBalance = HelperFunctions.toDouble(json['available_balance']);
    pendingEarnings = HelperFunctions.toDouble(json['pending_earnings']);
    totalEarned = HelperFunctions.toDouble(json['total_earned']);
    deliveriesCompleted = json['deliveries_completed'];
    confirmationPeriodDays = json['confirmation_period_days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['available_balance'] = availableBalance;
    data['pending_earnings'] = pendingEarnings;
    data['total_earned'] = totalEarned;
    data['deliveries_completed'] = deliveriesCompleted;
    data['confirmation_period_days'] = confirmationPeriodDays;
    return data;
  }
}
