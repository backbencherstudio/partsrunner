import 'package:partsrunner/features/wallet/data/models/wallet_summery_model.dart';
import 'package:partsrunner/features/wallet/domain/repositories/wallet_repository.dart';

class GetWalletSummeryUsecase {
  final WalletRepository _walletRepository;
  GetWalletSummeryUsecase(this._walletRepository);
  Future<WalletSummeryModel> call() {
    return _walletRepository.getWalletSummery();
  }
}
