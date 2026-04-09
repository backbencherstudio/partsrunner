class BottomNavEntity {
  final String id;
  final String name;
  final String email;
  final String? avatar;
  final String countryCode;
  final String phoneNumber;
  final String type;
  final String? gender;
  final DateTime? dateOfBirth;
  final DateTime createdAt;

  const BottomNavEntity({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
    required this.countryCode,
    required this.phoneNumber,
    required this.type,
    this.gender,
    this.dateOfBirth,
    required this.createdAt,
  });
}