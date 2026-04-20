import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partsrunner/core/models/delivery_model.dart';
import 'package:partsrunner/core/provider/api_client_provider.dart';
import 'package:partsrunner/features/search/data/datasources/search_remote_datasource.dart';
import 'package:partsrunner/features/search/data/repositories/search_repository_impl.dart';
import 'package:partsrunner/features/search/domain/repositories/search_repository.dart';
import 'package:partsrunner/features/search/domain/usecases/search_usecase.dart';

final searchQueryProvider = StateProvider<String>((ref) => "");

final isContractorProvider = StateProvider<bool>((ref) => true);  

final searchProvider = FutureProvider.family<List<DeliveryModel>, String>((ref, query) async {
  if (query.isEmpty) return [];
  final searchRepository = ref.watch(_searchRepositoryProvider);
  final searchUsecase = SearchUsecase(searchRepository);
  return await searchUsecase.search(query, ref.watch(isContractorProvider));
});

final _searchRepositoryProvider = Provider<SearchRepository>((ref) {
  final searchRemoteDatasource = ref.watch(_searchRemoteDatasourceProvider);
  return SearchRepositoryImpl(searchRemoteDatasource);
});

final _searchRemoteDatasourceProvider = Provider<SearchRemoteDatasource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return SearchRemoteDatasourceImpl(apiClient);
});