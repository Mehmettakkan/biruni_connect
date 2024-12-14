import 'package:go_router/go_router.dart';
import 'package:biruni_connect/config/routes/route_names.dart';
import 'package:biruni_connect/screens/university/university_screen.dart';

List<RouteBase> getUniversityRoutes() {
  return [
    GoRoute(
      path: RoutePath.university,
      builder: (context, state) => const UniversityScreen(),
      routes: [
        /* GoRoute(
          path: 'faculty/:id',
          builder: (context, state) {
            final facultyId = state.pathParameters['id']!;
            return FacultyDetailScreen(facultyId: facultyId);
          },
        ),
        GoRoute(
          path: 'program/:id',
          builder: (context, state) {
            final programId = state.pathParameters['id']!;
            return ProgramDetailScreen(programId: programId);
          },
        ), */
      ],
    ),
  ];
}
