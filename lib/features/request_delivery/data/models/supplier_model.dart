import 'package:partsrunner/features/request_delivery/domain/entities/supplier_entity.dart';

class SupplierModel extends SupplierEntity {
  SupplierModel({
    required super.id,
    required super.name,
    required super.contactNo,
    required super.contactPerson,
    required super.location,
    required super.street,
    required super.city,
    required super.zipCode,
    required super.status,
    required super.createdAt,
  });

  // FROM JSON
  factory SupplierModel.fromJson(Map<String, dynamic> json) {
    return SupplierModel(
      id: json['id'],
      name: json['name'],
      contactNo: json['contact_no'],
      contactPerson: json['contact_persion'], // keep API key as-is
      location: json['location'],
      street: json['street'],
      city: json['city'],
      zipCode: json['zip_code'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  // TO JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'contact_no': contactNo,
      'contact_persion': contactPerson,
      'location': location,
      'street': street,
      'city': city,
      'zip_code': zipCode,
      'status': status,
      'created_at': createdAt.toIso8601String(),
    };
  }

  static List<SupplierModel> supplierModelListFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => SupplierModel.fromJson(json)).toList();
  }
}
