import 'package:partsrunner/core/constant/user_role.dart';

/// Pure domain entity — no dependency on Flutter, http, or any external package.
/// This is the single source of truth for what a "User" means in the business logic.
class UserEntity {
  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    this.profileImageUrl,
    this.companyName,
    this.businessAddress,
    this.vehicleType,
    this.vehicleModel,
    this.vehicleIdentificationNumber,
  });

  final String id;
  final String name;
  final String email;
  final String phone;
  final UserRole role;

  // Optional fields — populated based on role
  final String? profileImageUrl;

  // Contractor-specific
  final String? companyName;
  final String? businessAddress;

  // Runner-specific
  final String? vehicleType;
  final String? vehicleModel;
  final String? vehicleIdentificationNumber;

  bool get isContractor => role == UserRole.contractor;
  bool get isRunner => role == UserRole.runner;

  UserEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    UserRole? role,
    String? profileImageUrl,
    String? companyName,
    String? businessAddress,
    String? vehicleType,
    String? vehicleModel,
    String? vehicleIdentificationNumber,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      companyName: companyName ?? this.companyName,
      businessAddress: businessAddress ?? this.businessAddress,
      vehicleType: vehicleType ?? this.vehicleType,
      vehicleModel: vehicleModel ?? this.vehicleModel,
      vehicleIdentificationNumber:
          vehicleIdentificationNumber ?? this.vehicleIdentificationNumber,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is UserEntity && other.id == id);

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'UserEntity(id: $id, name: $name, email: $email, role: $role)';
}
