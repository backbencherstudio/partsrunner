import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partsrunner/core/services/api_service/api_client.dart';
import 'package:partsrunner/features/home/data/datasources/home_remote_datasource.dart';
import 'package:partsrunner/features/home/data/models/delivery_home_runner_model.dart';
import 'package:partsrunner/core/models/delivery_model.dart';
import 'package:partsrunner/features/home/data/models/shipping_summary_model.dart';
import 'package:partsrunner/features/home/data/repositories/home_repository_impl.dart';
import 'package:partsrunner/features/home/domain/repositories/home_repository.dart';
import 'package:partsrunner/features/home/domain/usecases/change_availability_usecase.dart';
import 'package:partsrunner/features/home/domain/usecases/get_delivery_runner_usecase.dart';
import 'package:partsrunner/features/home/domain/usecases/get_new_request_usecase.dart';
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

final _getDeliveryRunnerUseCaseProvider = Provider<GetDeliveryRunnerUsecase>(
  (ref) => GetDeliveryRunnerUsecase(ref.watch(_homeRepositoryProvider)),
);

final _getNewRequestUseCaseProvider = Provider<GetNewRequestUsecase>(
  (ref) => GetNewRequestUsecase(ref.watch(_homeRepositoryProvider)),
);

// --------------------------------------------------------------
// FutureProvider
// --------------------------------------------------------------

final deliveryRunnerProvider = FutureProvider<DeliveryHomeRunnerModel>((ref) {
  return ref.read(_getDeliveryRunnerUseCaseProvider).call();
});

final shippingSummaryProvider = FutureProvider<ShippingSummaryModel>((ref) {
  return ref.read(_getShippingInfoUseCaseProvider).call();
});
final changeAvailabilityProvider = FutureProvider<void>((ref) {
  final isOnline = ref.watch(onlineStatusProvider);
  return ref.read(_changeAvailabilityUseCaseProvider).call(isOnline);
});

final newRequestProvider = FutureProvider<List<DeliveryModel>>((ref) {
  return ref.read(_getNewRequestUseCaseProvider).call();
});

// Online status state provider
final onlineStatusProvider = StateProvider<bool>((ref) => false);

// Periodic polling provider for new requests every 10 seconds
final periodicNewRequestProvider = StreamProvider<List<DeliveryModel>>((ref) {
  final getNewRequestUseCase = ref.read(_getNewRequestUseCaseProvider);

  return Stream.periodic(const Duration(seconds: 10), (count) {
    return count;
  }).asyncMap((_) async {
    try {
      final result = await getNewRequestUseCase.call();
      return result;
    } catch (e) {
      print("Error fetching new requests: $e");
      // Return empty list on error to avoid breaking the stream
      return <DeliveryModel>[];
    }
  });
});
