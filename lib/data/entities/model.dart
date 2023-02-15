class Model {
  final int id;
  final String name;

  Model({
    required this.id,
    required this.name,
  });

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      id: json['Model_ID'] as int,
      name: json['Model_Name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Model_ID': id,
      'Model_Name': name,
    };
  }
}
