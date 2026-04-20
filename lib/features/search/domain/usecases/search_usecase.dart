import 'package:partsrunner/core/models/delivery_model.dart';
import 'package:partsrunner/features/search/domain/repositories/search_repository.dart';

class SearchUsecase {
  final SearchRepository _searchRepository;
  SearchUsecase(this._searchRepository);

  Future<List<DeliveryModel>> search(String query, bool isContractor) async {
    return await _searchRepository.search(query, isContractor);
  }
}
