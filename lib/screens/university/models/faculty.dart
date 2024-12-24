// faculty.dart
class Faculty {
  final String id;
  final String name;
  final String description;
  final List<String> programIds; // İlişkili programların ID'leri

  const Faculty({
    required this.id,
    required this.name,
    required this.description,
    required this.programIds,
  });

  factory Faculty.fromJson(Map<String, dynamic> json) {
    return Faculty(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      programIds: List<String>.from(json['programIds'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'programIds': programIds,
    };
  }
}
