import 'package:partsrunner/features/wallet/domain/repositories/wallet_repository.dart';

class WithdrawRequestUsecase {
  final WalletRepository _walletRepository;
  WithdrawRequestUsecase(this._walletRepository);
  Future<void> call(double amount) {
    return _walletRepository.withdrawRequest(amount);
  }
}
