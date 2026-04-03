import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partsrunner/core/constant/auth_method.dart';
import 'package:partsrunner/core/constant/user_role.dart';

final authMethodProvider = StateProvider<AuthMethod?>(
  (ref) => AuthMethod.email,
);

final rememberMeProvider = StateProvider<bool>((ref) => false);

final selectedRoleProvider = StateProvider<UserRole?>((ref) => null);
