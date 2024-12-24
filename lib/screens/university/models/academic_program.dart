// academic_program.dart
class AcademicProgram {
  final String id;
  final String name;
  final String description;
  final String facultyId; // Bağlı olduğu fakültenin ID'si
  final String duration; // Örn: "4 yıl"
  final String degree; // Örn: "Lisans"
  final String language; // Eğitim dili

  const AcademicProgram({
    required this.id,
    required this.name,
    required this.description,
    required this.facultyId,
    required this.duration,
    required this.degree,
    required this.language,
  });

  factory AcademicProgram.fromJson(Map<String, dynamic> json) {
    return AcademicProgram(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      facultyId: json['facultyId'] ?? '',
      duration: json['duration'] ?? '',
      degree: json['degree'] ?? '',
      language: json['language'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'facultyId': facultyId,
      'duration': duration,
      'degree': degree,
      'language': language,
    };
  }
}
