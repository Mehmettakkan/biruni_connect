import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:biruni_connect/config/routes/route_names.dart';

/// Uygulama içindeki sayfa yönlendirmelerini ve kimlik doğrulama durumunu kontrol eden sınıf
/// Bu sınıf, kullanıcının oturum durumuna göre sayfa erişimlerini ve yönlendirmelerini yönetir
class AuthGuard {
  /// Kullanıcının kimlik doğrulama durumunu kontrol eder
  ///
  /// [context]: BuildContext, yönlendirme işlemleri için gerekli
  ///
  /// Returns:
  /// - true: Kullanıcı giriş yapmışsa
  /// - false: Kullanıcı giriş yapmamışsa (bu durumda login sayfasına yönlendirilir)
  ///
  /// Örnek kullanım:
  /// ```dart
  /// if (!AuthGuard.checkAuth(context)) {
  ///   return; // Kullanıcı giriş yapmamışsa işlemi sonlandır
  /// }
  /// ```
  static bool checkAuth(BuildContext context) {
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;

    if (!isLoggedIn) {
      context
          .go(RoutePath.login); // Giriş yapmamış kullanıcıyı login'e yönlendir
      return false;
    }

    return true;
  }

  /// Sayfa yönlendirmelerini kullanıcının oturum durumuna göre yönetir
  /// Go Router redirect callback'i olarak kullanılır
  ///
  /// Parameters:
  /// [context]: BuildContext, yönlendirme işlemleri için gerekli
  /// [state]: GoRouterState, mevcut rota durumu
  ///
  /// Returns:
  /// - String?: Yönlendirilecek yeni rota
  /// - null: Yönlendirme gerekmiyorsa
  ///
  /// Yönlendirme kuralları:
  /// 1. Giriş yapmamış kullanıcı korumalı sayfaya erişmeye çalışırsa -> login
  /// 2. Giriş yapmış kullanıcı auth sayfalarına erişmeye çalışırsa -> home
  /// 3. Diğer durumlarda -> null (yönlendirme yok)
  static String? handleRedirect(BuildContext context, GoRouterState state) {
    // Kullanıcının oturum durumunu kontrol et
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;

    // Kullanıcının gitmeye çalıştığı sayfa auth sayfası mı?
    final isGoingToAuth = state.fullPath == RoutePath.login ||
        state.fullPath == RoutePath.register;

    // Kural 1: Giriş yapmamış kullanıcı korumalı sayfaya erişmeye çalışıyorsa
    if (!isLoggedIn && !isGoingToAuth) {
      return RoutePath.login;
    }

    // Kural 2: Giriş yapmış kullanıcı auth sayfalarına erişmeye çalışıyorsa
    if (isLoggedIn && isGoingToAuth) {
      return RoutePath.home;
    }

    // Kural 3: Diğer durumlarda yönlendirme yapma
    return null;
  }
}
