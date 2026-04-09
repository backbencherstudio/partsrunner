import 'package:partsrunner/features/home/domain/repositories/home_repository.dart';

class ChangeAvailabilityUsecase {
  final HomeRepository _homeRepository;
  ChangeAvailabilityUsecase({required HomeRepository homeRepository})
    : _homeRepository = homeRepository;
  Future<void> call(bool isOnline) {
    return _homeRepository.changeAvailability(isOnline);
  }
}