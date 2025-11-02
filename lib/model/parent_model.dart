class ParentModel {
  String name, addres, phone, key, created_at;

  ParentModel({
    required this.name,
    required this.addres,
    required this.phone,
    required this.key,
    required this.created_at,
  });

  ParentModel.fromJson(Map<String, dynamic> json)
    : name = json['name'] ?? '',
      addres = json['addres'] ?? '',
      phone = json['phone'] ?? '',
      key = json['key'] ?? '',
      created_at = json['created_at'] ?? '';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['addres'] = addres;
    data['phone'] = phone;
    data['key'] = key;
    data['created_at'] = created_at;
    return data;
  }
}
