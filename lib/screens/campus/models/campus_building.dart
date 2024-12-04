class CampusBuilding {
  // Bu modeller, kampüs binalarını ve tesislerini temsil edecek.
  // bir binanın tüm temel özelliklerini
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double latitude;
  final double longitude;
  final String buildingCode;
  final List<String> departments;
  final List<String> facilities;
  final String floorCount;
  final String openingHours;

  CampusBuilding({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.latitude,
    required this.longitude,
    required this.buildingCode,
    this.departments = const [],
    this.facilities = const [],
    required this.floorCount,
    required this.openingHours,
  });

  // JSON dönüşümleri için factory constructor
  factory CampusBuilding.fromJson(Map<String, dynamic> json) {
    return CampusBuilding(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      buildingCode: json['buildingCode'] as String,
      departments: List<String>.from(json['departments'] ?? []),
      facilities: List<String>.from(json['facilities'] ?? []),
      floorCount: json['floorCount'] as String,
      openingHours: json['openingHours'] as String,
    );
  }

  // JSON'a dönüştürme metodu
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'latitude': latitude,
      'longitude': longitude,
      'buildingCode': buildingCode,
      'departments': departments,
      'facilities': facilities,
      'floorCount': floorCount,
      'openingHours': openingHours,
    };
  }
}
