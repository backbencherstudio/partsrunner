import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partsrunner/core/provider/api_client_provider.dart';
import 'package:partsrunner/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:partsrunner/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:partsrunner/features/profile/domain/repositories/profile_repository.dart';
import 'package:partsrunner/features/profile/domain/usecases/change_password_usecase.dart';

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

final _profileRemoteDatasourceProvider = Provider<ProfileRemoteDatasource>(
  (ref) => ProfileRemoteDatasourceImpl(ref.watch(apiClientProvider)),
);

final _profileRepositoryProvider = Provider<ProfileRepository>(
  (ref) => ProfileRepositoryImpl(ref.watch(_profileRemoteDatasourceProvider)),
);

final _changePasswordUsecase = Provider<ChangePasswordUsecase>(
  (ref) => ChangePasswordUsecase(ref.watch(_profileRepositoryProvider)),
);
