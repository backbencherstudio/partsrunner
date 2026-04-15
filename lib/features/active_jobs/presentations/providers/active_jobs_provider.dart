import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partsrunner/core/models/delivery_model.dart';
import 'package:partsrunner/core/provider/api_client_provider.dart';
import 'package:partsrunner/features/active_jobs/data/datasources/active_jobs_remote_datasource.dart';
import 'package:partsrunner/features/active_jobs/data/repositories/active_jobs_repository_impl.dart';
import 'package:partsrunner/features/active_jobs/domain/repositories/active_jobs_repository.dart';
import 'package:partsrunner/features/active_jobs/domain/usecases/get_all_deliveries_usecase.dart';
import 'package:partsrunner/features/active_jobs/domain/usecases/get_canceled_deliveries_usecase.dart';
import 'package:partsrunner/features/active_jobs/domain/usecases/get_completed_deliveries_usecase.dart';
import 'package:partsrunner/features/active_jobs/domain/usecases/get_ongoing_deliveries_usecase.dart';

final _activeJobsRemoteDatasourceProvider =
    Provider<ActiveJobsRemoteDatasource>(
      (ref) => ActiveJobsRemoteDatasourceImpl(ref.watch(apiClientProvider)),
    );

final _activeJobsRepositoryProvider = Provider<ActiveJobsRepository>(
  (ref) =>
      ActiveJobsRepositoryImpl(ref.watch(_activeJobsRemoteDatasourceProvider)),
);

final _getAllDeliveriesUsecaseProvider = Provider<GetAllDeliveriesUsecase>(
  (ref) => GetAllDeliveriesUsecase(ref.watch(_activeJobsRepositoryProvider)),
);

final _getOngoingDeliveriesUsecaseProvider =
    Provider<GetOngoingDeliveriesUsecase>(
      (ref) =>
          GetOngoingDeliveriesUsecase(ref.watch(_activeJobsRepositoryProvider)),
    );

final _getCompletedDeliveriesUsecaseProvider =
    Provider<GetCompletedDeliveriesUsecase>(
      (ref) => GetCompletedDeliveriesUsecase(
        ref.watch(_activeJobsRepositoryProvider),
      ),
    );

final _getCanceledDeliveriesUsecaseProvider =
    Provider<GetCanceledDeliveriesUsecase>(
      (ref) => GetCanceledDeliveriesUsecase(
        ref.watch(_activeJobsRepositoryProvider),
      ),
    );

final getAllDeliveriesProvider = FutureProvider<List<DeliveryModel>>(
  (ref) => ref.read(_getAllDeliveriesUsecaseProvider).call(),
);

final getOngoingDeliveriesProvider = FutureProvider<List<DeliveryModel>>(
  (ref) => ref.read(_getOngoingDeliveriesUsecaseProvider).call(),
);

final getCompletedDeliveriesProvider = FutureProvider<List<DeliveryModel>>(
  (ref) => ref.read(_getCompletedDeliveriesUsecaseProvider).call(),
);

final getCanceledDeliveriesProvider = FutureProvider<List<DeliveryModel>>(
  (ref) => ref.read(_getCanceledDeliveriesUsecaseProvider).call(),
);

final selectedTabIndexProvider = StateProvider<int>((ref) => 0);
