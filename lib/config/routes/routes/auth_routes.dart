import 'package:biruni_connect/config/routes/route_names.dart';
import 'package:biruni_connect/screens/auth/login_screen.dart';
import 'package:biruni_connect/screens/auth/profile_screen.dart';
import 'package:biruni_connect/screens/auth/register_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Kimlik doğrulama ile ilgili route'ları içeren fonksiyon.
/// Profil, giriş ve kayıt sayfalarının route'larını tanımlar.
List<RouteBase> getAuthRoutes() {
  return [
    // Profil sayfası route'u
    GoRoute(
      path: RoutePath.profile,
      builder: (context, state) => const ProfileScreen(),
    ),

    // Giriş sayfası route'u
    GoRoute(
      path: RoutePath.login,
      name: 'login',
      builder: (context, state) => const LoginScreen(),
      redirect: (context, state) {
        // Eğer kullanıcı zaten giriş yapmışsa,
        // login sayfasına erişmeye çalıştığında ana sayfaya yönlendirilir
        if (FirebaseAuth.instance.currentUser != null) {
          return RoutePath.home;
        }
        return null; // Giriş yapmamışsa login sayfasına devam et
      },
    ),

    // Kayıt sayfası route'u
    GoRoute(
      path: RoutePath.register,
      name: 'register',
      builder: (context, state) => const RegisterScreen(),
      redirect: (context, state) {
        // Eğer kullanıcı zaten giriş yapmışsa,
        // kayıt sayfasına erişmeye çalıştığında ana sayfaya yönlendirilir
        if (FirebaseAuth.instance.currentUser != null) {
          return RoutePath.home;
        }
        return null; // Giriş yapmamışsa kayıt sayfasına devam et
      },
    ),
  ];
}
