class Contractor {
  String? id;
  String? companyName;
  String? businessAddress;

  Contractor({this.id, this.companyName, this.businessAddress});

  Contractor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
    businessAddress = json['business_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['company_name'] = companyName;
    data['business_address'] = businessAddress;
    return data;
  }
}
