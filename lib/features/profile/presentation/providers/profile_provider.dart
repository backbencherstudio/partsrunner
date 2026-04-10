import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nameControllerProvider = Provider<TextEditingController>(
  (ref) => TextEditingController(),
);
final emailControllerProvider = Provider<TextEditingController>(
  (ref) => TextEditingController(),
);
final countryCodeControllerProvider = Provider<TextEditingController>(
  (ref) => TextEditingController(),
);
final phoneControllerProvider = Provider<TextEditingController>(
  (ref) => TextEditingController(),
);
final vehicleTypeControllerProvider = Provider<TextEditingController>(
  (ref) => TextEditingController(),
);
final vehicleModelControllerProvider = Provider<TextEditingController>(
  (ref) => TextEditingController(),
);
final vehicleIDNumberControllerProvider = Provider<TextEditingController>(
  (ref) => TextEditingController(),
);
final companyNameControllerProvider = Provider<TextEditingController>(
  (ref) => TextEditingController(),
);
final locationControllerProvider = Provider<TextEditingController>(
  (ref) => TextEditingController(),
);
final stateControllerProvider = Provider<TextEditingController>(
  (ref) => TextEditingController(),
);
final cityControllerProvider = Provider<TextEditingController>(
  (ref) => TextEditingController(),
);
final zipCodeControllerProvider = Provider<TextEditingController>(
  (ref) => TextEditingController(),
);

