import 'package:biruni_connect/screens/home/home_screen.dart';
import 'package:biruni_connect/screens/home/widgets/content_list_view.dart';
import 'package:biruni_connect/screens/home/widgets/content_details_view.dart';
import 'package:go_router/go_router.dart';
import '../route_names.dart';

List<RouteBase> getHomeRoutes() {
  return [
    GoRoute(
      path: RoutePath.home,
      builder: (context, state) => const HomeScreen(),
      routes: [
        // Duyurular için routes
        GoRoute(
          path: 'announcements',
          builder: (context, state) => const ContentListView(
            contentType: 'announcements',
            isFullScreen: true,
          ),
        ),
        GoRoute(
          path: 'announcements/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return ContentDetailsView(id: id);
          },
        ),

        // Haberler için routes
        GoRoute(
          path: 'news',
          builder: (context, state) => const ContentListView(
            contentType: 'news',
            isFullScreen: true,
          ),
        ),
        GoRoute(
          path: 'news/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return ContentDetailsView(id: id);
          },
        ),
      ],
    ),
  ];
}
