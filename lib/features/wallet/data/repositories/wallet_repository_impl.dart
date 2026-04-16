import 'package:partsrunner/features/wallet/data/datasources/wallet_remote_datasource.dart';
import 'package:partsrunner/features/wallet/data/models/earning_overview_model.dart';
import 'package:partsrunner/features/wallet/data/models/wallet_summery_model.dart';
import 'package:partsrunner/features/wallet/data/models/withdraw_model.dart';
import 'package:partsrunner/features/wallet/domain/repositories/wallet_repository.dart';

class WalletRepositoryImpl implements WalletRepository {
  final WalletRemoteDatasource _walletRemoteDatasource;
  WalletRepositoryImpl(this._walletRemoteDatasource);

  @override
  Future<EarningOverviewModel> getEarningOverview() {
    return _walletRemoteDatasource.getEarningOverview();
  }

  @override
  Future<WalletSummeryModel> getWalletSummery() {
    return _walletRemoteDatasource.getWalletSummery();
  }

  @override
  Future<WithdrawModel> getWithdrawHistory() {
    return _walletRemoteDatasource.getWithdrawHistory();
  }

  @override
  Future<void> withdrawRequest(double amount) {
    return _walletRemoteDatasource.withdrawRequest(amount);
  }
}
