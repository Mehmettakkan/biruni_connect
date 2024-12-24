class ContactInfo {
  final String address;
  final String phone;
  final String email;
  final String website;
  final Map<String, String> socialMedia; // Sosyal medya linkleri
  final Location location; // Konum bilgisi

  const ContactInfo({
    required this.address,
    required this.phone,
    required this.email,
    required this.website,
    required this.socialMedia,
    required this.location,
  });

  factory ContactInfo.fromJson(Map<String, dynamic> json) {
    return ContactInfo(
      address: json['address'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      website: json['website'] ?? '',
      socialMedia: Map<String, String>.from(json['socialMedia'] ?? {}),
      location: Location.fromJson(json['location'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'phone': phone,
      'email': email,
      'website': website,
      'socialMedia': socialMedia,
      'location': location.toJson(),
    };
  }
}

class Location {
  final double latitude;
  final double longitude;

  const Location({
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: json['latitude'] ?? 0.0,
      longitude: json['longitude'] ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
