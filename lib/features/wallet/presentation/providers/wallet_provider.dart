import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partsrunner/core/provider/api_client_provider.dart';
import 'package:partsrunner/features/wallet/data/datasources/wallet_remote_datasource.dart';
import 'package:partsrunner/features/wallet/data/repositories/wallet_repository_impl.dart';
import 'package:partsrunner/features/wallet/domain/repositories/wallet_repository.dart';
import 'package:partsrunner/features/wallet/domain/usecases/get_earning_overview_usecase.dart';
import 'package:partsrunner/features/wallet/domain/usecases/get_wallet_summery_usecase.dart';
import 'package:partsrunner/features/wallet/domain/usecases/get_withdraw_history_usecase.dart';
import 'package:partsrunner/features/wallet/domain/usecases/withdraw_request_usecase.dart';

final _walletRemoteDatasourceProvider = Provider<WalletRemoteDatasource>(
  (ref) => WalletRemoteDatasourceImpl(ref.watch(apiClientProvider)),
);
final _walletRepositoryProvider = Provider<WalletRepository>(
  (ref) => WalletRepositoryImpl(ref.watch(_walletRemoteDatasourceProvider)),
);
final _getWalletSummeryUsecaseProvider = Provider<GetWalletSummeryUsecase>(
  (ref) => GetWalletSummeryUsecase(ref.watch(_walletRepositoryProvider)),
);
final _getEarningOverviewUsecaseProvider = Provider<GetEarningOverviewUsecase>(
  (ref) => GetEarningOverviewUsecase(ref.watch(_walletRepositoryProvider)),
);
final _getWithdrawHistoryUsecaseProvider = Provider<GetWithdrawHistoryUsecase>(
  (ref) => GetWithdrawHistoryUsecase(ref.watch(_walletRepositoryProvider)),
);
final _withdrawRequestUsecaseProvider = Provider<WithdrawRequestUsecase>(
  (ref) => WithdrawRequestUsecase(ref.watch(_walletRepositoryProvider)),
);

// Wallet Summary Provider
final walletSummaryProvider = FutureProvider.autoDispose((ref) async {
  return ref.watch(_getWalletSummeryUsecaseProvider)();
});

// Earning Overview Provider
final earningOverviewProvider = FutureProvider.autoDispose((ref) async {
  return ref.watch(_getEarningOverviewUsecaseProvider)();
});

// Withdraw History Provider
final withdrawHistoryProvider = FutureProvider.autoDispose((ref) async {
  return ref.watch(_getWithdrawHistoryUsecaseProvider)();
});

// Withdraw Request StateNotifier
class WithdrawRequestNotifier extends StateNotifier<AsyncValue<void>> {
  final WithdrawRequestUsecase _usecase;

  WithdrawRequestNotifier(this._usecase) : super(const AsyncValue.data(null));

  Future<void> requestWithdraw(double amount) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _usecase(amount));
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}

final withdrawRequestProvider =
    StateNotifierProvider.autoDispose<
      WithdrawRequestNotifier,
      AsyncValue<void>
    >((ref) {
      return WithdrawRequestNotifier(
        ref.watch(_withdrawRequestUsecaseProvider),
      );
    });
