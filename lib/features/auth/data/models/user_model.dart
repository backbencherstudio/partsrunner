import 'package:partsrunner/core/constant/user_role.dart';
import 'package:partsrunner/features/auth/domain/entities/user_entity.dart';

/// Data-layer model that extends [UserEntity] and knows how to
/// serialize/deserialize itself from JSON (API response).
///
/// Rule: only the data layer knows about JSON — the domain layer stays clean.
class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.phone,
    required super.role,
    super.profileImageUrl,
    super.companyName,
    super.businessAddress,
    super.vehicleType,
    super.vehicleModel,
    super.vehicleIdentificationNumber,
  });

  // ---------------------------------------------------------------------------
  // JSON deserialization — used when parsing an API response
  // ---------------------------------------------------------------------------

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      role: UserRole.values.firstWhere(
        (e) => e.name == (json['role'] as String? ?? ''),
        orElse: () => UserRole.contractor,
      ),
      profileImageUrl: json['profileImageUrl'] as String?,
      companyName: json['companyName'] as String?,
      businessAddress: json['businessAddress'] as String?,
      vehicleType: json['vehicleType'] as String?,
      vehicleModel: json['vehicleModel'] as String?,
      vehicleIdentificationNumber:
          json['vehicleIdentificationNumber'] as String?,
    );
  }

  // ---------------------------------------------------------------------------
  // JSON serialization — used when sending data to the API
  // ---------------------------------------------------------------------------

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role.name,
      if (profileImageUrl != null) 'profileImageUrl': profileImageUrl,
      if (companyName != null) 'companyName': companyName,
      if (businessAddress != null) 'businessAddress': businessAddress,
      if (vehicleType != null) 'vehicleType': vehicleType,
      if (vehicleModel != null) 'vehicleModel': vehicleModel,
      if (vehicleIdentificationNumber != null)
        'vehicleIdentificationNumber': vehicleIdentificationNumber,
    };
  }

  // ---------------------------------------------------------------------------
  // Convert from domain entity → model (e.g. before saving to local cache)
  // ---------------------------------------------------------------------------

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      phone: entity.phone,
      role: entity.role,
      profileImageUrl: entity.profileImageUrl,
      companyName: entity.companyName,
      businessAddress: entity.businessAddress,
      vehicleType: entity.vehicleType,
      vehicleModel: entity.vehicleModel,
      vehicleIdentificationNumber: entity.vehicleIdentificationNumber,
    );
  }

  @override
  String toString() =>
      'UserModel(id: $id, name: $name, email: $email, role: $role)';
}
