import 'package:partsrunner/features/bottom_nav/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    super.avatar,
    required super.countryCode,
    required super.phoneNumber,
    required super.type,
    super.gender,
    super.dateOfBirth,
    required super.createdAt,
  });

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      avatar: entity.avatar,
      countryCode: entity.countryCode,
      phoneNumber: entity.phoneNumber,
      type: entity.type,
      gender: entity.gender,
      dateOfBirth: entity.dateOfBirth,
      createdAt: entity.createdAt,
    );
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? avatar,
    String? countryCode,
    String? phoneNumber,
    String? type,
    String? gender,
    DateTime? dateOfBirth,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      countryCode: countryCode ?? this.countryCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      type: type ?? this.type,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatar: json['avatar'],
      countryCode: json['country_code'],
      phoneNumber: json['phone_number'],
      type: json['type'],
      gender: json['gender'],
      dateOfBirth: json['date_of_birth'] != null
          ? DateTime.parse(json['date_of_birth'])
          : null,
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
