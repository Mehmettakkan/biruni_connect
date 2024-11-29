import 'package:go_router/go_router.dart';
import 'package:biruni_connect/config/routes/route_names.dart';
import 'package:biruni_connect/screens/university/university_screen.dart';

List<RouteBase> getUniversityRoutes() {
  return [
    GoRoute(
      path: RoutePath.university,
      builder: (context, state) => const UniversityScreen(),
      /* routes: [
        GoRoute(
          path: 'about',
          builder: (context, state) => const AboutScreen(),
        ),
        GoRoute(
          path: 'mission',
          builder: (context, state) => const MissionScreen(),
        ),
        GoRoute(
          path: 'management',
          builder: (context, state) => const ManagementScreen(),
        ),
      ], */
    ),
  ];
}
