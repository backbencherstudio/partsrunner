class SupplierEntity {
  final String id;
  final String name;
  final String contactNo;
  final String contactPerson;
  final String location;
  final String street;
  final String city;
  final String zipCode;
  final String status;
  final DateTime createdAt;

  SupplierEntity({
    required this.id,
    required this.name,
    required this.contactNo,
    required this.contactPerson,
    required this.location,
    required this.street,
    required this.city,
    required this.zipCode,
    required this.status,
    required this.createdAt,
  });
}
