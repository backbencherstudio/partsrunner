// import 'package:partsrunner/core/api_service/api_client.dart';
// import 'package:partsrunner/core/api_service/api_endpoint.dart';
// import 'package:partsrunner/features/my_order/domain/entities/order_entity.dart';

// abstract class OrderRemoteDatasource {
//   Future<List<OrderEntity>> getCurrentShipping();
//   Future<List<OrderEntity>> getRecentShipping();
//   Future<OrderEntity> getOrderDetails(String orderId);
//   Future<void> updateOrder(String orderId);
//   Future<void> cancelOrder(String orderId);
// }

// class OrderRemoteDatasourceImpl implements OrderRemoteDatasource {
//   final ApiClient _apiClient;
//   OrderRemoteDatasourceImpl({required ApiClient apiClient})
//     : _apiClient = apiClient;
//   @override
//   Future<List<OrderEntity>> getCurrentShipping() async {
//     final response = await _apiClient.get(
//       ApiEndpoints.contractorDeliveriesCurrentShipping,
//     );
//     // return
//   }

//   @override
//   Future<List<OrderEntity>> getRecentShipping() async {
//     final response = await _apiClient.post(
//       ApiEndpoints.contractorDeliveriesRecentShipping,
//     );
//   }

//   @override
//   Future<OrderEntity> getOrderDetails(String orderId) {
//     // TODO: implement getOrderDetails
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> updateOrder(String orderId) {
//     // TODO: implement updateOrder
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> cancelOrder(String orderId) async {
//     try {
//       final response = await _apiClient.delete(
//         "${ApiEndpoints.contractorDeliveries}/$orderId",
//       );
//       if (response['success']) {
//         return;
//       } else {
//         throw Exception('Delete failed');
//       }
//     } catch (e) {
//       throw Exception(e);
//     }
//   }
// }
