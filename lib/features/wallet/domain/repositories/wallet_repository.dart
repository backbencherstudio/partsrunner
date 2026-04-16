import 'package:partsrunner/features/wallet/data/models/earning_overview_model.dart';
import 'package:partsrunner/features/wallet/data/models/wallet_summery_model.dart';
import 'package:partsrunner/features/wallet/data/models/withdraw_model.dart';

abstract class WalletRepository {
  Future<WalletSummeryModel> getWalletSummery();
  Future<EarningOverviewModel> getEarningOverview();
  Future<void> withdrawRequest(double amount);
  Future<WithdrawModel> getWithdrawHistory();
}