class UniversityInfo {
  final String mission;
  final String vision;
  final String history;
  final String name;
  final String foundationYear;

  const UniversityInfo({
    required this.mission,
    required this.vision,
    required this.history,
    required this.name,
    required this.foundationYear,
  });

  // JSON'dan model oluşturma
  factory UniversityInfo.fromJson(Map<String, dynamic> json) {
    return UniversityInfo(
      mission: json['mission'] ?? '',
      vision: json['vision'] ?? '',
      history: json['history'] ?? '',
      name: json['name'] ?? '',
      foundationYear: json['foundationYear'] ?? '',
    );
  }

  // Model'den JSON oluşturma
  Map<String, dynamic> toJson() {
    return {
      'mission': mission,
      'vision': vision,
      'history': history,
      'name': name,
      'foundationYear': foundationYear,
    };
  }
}
