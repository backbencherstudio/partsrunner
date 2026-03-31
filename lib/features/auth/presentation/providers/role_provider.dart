import 'package:flutter_riverpod/flutter_riverpod.dart';
enum UserRole { contractor, runner }

final selectedRoleProvider = StateProvider<UserRole?>((ref) => UserRole.runner);
