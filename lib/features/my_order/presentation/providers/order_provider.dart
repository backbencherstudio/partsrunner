import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partsrunner/core/models/delivery_model.dart';
import 'package:partsrunner/core/provider/api_client_provider.dart';
import 'package:partsrunner/features/my_order/data/datasources/order_remote_datasource.dart';
import 'package:partsrunner/features/my_order/data/models/order_model.dart';
import 'package:partsrunner/features/my_order/data/repositories/order_repository_impl.dart';
import 'package:partsrunner/features/my_order/domain/repositories/order_repository.dart';
import 'package:partsrunner/features/my_order/domain/usecases/cancel_order_usecase.dart';
import 'package:partsrunner/features/my_order/domain/usecases/get_completed_orders_usecase.dart';
import 'package:partsrunner/features/my_order/domain/usecases/get_ongoing_orders_usecase.dart';
import 'package:partsrunner/features/my_order/domain/usecases/get_order_details_usecase.dart';
import 'package:partsrunner/features/my_order/domain/usecases/update_order_usecase.dart';

class UpdateOrderParams {
  final String id;
  final String packageName;
  final double weight;
  final String supplierId;
  final String pickupDate;
  final String technicianName;
  final String technicianPhone;
  final String deliveryAddress;
  final String specialInstructions;
  final String paymentProvider;

  UpdateOrderParams({
    required this.id,
    required this.packageName,
    required this.weight,
    required this.supplierId,
    required this.pickupDate,
    required this.technicianName,
    required this.technicianPhone,
    required this.deliveryAddress,
    required this.specialInstructions,
    required this.paymentProvider,
  });
}

final _orderRemoteDatasourceProvider = Provider<OrderRemoteDatasource>(
  (ref) => OrderRemoteDatasourceImpl(ref.watch(apiClientProvider)),
);

final _orderRepositoryProvider = Provider<OrderRepository>(
  (ref) => OrderRepositoryImpl(ref.watch(_orderRemoteDatasourceProvider)),
);

final _getCompletedOrdersProvider = Provider<GetCompletedOrdersUsecase>(
  (ref) => GetCompletedOrdersUsecase(ref.watch(_orderRepositoryProvider)),
);

final _getOngingOrdersProvider = Provider<GetOngoingOrdersUsecase>(
  (ref) => GetOngoingOrdersUsecase(ref.watch(_orderRepositoryProvider)),
);

final _getOrderDetailsUsecaseProvider = Provider<GetOrderDetailsUsecase>(
  (ref) => GetOrderDetailsUsecase(ref.watch(_orderRepositoryProvider)),
);

final _updateOrderUsecaseProvider = Provider<UpdateOrderUsecase>(
  (ref) => UpdateOrderUsecase(ref.watch(_orderRepositoryProvider)),
);

final _cancelOrderUsecaseProvider = Provider<CancelOrderUsecase>(
  (ref) => CancelOrderUsecase(ref.watch(_orderRepositoryProvider)),
);

final getCompletedOrdersProvider = FutureProvider<List<OrderModel>>(
  (ref) => ref.read(_getCompletedOrdersProvider).call(),
);

final getOngoingOrdersProvider = FutureProvider<List<OrderModel>>(
  (ref) => ref.read(_getOngingOrdersProvider).call(),
);

final getOrderDetailsProvider = FutureProvider.family<DeliveryModel, String>(
  (ref, id) => ref.read(_getOrderDetailsUsecaseProvider).call(id),
);

final updateOrderProvider = FutureProvider.family<void, UpdateOrderParams>(
  (ref, params) => ref
      .read(_updateOrderUsecaseProvider)
      .call(
        params.id,
        params.packageName,
        params.weight,
        params.supplierId,
        params.pickupDate,
        params.technicianName,
        params.technicianPhone,
        params.deliveryAddress,
        params.specialInstructions,
        params.paymentProvider,
      ),
);

final cancelOrderProvider = FutureProvider.family<void, String>(
  (ref, id) => ref.read(_cancelOrderUsecaseProvider).call(id),
);

final orderTabProvider = StateProvider<bool>((ref) => true);
