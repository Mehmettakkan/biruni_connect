class News {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String route;
  final DateTime date;

  News({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.route,
    required this.date,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      route: json['route'] as String,
      date: DateTime.parse(json['date'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'route': route,
      'date': date.toIso8601String(),
    };
  }
}
