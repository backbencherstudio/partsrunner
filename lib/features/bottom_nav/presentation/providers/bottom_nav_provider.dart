import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partsrunner/core/services/api_service/api_client.dart';
import 'package:partsrunner/features/bottom_nav/data/datasources/bottom_nav_remote_datasource.dart';
import 'package:partsrunner/features/bottom_nav/data/models/user_model.dart';
import 'package:partsrunner/features/bottom_nav/data/repositories/bottom_nav_repository_impl.dart';
import 'package:partsrunner/features/bottom_nav/domain/entities/user_entity.dart';
import 'package:partsrunner/features/bottom_nav/domain/repositories/bottom_nav_repository.dart';
import 'package:partsrunner/features/bottom_nav/domain/usecases/get_user_usecase.dart';

final bottomNavProvider = StateProvider<int>((ref) => 0);

// Provider for ApiClient
final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());

// Provider for remote datasource
final bottomNavRemoteDatasourceProvider = Provider<BottomNavRemoteDatasource>((
  ref,
) {
  return BottomNavRemoteDataSourceImpl(apiClient: ref.read(apiClientProvider));
});

// Provider for repository
final bottomNavRepositoryProvider = Provider<BottomNavRepository>((ref) {
  return BottomNavRepositoryImpl(
    remoteDatasource: ref.read(bottomNavRemoteDatasourceProvider),
  );
});

// Provider for GetUserUsecase
final getUserUsecaseProvider = Provider<GetUserUsecase>((ref) {
  return GetUserUsecase(ref.read(bottomNavRepositoryProvider));
});

// Provider for user data using the usecase
final userProvider = FutureProvider<UserEntity>((ref) async {
  final user = await ref.read(getUserUsecaseProvider).call();
  return user;
});
