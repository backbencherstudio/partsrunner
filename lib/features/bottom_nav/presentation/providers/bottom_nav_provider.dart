import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partsrunner/core/constant/user_role.dart';
import 'package:shared_preferences/shared_preferences.dart';

final bottomNavProvider = StateProvider<int>((ref) => 0);

final userRoleProvider = FutureProvider<UserRole>((ref) async {
  final pref = await SharedPreferences.getInstance();
  final roleString = pref.getString("userRole");

  return UserRole.values.firstWhere(
    (e) => e.name == roleString,
    orElse: () => UserRole.contractor,
  );
});
