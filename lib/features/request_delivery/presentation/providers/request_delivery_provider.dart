import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partsrunner/features/request_delivery/domain/entities/supplier_entity.dart';
import 'package:partsrunner/features/request_delivery/domain/usecases/get_suppliers.dart';
import 'package:partsrunner/features/request_delivery/domain/usecases/create_request_delivery.dart';
import 'package:partsrunner/features/request_delivery/domain/repositories/request_delivery_repository.dart';
import 'package:partsrunner/features/request_delivery/data/repositories/request_delivery_repository_impl.dart';
import 'package:partsrunner/features/request_delivery/data/datasources/request_delivery_datasource.dart';
import 'package:partsrunner/core/api_service/api_client.dart';

// ---------------------------------------------------------------------------
// UI state providers
// ---------------------------------------------------------------------------

final paymentMethodProvider = StateProvider<int>(
  (ref) => 0,
); // 0: Visa, 1: Add New Card, 2: Paypal
final isStepTwoProvider = StateProvider<bool>((ref) => false);

// ---------------------------------------------------------------------------
// Form data providers
// ---------------------------------------------------------------------------

final packageInfoProvider = StateProvider<Map<String, String>>((ref) => {});
final senderInfoProvider = StateProvider<Map<String, String>>((ref) => {});
final receiverInfoProvider = StateProvider<Map<String, String>>((ref) => {});
final specialInstructionsProvider = StateProvider<String>((ref) => '');

// ---------------------------------------------------------------------------
// Request delivery state
// ---------------------------------------------------------------------------

sealed class RequestDeliveryState {
  const RequestDeliveryState();
}

class RequestDeliveryInitial extends RequestDeliveryState {
  const RequestDeliveryInitial();
}

class RequestDeliveryLoading extends RequestDeliveryState {
  const RequestDeliveryLoading();
}

class RequestDeliverySuccess extends RequestDeliveryState {
  const RequestDeliverySuccess({required this.message});
  final String message;
}

class RequestDeliveryError extends RequestDeliveryState {
  const RequestDeliveryError({required this.message});
  final String message;
}

class RequestDeliverySuppliersLoading extends RequestDeliveryState {
  const RequestDeliverySuppliersLoading();
}

class RequestDeliverySuppliersSuccess extends RequestDeliveryState {
  const RequestDeliverySuppliersSuccess({required this.suppliers});
  final List<SupplierEntity> suppliers;
}

class RequestDeliverySuppliersError extends RequestDeliveryState {
  const RequestDeliverySuppliersError({required this.message});
  final String message;
}

// ---------------------------------------------------------------------------
// Request delivery notifier
// ---------------------------------------------------------------------------

class RequestDeliveryNotifier extends StateNotifier<RequestDeliveryState> {
  final GetSuppliers _getSuppliers;
  final CreateRequestDelivery _createRequestDelivery;
  final Ref _ref;

  RequestDeliveryNotifier({
    required GetSuppliers getSuppliers,
    required CreateRequestDelivery createRequestDelivery,
    required Ref ref,
  }) : _getSuppliers = getSuppliers,
       _createRequestDelivery = createRequestDelivery,
       _ref = ref,
       super(const RequestDeliveryInitial());

  void updatePaymentMethod(int method) {
    _ref.read(paymentMethodProvider.notifier).state = method;
  }

  void toggleStep() {
    _ref.read(isStepTwoProvider.notifier).state = !_ref.read(isStepTwoProvider);
  }

  void updatePackageInfo(String key, String value) {
    final currentInfo = _ref.read(packageInfoProvider);
    _ref.read(packageInfoProvider.notifier).state = {
      ...currentInfo,
      key: value,
    };
  }

  void updateSenderInfo(String key, String value) {
    final currentInfo = _ref.read(senderInfoProvider);
    _ref.read(senderInfoProvider.notifier).state = {...currentInfo, key: value};
  }

  void updateReceiverInfo(String key, String value) {
    final currentInfo = _ref.read(receiverInfoProvider);
    _ref.read(receiverInfoProvider.notifier).state = {
      ...currentInfo,
      key: value,
    };
  }

  void updateSpecialInstructions(String instructions) {
    _ref.read(specialInstructionsProvider.notifier).state = instructions;
  }

