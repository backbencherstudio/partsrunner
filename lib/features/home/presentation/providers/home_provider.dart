import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partsrunner/core/api_service/api_client.dart';
import 'package:partsrunner/features/home/data/datasources/home_remote_datasource.dart';
import 'package:partsrunner/features/home/data/repositories/home_repository_impl.dart';
import 'package:partsrunner/features/home/domain/repositories/home_repository.dart';
import 'package:partsrunner/features/home/domain/usecases/change_availability_usecase.dart';

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

// ---------------------------------------------------------------------------
// Home state
// ---------------------------------------------------------------------------

sealed class HomeState {
  const HomeState();
}

/// No operation has been triggered yet.
class HomeInitial extends HomeState {
  const HomeInitial();
}

/// Home operation succeeded.
class HomeSuccess extends HomeState {
  const HomeSuccess({required this.message});
  final String message;
}

/// A home operation failed.
class HomeError extends HomeState {
  const HomeError({required this.message});
  final String message;
}

// ---------------------------------------------------------------------------
// Home notifier
// ---------------------------------------------------------------------------

class HomeNotifier extends AsyncNotifier<HomeState> {
  late ChangeAvailabilityUsecase _changeAvailability;

  @override
  Future<HomeState> build() async {
    _changeAvailability = ref.watch(_changeAvailabilityUseCaseProvider);
    return const HomeInitial();
  }

  /// Change availability status for runner
  Future<void> changeAvailability(bool isOnline) async {
    state = const AsyncLoading();
    state =
        await AsyncValue.guard(() async {
          await _changeAvailability(isOnline);
          return HomeSuccess(
            message: isOnline
                ? 'You are now online and available for jobs'
                : 'You are now offline',
          );
        }).then(
          (asyncValue) => asyncValue.when(
            data: (s) => AsyncData(s),
            loading: () => const AsyncLoading(),
            error: (e, st) => AsyncData(HomeError(message: _friendly(e))),
          ),
        );
  }

  /// Reset back to initial so screens don't see a stale success/error state.
  void resetState() {
    state = const AsyncData(HomeInitial());
  }

  String _friendly(Object e) {
    if (e is Exception) {
      return e.toString().replaceAll('Exception: ', '');
    }
    return e.toString();
  }
}

final homeNotifierProvider = AsyncNotifierProvider<HomeNotifier, HomeState>(
  HomeNotifier.new,
);
