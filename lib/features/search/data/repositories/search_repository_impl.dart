import 'package:partsrunner/core/models/delivery_model.dart';
import 'package:partsrunner/features/search/data/datasources/search_remote_datasource.dart';
import 'package:partsrunner/features/search/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDatasource _searchRemoteDatasource;
  SearchRepositoryImpl(this._searchRemoteDatasource);

  @override
  Future<List<DeliveryModel>> search(String query, bool isContractor) async {
    return await _searchRemoteDatasource.search(query, isContractor);
  }
}