  Future<void> submitDeliveryRequest() async {
    state = const RequestDeliveryLoading();

    try {
      final packageInfo = _ref.read(packageInfoProvider);
      final senderInfo = _ref.read(senderInfoProvider);
      final receiverInfo = _ref.read(receiverInfoProvider);
      final specialInstructions = _ref.read(specialInstructionsProvider);
      final paymentMethod = _ref.read(paymentMethodProvider);

      // Validate required fields
      if (packageInfo['name']?.isEmpty ?? true) {
        throw Exception('Package name is required');
      }
      if (packageInfo['weight']?.isEmpty ?? true) {
        throw Exception('Package weight is required');
      }
      if (senderInfo['name']?.isEmpty ?? true) {
        throw Exception('Sender name is required');
      }
      if (senderInfo['phone']?.isEmpty ?? true) {
        throw Exception('Sender phone is required');
      }
      if (receiverInfo['name']?.isEmpty ?? true) {
        throw Exception('Receiver name is required');
      }
      if (receiverInfo['address']?.isEmpty ?? true) {
        throw Exception('Delivery address is required');
      }

      // Parse weight
      final weight = double.tryParse(packageInfo['weight'] ?? '');
      if (weight == null || weight <= 0) {
        throw Exception('Invalid package weight');
      }

      // Get payment provider string
      final paymentProvider = _getPaymentProviderString(paymentMethod);

      await _createRequestDelivery(
        packageName: packageInfo['name']!,
        weight: weight,
        supplierId: packageInfo['supplierId'] ?? '',
        pickupDate: packageInfo['pickupDate'] ?? '',
        technicianName: senderInfo['name']!,
        technicianPhone: senderInfo['phone']!,
        deliveryAddress: receiverInfo['address']!,
        specialInstructions: specialInstructions,
        paymentProvider: paymentProvider,
      );

      state = const RequestDeliverySuccess(
        message: 'Request for Delivery created successfully',
      );
    } catch (e) {
      state = RequestDeliveryError(
        message: e.toString().replaceAll('Exception: ', ''),
      );
    }
  }

  String _getPaymentProviderString(int method) {
    switch (method) {
      case 0:
        return 'visa';
      case 1:
        return 'new_card';
      case 2:
        return 'paypal';
      default:
        return 'visa';
    }
  }

  Future<void> getSuppliers() async {
    state = const RequestDeliverySuppliersLoading();

    try {
      final suppliers = await _getSuppliers();
      state = RequestDeliverySuppliersSuccess(suppliers: suppliers);
    } catch (e) {
      state = RequestDeliverySuppliersError(
        message: e.toString().replaceAll('Exception: ', ''),
      );
    }
  }

  void resetState() {
    state = const RequestDeliveryInitial();
  }
}

// ---------------------------------------------------------------------------
// Providers
// ---------------------------------------------------------------------------

// Dependency injection providers
final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());

final requestDeliveryDatasourceProvider = Provider<RequestDeliveryDatasource>(
  (ref) =>
      RequestDeliveryDatasourceImpl(apiClient: ref.read(apiClientProvider)),
);

final requestDeliveryRepositoryProvider = Provider<RequestDeliveryRepository>(
  (ref) => RequestDeliveryRepositoryImpl(
    ref.read(requestDeliveryDatasourceProvider),
  ),
);

final getSuppliersProvider = Provider<GetSuppliers>(
  (ref) => GetSuppliers(ref.read(requestDeliveryRepositoryProvider)),
);

final createRequestDeliveryProvider = Provider<CreateRequestDelivery>(
  (ref) => CreateRequestDelivery(ref.read(requestDeliveryRepositoryProvider)),
);

final requestDeliveryNotifierProvider =
    StateNotifierProvider<RequestDeliveryNotifier, RequestDeliveryState>(
      (ref) => RequestDeliveryNotifier(
        getSuppliers: ref.read(getSuppliersProvider),
        createRequestDelivery: ref.read(createRequestDeliveryProvider),
        ref: ref,
      ),
    );

// ---------------------------------------------------------------------------
// Helper providers for form validation
// ---------------------------------------------------------------------------

final isFormValidProvider = Provider<bool>((ref) {
  final packageInfo = ref.watch(packageInfoProvider);
  final senderInfo = ref.watch(senderInfoProvider);
  final receiverInfo = ref.watch(receiverInfoProvider);

  // Check if required fields are filled
  final hasPackageName = packageInfo['name']?.isNotEmpty ?? false;
  final hasWeight = packageInfo['weight']?.isNotEmpty ?? false;
  final hasSenderName = senderInfo['name']?.isNotEmpty ?? false;
  final hasSenderPhone = senderInfo['phone']?.isNotEmpty ?? false;
  final hasReceiverName = receiverInfo['name']?.isNotEmpty ?? false;
  final hasReceiverAddress = receiverInfo['address']?.isNotEmpty ?? false;

  return hasPackageName &&
      hasWeight &&
      hasSenderName &&
      hasSenderPhone &&
      hasReceiverName &&
      hasReceiverAddress;
});

final deliveryDetailsProvider = Provider<Map<String, dynamic>>((ref) {
  final packageInfo = ref.watch(packageInfoProvider);
  final senderInfo = ref.watch(senderInfoProvider);
  final receiverInfo = ref.watch(receiverInfoProvider);
  final specialInstructions = ref.watch(specialInstructionsProvider);

  return {
    'package': packageInfo,
    'sender': senderInfo,
    'receiver': receiverInfo,
    'specialInstructions': specialInstructions,
  };
});

final suppliersProvider = Provider<List<SupplierEntity>?>((ref) {
  final state = ref.watch(requestDeliveryNotifierProvider);

  if (state is RequestDeliverySuppliersSuccess) {
    return state.suppliers;
  }

  return null;
});

final suppliersLoadingProvider = Provider<bool>((ref) {
  final state = ref.watch(requestDeliveryNotifierProvider);
  return state is RequestDeliverySuppliersLoading;
});

final suppliersErrorProvider = Provider<String?>((ref) {
  final state = ref.watch(requestDeliveryNotifierProvider);

  if (state is RequestDeliverySuppliersError) {
    return state.message;
  }

  return null;
});
