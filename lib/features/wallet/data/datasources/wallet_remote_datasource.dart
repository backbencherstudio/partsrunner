abstract class WalletRemoteDatasource {
  Future<void> withdrawRequest();
  Future<void> withdrawHistory();
}

class WalletRemoteDatasourceImpl implements WalletRemoteDatasource {
  @override
  Future<void> withdrawRequest() {
    // TODO: implement withdrawRequest
    throw UnimplementedError();
  }
  
  @override
  Future<void> withdrawHistory() {
    // TODO: implement withdrawHistory
    throw UnimplementedError();
  }
}
