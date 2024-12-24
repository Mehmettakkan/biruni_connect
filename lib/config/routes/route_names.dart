class RoutePath {
  // Ana sayfalar
  static const String splash = '/splash';
  static const String home = '/';
  static const String university = '/university';
  static const String campus = '/campus';
  static const String events = '/events';

  // University detay sayfaları
  static const String facultyDetail = '/university/faculty/:id';
  static const String programDetail = '/university/program/:id';

  // Campus detay sayfaları
  static const String buildingDetail = '/campus/building/:id';
  static const String facilityDetail = '/campus/facility/:id';

  // Events detay sayfaları
  static const String eventDetail = '/events/:id';

  // Content detay sayfaları
  static const String announcements = '/announcements';
  static const String news = '/news';

  // Auth paths
  static const String login = '/login';
  static const String register = '/register';
  static const String profile = '/profile';
}
