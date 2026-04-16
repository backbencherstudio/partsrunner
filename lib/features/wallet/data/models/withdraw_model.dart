class WithdrawModel {
  String? id;
  String? runnerId;
  int? amount;
  String? status;
  String? stripeTransferId;
  DateTime? createdAt;
  DateTime? updatedAt;

  WithdrawModel(
      {this.id,
      this.runnerId,
      this.amount,
      this.status,
      this.stripeTransferId,
      this.createdAt,
      this.updatedAt});

  WithdrawModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    runnerId = json['runner_id'];
    amount = json['amount'];
    status = json['status'];
    stripeTransferId = json['stripe_transfer_id'];
    createdAt = DateTime.tryParse(json['created_at']);
    updatedAt = DateTime.tryParse(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['runner_id'] = runnerId;
    data['amount'] = amount;
    data['status'] = status;
    data['stripe_transfer_id'] = stripeTransferId;
    data['created_at'] = createdAt?.toIso8601String();
    data['updated_at'] = updatedAt?.toIso8601String();
    return data;
  }
}
