import 'package:partsrunner/features/wallet/data/models/withdraw_model.dart';
import 'package:partsrunner/features/wallet/domain/repositories/wallet_repository.dart';

class GetWithdrawHistoryUsecase {
  final WalletRepository _walletRepository;
  
  GetWithdrawHistoryUsecase(this._walletRepository);
  
  Future<WithdrawModel> call() {
    return _walletRepository.getWithdrawHistory();
  }
}
