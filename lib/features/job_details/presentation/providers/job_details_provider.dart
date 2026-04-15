import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partsrunner/core/models/delivery_model.dart';
import 'package:partsrunner/core/provider/api_client_provider.dart';
import 'package:partsrunner/features/job_details/data/datasource/job_details_remote_datasource.dart';
import 'package:partsrunner/features/job_details/data/repositories/job_details_repository_impl.dart';
import 'package:partsrunner/features/job_details/domain/repositories/job_details_repository.dart';
import 'package:partsrunner/features/job_details/domain/usecase/get_request_by_id_usecase.dart';
import 'package:partsrunner/features/job_details/domain/usecase/runner_accept_request_usecase.dart';
import 'package:partsrunner/features/job_details/domain/usecase/runner_reject_request_usecase.dart';
import 'package:partsrunner/features/job_details/domain/usecase/update_delivery_status_usecase.dart';

final _jobDetailsRemoteDatasourceProvider =
    Provider<JobDetailsRemoteDatasource>(
      (ref) => JobDetailsRemoteDatasourceImpl(ref.watch(apiClientProvider)),
    );

final _jobDetailsRepositoryProvider = Provider<JobDetailsRepository>(
  (ref) =>
      JobDetailsRepositoryImpl(ref.watch(_jobDetailsRemoteDatasourceProvider)),
);

final _getRequestByIdUsecaseProvider = Provider<GetRequestByIdUsecase>(
  (ref) => GetRequestByIdUsecase(ref.watch(_jobDetailsRepositoryProvider)),
);

final _updateRequestStatusUsecaseProvider =
    Provider<UpdateDeliveryStatusUsecase>(
      (ref) =>
          UpdateDeliveryStatusUsecase(ref.watch(_jobDetailsRepositoryProvider)),
    );

final _runnerAcceptRequestUsecaseProvider =
    Provider<RunnerAcceptRequestUsecase>(
      (ref) =>
          RunnerAcceptRequestUsecase(ref.watch(_jobDetailsRepositoryProvider)),
    );

final _runnerRejectRequestUsecaseProvider =
    Provider<RunnerRejectRequestUsecase>(
      (ref) =>
          RunnerRejectRequestUsecase(ref.watch(_jobDetailsRepositoryProvider)),
    );

final updateRequestStatus =
    FutureProvider.family<void, ({String id, String status, List<String>? proofFile})>(
      (ref, ({String id, String status, List<String>? proofFile}) args) => ref
          .read(_updateRequestStatusUsecaseProvider)
          .call(args.id, args.status, args.proofFile),
    );

final getRequestById = FutureProvider.family<DeliveryModel, String>(
  (ref, String id) => ref.read(_getRequestByIdUsecaseProvider).call(id),
);

final runnerAcceptRequest = FutureProvider.family<void, String>((
  ref,
  String id,
) async {
  await ref.read(_runnerAcceptRequestUsecaseProvider).call(id);
});

final runnerRejectRequest = FutureProvider.family<void, String>((
  ref,
  String id,
) async {
  await ref.read(_runnerRejectRequestUsecaseProvider).call(id);
});

// Active job stage provider (1: Arrived, 2: Waiting, 3: Pickup, 4: En Route)
final activeJobStageProvider = StateProvider<int>((ref) => 1);
