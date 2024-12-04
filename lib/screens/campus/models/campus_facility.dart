class CampusFacility {
  // kampüsteki tesislerin (kütüphane, kafeterya vb.) özelliklerini tutar.

  final String id;
  final String name;
  final String description;
  final String iconName;
  final String location;
  final String openingHours;
  final String contactInfo;
  final List<String> services;
  final String buildingId;

  CampusFacility({
    required this.id,
    required this.name,
    required this.description,
    required this.iconName,
    required this.location,
    required this.openingHours,
    required this.contactInfo,
    this.services = const [],
    required this.buildingId,
  });

  // JSON dönüşümleri için factory constructor
  factory CampusFacility.fromJson(Map<String, dynamic> json) {
    return CampusFacility(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      iconName: json['iconName'] as String,
      location: json['location'] as String,
      openingHours: json['openingHours'] as String,
      contactInfo: json['contactInfo'] as String,
      services: List<String>.from(json['services'] ?? []),
      buildingId: json['buildingId'] as String,
    );
  }

  // JSON'a dönüştürme metodu
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'iconName': iconName,
      'location': location,
      'openingHours': openingHours,
      'contactInfo': contactInfo,
      'services': services,
      'buildingId': buildingId,
    };
  }
}
