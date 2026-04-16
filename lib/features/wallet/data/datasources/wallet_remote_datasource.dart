import 'package:partsrunner/core/services/api_service/api_client.dart';
import 'package:partsrunner/core/services/api_service/api_endpoint.dart';
import 'package:partsrunner/features/wallet/data/models/earning_overview_model.dart';
import 'package:partsrunner/features/wallet/data/models/wallet_summery_model.dart';
import 'package:partsrunner/features/wallet/data/models/withdraw_model.dart';

abstract class WalletRemoteDatasource {
  Future<WalletSummeryModel> getWalletSummery();
  Future<EarningOverviewModel> getEarningOverview();
  Future<void> withdrawRequest(double amount);
  Future<WithdrawModel> getWithdrawHistory();
}

class WalletRemoteDatasourceImpl implements WalletRemoteDatasource {
  final ApiClient _apiClient;
  WalletRemoteDatasourceImpl(this._apiClient);

  @override
  Future<void> withdrawRequest(double amount) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.runnerWithdrawalRequest,
        body: {'amount': amount},
      );
      if (response['success']) {
        return;
      } else {
        throw Exception('Failed to withdraw request');
      }
    } catch (e) {
      throw Exception('Failed to withdraw request: $e');
    }
  }

  @override
  Future<WithdrawModel> getWithdrawHistory() async {
    try {
      final response = await _apiClient.get(
        ApiEndpoints.runnerWithdrawalHistory,
      );
      if (response['success']) {
        return WithdrawModel.fromJson(response['data']);
      } else {
        throw Exception('Failed to get withdraw history');
      }
    } catch (e) {
      throw Exception('Failed to get withdraw history: $e');
    }
  }

  @override
  Future<WalletSummeryModel> getWalletSummery() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.runnerWalletSummary);
      if (response['success']) {
        return WalletSummeryModel.fromJson(response['data']);
      } else {
        throw Exception('Failed to get wallet summery');
      }
    } catch (e) {
      throw Exception('Failed to get wallet summery: $e');
    }
  }

  @override
  Future<EarningOverviewModel> getEarningOverview() async {
    try {
      final response = await _apiClient.get(
        ApiEndpoints.runnerEarningsOverview,
      );
      if (response['success']) {
        return EarningOverviewModel.fromJson(response['data']);
      } else {
        throw Exception('Failed to get earning overview');
      }
    } catch (e) {
      throw Exception('Failed to get earning overview: $e');
    }
  }
}
