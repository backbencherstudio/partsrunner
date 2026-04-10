import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partsrunner/core/services/api_service/api_client.dart';
import 'package:partsrunner/features/my_order/data/datasources/order_remote_datasource.dart';
import 'package:partsrunner/features/my_order/data/models/order_model.dart';
import 'package:partsrunner/features/my_order/data/repositories/order_repository_impl.dart';
import 'package:partsrunner/features/my_order/domain/repositories/order_repository.dart';
import 'package:partsrunner/features/my_order/domain/usecases/get_completed_orders_usecase.dart';
import 'package:partsrunner/features/my_order/domain/usecases/get_ongoing_orders_usecase.dart';

final _apiClientProvider = Provider<ApiClient>((ref) => ApiClient());

final _orderRemoteDatasourceProvider = Provider<OrderRemoteDatasource>(
  (ref) => OrderRemoteDatasourceImpl(apiClient: ref.watch(_apiClientProvider)),
);

final _orderRepositoryProvider = Provider<OrderRepository>(
  (ref) => OrderRepositoryImpl(
    orderRemoteDatasource: ref.watch(_orderRemoteDatasourceProvider),
  ),
);

final _getCompletedOrdersProvider = Provider<GetCompletedOrdersUsecase>(
  (ref) => GetCompletedOrdersUsecase(
    orderRepository: ref.watch(_orderRepositoryProvider),
  ),
);

final _getOngingOrdersProvider = Provider<GetOngoingOrdersUsecase>(
  (ref) => GetOngoingOrdersUsecase(
    orderRepository: ref.watch(_orderRepositoryProvider),
  ),
);

final completedOrdersProvider = FutureProvider<List<OrderModel>>(
  (ref) => ref.read(_getCompletedOrdersProvider).call(),
);

final ongoingOrdersProvider = FutureProvider<List<OrderModel>>(
  (ref) => ref.read(_getOngingOrdersProvider).call(),
);
