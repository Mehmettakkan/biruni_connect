import 'package:go_router/go_router.dart';
import 'package:biruni_connect/config/routes/route_names.dart';
import 'package:biruni_connect/screens/campus/campus_screen.dart';

List<RouteBase> getCampusRoutes() {
  return [
    GoRoute(
      path: RoutePath.campus,
      builder: (context, state) => const CampusScreen(),
      /* routes: [
        GoRoute(
          path: 'library',
          builder: (context, state) => const LibraryScreen(),
        ),
        GoRoute(
          path: 'cafeteria',
          builder: (context, state) => const CafeteriaScreen(),
        ),
        GoRoute(
          path: 'sports',
          builder: (context, state) => const SportsFacilitiesScreen(),
        ),
        GoRoute(
          path: 'transportation',
          builder: (context, state) => const TransportationScreen(),
        ),
        GoRoute(
          path: 'sports/:facilityId',
          builder: (context, state) {
            final facilityId = state.pathParameters['facilityId'];
            return SportsFacilityDetailScreen(id: facilityId);
          },
        ),
      ], */
    ),
  ];
}
