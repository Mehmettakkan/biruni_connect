// lib/config/routes/routes/home_routes.dart

import 'package:biruni_connect/screens/home/home_screen.dart';
import 'package:biruni_connect/screens/home/sections/announcement_detail.dart';
import 'package:go_router/go_router.dart';
import '../route_names.dart';

List<RouteBase> getHomeRoutes() {
  return [
    GoRoute(
      path: RoutePath.home,
      builder: (context, state) => const HomeScreen(),
      routes: [
        // Duyurular için route
        GoRoute(
          path: 'announcement/:id',
          builder: (context, state) {
            final announcementId = state.pathParameters['id'];
            return AnnouncementDetail(id: announcementId);
          },
        ),
        /*// Etkinlikler için route
        GoRoute(
          path: 'event/:id',
          builder: (context, state) {
            final eventId = state.pathParameters['id'];
            return EventDetailScreen(id: eventId);
          },
        ),
        // Haberler için route
        GoRoute(
          path: 'news/:id',
          builder: (context, state) {
            final newsId = state.pathParameters['id'];
            return NewsDetailScreen(id: newsId);
          },
        ),*/
      ],
    ),
  ];
}
