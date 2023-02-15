class Mfr {
  final int id;
  final String country;
  final String mfrName;

  Mfr({
    required this.id,
    required this.country,
    required this.mfrName,
  });

  factory Mfr.fromJson(Map<String, dynamic> json) {
    return Mfr(
      id: json['Mfr_ID'] as int,
      country: json['Country'] as String,
      mfrName: json['Mfr_Name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Mfr_ID': id,
      'Country': country,
      'Mfr_Name': mfrName,
    };
  }
}
