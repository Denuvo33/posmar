class ChildrenModel {
  String name,
      dateBorn,
      lingkarKepala,
      beratBadan,
      tinggiBadan,
      lingkarLengan,
      key,
      createdAt,
      keterangan;

  ChildrenModel({
    required this.name,
    required this.dateBorn,
    required this.createdAt,
    required this.lingkarKepala,
    required this.beratBadan,
    required this.key,
    required this.tinggiBadan,
    required this.lingkarLengan,
    required this.keterangan,
  });

  factory ChildrenModel.fromJson(Map<String, dynamic> json) {
    return ChildrenModel(
      name: json['name'] ?? '',
      createdAt: json['created_At'] ?? '',
      key: json['key'] ?? '',
      dateBorn: json['dateBorn'] ?? '',
      lingkarKepala: json['lingkarKepala'] ?? '',
      beratBadan: json['beratBadan'] ?? '',
      tinggiBadan: json['tinggiBadan'] ?? '',
      lingkarLengan: json['lingkarLengan'] ?? '',
      keterangan: json['keterangan'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dateBorn': dateBorn,
      'lingkarKepala': lingkarKepala,
      'beratBadan': beratBadan,
      'tinggiBadan': tinggiBadan,
      'lingkarLengan': lingkarLengan,
      'keterangan': keterangan,

      'created_At': DateTime.now().toString(),
    };
  }
}
