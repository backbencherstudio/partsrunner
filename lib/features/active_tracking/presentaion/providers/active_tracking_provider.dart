import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partsrunner/core/services/api_service/api_client.dart';
import 'package:partsrunner/features/active_tracking/data/datasources/active_deliveries_remote_datasource.dart';
import 'package:partsrunner/features/active_tracking/data/models/active_delivery_model.dart';
import 'package:partsrunner/features/active_tracking/data/repositories/active_deliveries_repository_impl.dart';
import 'package:partsrunner/features/active_tracking/domain/repositories/active_deliveries_repository.dart';
import 'package:partsrunner/features/active_tracking/domain/usecases/get_active_deliveries_usecase.dart';

// ---------------------------------------------------------------------------
// Dependency providers
// ---------------------------------------------------------------------------

final _apiClientProvider = Provider<ApiClient>((ref) => ApiClient());

final _activeDeliveriesRemoteDatasource =
    Provider<ActiveDeliveriesRemoteDatasource>(
      (ref) => ActiveDeliveriesRemoteDatasourceImpl(
        apiClient: ref.watch(_apiClientProvider),
      ),
    );

final _activeDeliveriesRepository = Provider<ActiveDeliveriesRepository>(
  (ref) => ActiveDeliveriesRepositoryImpl(
    activeDeliveriesRemoteDatasource: ref.watch(
      _activeDeliveriesRemoteDatasource,
    ),
  ),
);

final _getActiveDeliveriesUsecase = Provider<GetActiveDeliveriesUsecase>(
  (ref) => GetActiveDeliveriesUsecase(
    activeDeliveryRepository: ref.watch(_activeDeliveriesRepository),
  ),
);

final getActiveDeliveriesProvider = FutureProvider<List<ActiveDeliveryModel>>(
  (ref) => ref.read(_getActiveDeliveriesUsecase).call(),
);

// sealed class ActiveDeliveriesState {
//   const ActiveDeliveriesState();
// }

// /// No operation has been triggered yet.
// class ActiveDeliveriesInitial extends ActiveDeliveriesState {
//   const ActiveDeliveriesInitial();
// }

// /// Home operation succeeded.
// class ActiveDeliveriesSuccess extends ActiveDeliveriesState {
//   final List<ActiveDeliveryModel> activeDeliveries;

//   const ActiveDeliveriesSuccess({required this.activeDeliveries});
// }

// /// A home operation failed.
// class ActiveDeliveriesError extends ActiveDeliveriesState {
//   const ActiveDeliveriesError({required this.message});
//   final String message;
// }

// class ActiveDeliveriesNotifier extends AsyncNotifier<ActiveDeliveriesState> {
//   late GetActiveDeliveriesUsecase _getActiveDeliveries;

//   @override
//   FutureOr<ActiveDeliveriesState> build() {
//     _getActiveDeliveries = ref.watch(_getActiveDeliveriesUsecase);
//     return const ActiveDeliveriesInitial();
//   }

//   Future<void> getActiveDeliveries() async {
//     state = const AsyncLoading();
//     state =
//         await AsyncValue.guard(() async {
//           final ad = await _getActiveDeliveries();
//           return ActiveDeliveriesSuccess(activeDeliveries: ad);
//         }).then(
//           (asyncValue) => asyncValue.when(
//             data: (s) => AsyncData(s),
//             loading: () => const AsyncLoading(),
//             error: (e, st) => AsyncData(ActiveDeliveriesError(message: _friendly(e))),
//           ),
//         );
//   }
//   /// Reset back to initial so screens don't see a stale success/error state.
//   void resetState() {
//     state = const AsyncData(ActiveDeliveriesInitial());
//   }

//   String _friendly(Object e) {
//     if (e is Exception) {
//       return e.toString().replaceAll('Exception: ', '');
//     }
//     return e.toString();
//   }
// }

// final homeNotifierProvider = AsyncNotifierProvider<ActiveDeliveriesNotifier, ActiveDeliveriesState>(
//   ActiveDeliveriesNotifier.new,
// );
