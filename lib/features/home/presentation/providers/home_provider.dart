import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partsrunner/core/services/api_service/api_client.dart';
import 'package:partsrunner/features/home/data/datasources/home_remote_datasource.dart';
import 'package:partsrunner/features/home/data/models/shipping_summary_model.dart';
import 'package:partsrunner/features/home/data/repositories/home_repository_impl.dart';
import 'package:partsrunner/features/home/domain/repositories/home_repository.dart';
import 'package:partsrunner/features/home/domain/usecases/change_availability_usecase.dart';
import 'package:partsrunner/features/home/domain/usecases/get_shipping_info_usecase.dart';

// ---------------------------------------------------------------------------
// Dependency providers
// ---------------------------------------------------------------------------
final _apiClientProvider = Provider<ApiClient>((ref) => ApiClient());

final _homeRemoteDataSourceProvider = Provider<HomeRemoteDatasource>(
  (ref) => HomeRemoteDatasourceImpl(apiClient: ref.watch(_apiClientProvider)),
);

final _homeRepositoryProvider = Provider<HomeRepository>(
  (ref) => HomeRepositoryImpl(
    homeRemoteDataSource: ref.watch(_homeRemoteDataSourceProvider),
  ),
);

final _changeAvailabilityUseCaseProvider = Provider<ChangeAvailabilityUsecase>(
  (ref) => ChangeAvailabilityUsecase(
    homeRepository: ref.watch(_homeRepositoryProvider),
  ),
);

final _getShippingInfoUseCaseProvider = Provider<GetShippingInfoUsecase>(
  (ref) => GetShippingInfoUsecase(ref.watch(_homeRepositoryProvider)),
);

final changeAvailabilityProvider = FutureProvider.family<void, bool>((ref, isOnline) {
  return ref.read(_changeAvailabilityUseCaseProvider).call(isOnline);
});

final shippingSummaryProvider = FutureProvider<ShippingSummaryModel>((ref) {
  return ref.read(_getShippingInfoUseCaseProvider).call();
});
