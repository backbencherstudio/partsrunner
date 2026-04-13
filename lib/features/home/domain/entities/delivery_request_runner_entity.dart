class DeliveryRequestRunnerEntity {
  final int id;
  final String orderId;
  final String pickupAddress;
  final String deliveryAddress;
  final String status;
  final double price;
  final String createdAt;
  final String updatedAt;

  DeliveryRequestRunnerEntity({
    required this.id,
    required this.orderId,
    required this.pickupAddress,
    required this.deliveryAddress,
    required this.status,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DeliveryRequestRunnerEntity.fromJson(Map<String, dynamic> json) {
    return DeliveryRequestRunnerEntity(
      id: json['id'],
      orderId: json['order_id'],
      pickupAddress: json['pickup_address'],
      deliveryAddress: json['delivery_address'],
      status: json['status'],
      price: json['price'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
