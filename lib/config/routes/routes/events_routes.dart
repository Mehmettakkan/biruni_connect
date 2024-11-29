import 'package:go_router/go_router.dart';
import 'package:biruni_connect/config/routes/route_names.dart';
import 'package:biruni_connect/screens/events/events_screen.dart';

List<RouteBase> getEventsRoutes() {
  return [
    GoRoute(
      path: RoutePath.events,
      builder: (context, state) => const EventsScreen(),
      /* routes: [
        GoRoute(
          path: 'detail/:eventId',
          builder: (context, state) {
            final eventId = state.pathParameters['eventId'];
            return EventDetailScreen(id: eventId);
          },
        ),
        GoRoute(
          path: 'calendar',
          builder: (context, state) => const CalendarScreen(),
        ),
        GoRoute(
          path: 'category/:categoryId',
          builder: (context, state) {
            final categoryId = state.pathParameters['categoryId'];
            return CategoryEventsScreen(categoryId: categoryId);
          },
        ),
        GoRoute(
          path: 'register/:eventId',
          builder: (context, state) {
            final eventId = state.pathParameters['eventId'];
            return EventRegistrationScreen(eventId: eventId);
          },
        ),
      ], */
    ),
  ];
}
