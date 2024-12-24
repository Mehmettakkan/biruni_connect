import 'package:biruni_connect/config/routes/routes/auth_routes.dart';
import 'package:biruni_connect/config/routes/routes/campus_routes.dart';
import 'package:biruni_connect/config/routes/routes/events_routes.dart';
import 'package:biruni_connect/config/routes/routes/home_routes.dart';
import 'package:biruni_connect/config/routes/routes/university_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:biruni_connect/config/routes/route_names.dart';
import 'package:biruni_connect/screens/main/main_screen.dart';
import 'package:biruni_connect/screens/splash/splash_screen.dart';

/// Uygulamanın ana yönlendirme yapılandırma sınıfı
/// Tüm sayfa yönlendirmelerini ve kimlik doğrulama kontrollerini yönetir
class AppRouter {
  /// Ana router örneğini oluşturur ve yapılandırır
  /// Kimlik doğrulama kontrolleri ve sayfa tanımlamalarını içerir
  static final GoRouter router = GoRouter(
    // Başlangıç sayfası olarak splash ekranını ayarla
    initialLocation: RoutePath.splash,
    // Geliştirme sürecinde hata ayıklama loglarını aktif et
    debugLogDiagnostics: true,

    /// Kimlik doğrulama durumuna göre yönlendirmeleri yöneten fonksiyon
    /// Kullanıcının giriş durumuna göre sayfa erişimlerini kontrol eder
    redirect: (context, state) {
      // Kullanıcının giriş yapıp yapmadığını kontrol et
      final isLoggedIn = FirebaseAuth.instance.currentUser != null;
      // Kullanıcının giriş veya kayıt sayfalarına gitmeye çalışıp çalışmadığını kontrol et
      final isGoingToAuth = state.fullPath == RoutePath.login ||
          state.fullPath == RoutePath.register;
      // Kullanıcının profil sayfasına gitmeye çalışıp çalışmadığını kontrol et
      final isGoingToProfile = state.fullPath == RoutePath.profile;

      // Giriş yapmamış kullanıcı profil sayfasına erişmeye çalışırsa giriş sayfasına yönlendir
      if (!isLoggedIn && isGoingToProfile) {
        return RoutePath.login;
      }

      // Giriş yapmamış kullanıcıyı giriş sayfasına yönlendir
      if (!isLoggedIn && !isGoingToAuth) {
        return RoutePath.login;
      }

      // Giriş yapmış kullanıcı, giriş/kayıt sayfalarına erişmeye çalışırsa ana sayfaya yönlendir
      if (isLoggedIn && isGoingToAuth) {
        return RoutePath.home;
      }

      // Yönlendirme gerekmiyorsa null dön
      return null;
    },

    /// Uygulamanın sayfa hiyerarşisini tanımla
    routes: [
      // Başlangıç splash ekranı rotası
      GoRoute(
        path: RoutePath.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      // Kimlik doğrulama sayfaları (giriş, kayıt vb.)
      ...getAuthRoutes(),

      /// Ana uygulama kabuğu rotası
      /// Alt sayfaları ana uygulama düzeni içinde gösterir
      ShellRoute(
        builder: (context, state, child) => MainScreen(child: child),
        routes: [
          // Ana özellik sayfaları
          ...getHomeRoutes(), // Ana sayfa ve ilgili sayfalar
          ...getUniversityRoutes(), // Üniversite ile ilgili sayfalar
          ...getCampusRoutes(), // Kampüs ile ilgili sayfalar
          ...getEventsRoutes(), // Etkinlik yönetimi sayfaları
        ],
      ),
    ],
    // TODO: Özel hata sayfası eklenecek
    //errorBuilder: (context, state) => const NotFoundScreen(),
  );
}
