import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partsrunner/core/widget/custom_dropdown.dart';
import 'package:partsrunner/core/widget/custom_text_fIeld.dart';
import 'package:partsrunner/features/request_delivery/domain/entities/supplier_entity.dart';
import 'package:partsrunner/features/request_delivery/presentation/providers/request_delivery_provider.dart';
import 'package:partsrunner/features/request_delivery/presentation/widgets/request_header.dart';

class StepOne extends ConsumerWidget {
  const StepOne({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final suppliers = ref.watch(suppliersProvider);
    final date = ref.watch(pickupDateProvider);
    final time = ref.watch(pickupTimeProvider);
    final suppliersLoading = ref.watch(suppliersLoadingProvider);
    final suppliersError = ref.watch(suppliersErrorProvider);

    // Use ref.watch for the controllers so they are kept alive
    final supplier = ref.watch(supplierProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RequestHeader(title: 'Package Info'),
        CustomTextField(
          hintText: 'Enter package name',
          label: 'Package Name',
          controller: ref.read(packageNameControllerProvider),
        ),
        CustomTextField(
          hintText: 'eg. 2.5',
          label: 'Weight',
          controller: ref.read(packageWeightControllerProvider),
        ),

        const SizedBox(height: 24),

        RequestHeader(title: 'Sender'),
        const Text(
          'Supply House Name',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),

        CustomDropdown<SupplierEntity>(
          hintText: 'Select supplier',
          isLoading: suppliersLoading,
          error: suppliersError,
          onReload: () =>
              ref.read(requestDeliveryNotifierProvider.notifier).getSuppliers(),
          items:
              suppliers
                  ?.map(
                    (supplier) => DropdownMenuItem(
                      value: supplier,
                      child: Text(supplier.name),
                    ),
                  )
                  .toList() ??
              [],
          onChanged: (value) {
            ref.read(supplierProvider.notifier).state = value;
          },
        ),

        CustomTextField(
          readOnly: true,
          hintText: 'Enter supply house address',
          label: 'Supply House Address',
          controller: supplier != null
              ? TextEditingController(
                  text:
                      "${supplier.location}, ${supplier.street}, ${supplier.city}, ${supplier.zipCode}",
                )
              : null,
        ),

        CustomTextField(
          readOnly: true,
          hintText: 'Enter counter person name',
          label: 'Counter Person Name',
          controller: supplier != null
              ? TextEditingController(text: supplier.contactPerson)
              : null,
        ),

        CustomTextField(
          readOnly: true,
          hintText: 'Jan 11, 2025',
          label: 'Pickup Date',
          suffix: GestureDetector(
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2101),
              );

              if (pickedDate != null) {
                ref.read(pickupDateProvider.notifier).state = pickedDate;
              }
            },
            child: const Icon(Icons.calendar_today_outlined),
          ),
          controller: TextEditingController(
            text: "${date.day}/${date.month}/${date.year}",
          ),
        ),
        CustomTextField(
          readOnly: true,
          hintText: '10:15 AM',
          label: 'Pickup Time',
          suffix: GestureDetector(
            onTap: () async {
              TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );

              if (pickedTime != null) {
                ref.read(pickupTimeProvider.notifier).state = pickedTime;
              }
            },
            child: const Icon(Icons.access_time),
          ),
          controller: TextEditingController(
            text: time.format(context),
          ),
        ),
      ],
    );
  }
}
