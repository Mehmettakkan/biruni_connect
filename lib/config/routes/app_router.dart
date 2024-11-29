// lib/config/routes/app_router.dart
import 'package:biruni_connect/config/routes/routes/campus_routes.dart';
import 'package:biruni_connect/config/routes/routes/events_routes.dart';
import 'package:biruni_connect/config/routes/routes/home_routes.dart';
import 'package:biruni_connect/config/routes/routes/university_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:biruni_connect/config/routes/route_names.dart';
import 'package:biruni_connect/screens/main/main_screen.dart';
import 'package:biruni_connect/screens/splash/splash_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RoutePath.splash,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: RoutePath.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => MainScreen(child: child),
        routes: [
          ...getHomeRoutes(),
          ...getUniversityRoutes(),
          ...getCampusRoutes(),
          ...getEventsRoutes(),
        ],
      ),
    ],
    //errorBuilder: (context, state) => const NotFoundScreen(),
  );
}
