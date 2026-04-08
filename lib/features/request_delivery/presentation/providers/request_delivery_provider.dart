import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partsrunner/features/request_delivery/domain/entities/supplier_entity.dart';
import 'package:partsrunner/features/request_delivery/domain/usecases/get_suppliers.dart';
import 'package:partsrunner/features/request_delivery/domain/usecases/create_request_delivery.dart';
import 'package:partsrunner/features/request_delivery/domain/repositories/request_delivery_repository.dart';
import 'package:partsrunner/features/request_delivery/data/repositories/request_delivery_repository_impl.dart';
import 'package:partsrunner/features/request_delivery/data/datasources/request_delivery_remote_datasource.dart';
import 'package:partsrunner/core/api_service/api_client.dart';

// ---------------------------------------------------------------------------
// UI state providers
// ---------------------------------------------------------------------------

final paymentMethodProvider = StateProvider<int>((ref) => 0);
final isStepTwoProvider = StateProvider<bool>((ref) => false);
final supplierProvider = StateProvider<SupplierEntity?>((ref) => null);

// ---------------------------------------------------------------------------
// TextEditingControllers
// ---------------------------------------------------------------------------

final packageNameControllerProvider = Provider<TextEditingController>(
  (ref) => TextEditingController(),
);
final packageWeightControllerProvider = Provider<TextEditingController>(
  (ref) => TextEditingController(),
);
final pickupDateControllerProvider = Provider<TextEditingController>(
  (ref) => TextEditingController(),
);
final pickupTimeControllerProvider = Provider<TextEditingController>(
  (ref) => TextEditingController(),
);
final technicianNameControllerProvider = Provider<TextEditingController>(
  (ref) => TextEditingController(),
);
final technicianPhoneControllerProvider = Provider<TextEditingController>(
  (ref) => TextEditingController(),
);
final deliveryAddressControllerProvider = Provider<TextEditingController>(
  (ref) => TextEditingController(),
);
final specialInstructionsControllerProvider = Provider<TextEditingController>(
  (ref) => TextEditingController(),
);
final paymentProviderControllerProvider = Provider<TextEditingController>(
  (ref) => TextEditingController(),
);

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

  Future<void> submitDeliveryRequest() async {
    state = const RequestDeliveryLoading();

    try {
      final paymentMethod = _ref.read(paymentMethodProvider);

      // Get payment provider string
      final paymentProvider = _getPaymentProviderString(paymentMethod);

      await _createRequestDelivery(
        packageName: _ref.read(packageNameControllerProvider).text,
        weight: double.parse(_ref.read(packageWeightControllerProvider).text),
        supplierId: _ref.read(supplierProvider)?.id ?? '',
        pickupDate:
            _ref.read(pickupDateControllerProvider).text +
            _ref.read(pickupTimeControllerProvider).text,
        technicianName: _ref.read(technicianNameControllerProvider).text,
        technicianPhone: _ref.read(technicianPhoneControllerProvider).text,
        deliveryAddress: _ref.read(deliveryAddressControllerProvider).text,
        specialInstructions: _ref
            .read(specialInstructionsControllerProvider)
            .text,
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
        return 'stripe';
      case 1:
        return 'stripe'; // Add New Card - still uses Stripe
      case 2:
        return 'paypal';
      default:
        return 'stripe';
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

  void submit() {
    print("""
Request Delivery Submission:
- Package Name: ${_ref.read(packageNameControllerProvider).text}
- Package Weight: ${_ref.read(packageWeightControllerProvider).text}
- Supplier ID: ${_ref.read(supplierProvider)?.id}
- Pickup Date: ${_ref.read(pickupDateControllerProvider).text} ${_ref.read(pickupTimeControllerProvider).text}
- Technician Name: ${_ref.read(technicianNameControllerProvider).text}
- Technician Phone: ${_ref.read(technicianPhoneControllerProvider).text}
- Delivery Address: ${_ref.read(deliveryAddressControllerProvider).text}
- Special Instructions: ${_ref.read(specialInstructionsControllerProvider).text}
- Payment Provider: ${_getPaymentProviderString(_ref.read(paymentMethodProvider))}
""");
  }

  void resetState() {
    state = const RequestDeliveryInitial();
  }

  @override
  void dispose() {
    // Dispose all TextEditingControllers
    _ref.read(packageNameControllerProvider).dispose();
    _ref.read(packageWeightControllerProvider).dispose();
    _ref.read(technicianNameControllerProvider).dispose();
    _ref.read(technicianPhoneControllerProvider).dispose();
    _ref.read(deliveryAddressControllerProvider).dispose();
    _ref.read(specialInstructionsControllerProvider).dispose();
    _ref.read(paymentProviderControllerProvider).dispose();
    super.dispose();
  }
}

// ---------------------------------------------------------------------------
// Providers
// ---------------------------------------------------------------------------

// Dependency injection providers
final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());

final requestDeliveryDatasourceProvider = Provider<RequestDeliveryRemoteDatasource>(
  (ref) =>
      RequestDeliveryRemoteDatasourceImpl(apiClient: ref.read(apiClientProvider)),
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
