import 'package:partsrunner/features/wallet/data/models/earning_overview_model.dart';
import 'package:partsrunner/features/wallet/domain/repositories/wallet_repository.dart';

class GetEarningOverviewUsecase {
  final WalletRepository _walletRepository;
  GetEarningOverviewUsecase(this._walletRepository);
  Future<EarningOverviewModel> call() {
    return _walletRepository.getEarningOverview();
  }
}
