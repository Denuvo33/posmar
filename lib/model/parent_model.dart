class ParentModel {
  String name, addres, phone;

  ParentModel({required this.name, required this.addres, required this.phone});

  ParentModel.fromJson(Map<String, dynamic> json)
    : name = json['name'] ?? '',
      addres = json['addres'] ?? '',
      phone = json['phone'] ?? '';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['addres'] = addres;
    data['phone'] = phone;
    return data;
  }
}
