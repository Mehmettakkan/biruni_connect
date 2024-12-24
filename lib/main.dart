import 'package:biruni_connect/config/routes/app_router.dart';
import 'package:biruni_connect/core/theme/app_theme.dart';
import 'package:biruni_connect/screens/auth/services/auth_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';

/// Uygulamanın başlangıç noktası
/// Gerekli servisleri ve yapılandırmaları başlatır
void main() async {
  try {
    // Flutter widget sistemini başlat
    WidgetsFlutterBinding.ensureInitialized();

    // Firebase servislerini başlat
    await Firebase.initializeApp();

    // Türkçe tarih formatı için gerekli yapılandırma
    await initializeDateFormatting('tr_TR', null);

    // Kimlik doğrulama tercihlerini yükle
    final authPreferences = await AuthPreferencesService.create();

    // Ana uygulamayı başlat
    runApp(BiruniConnect(authPreferences: authPreferences));
  } catch (e) {
    print('Başlatma hatası: $e');
    rethrow; // Hatayı tekrar fırlat ki üst katmanda yakalanabilsin
  }
}

/// Ana uygulama widget'ı
/// Tema, rota yapılandırması ve genel uygulama ayarlarını içerir
class BiruniConnect extends StatelessWidget {
  // Kimlik doğrulama tercihleri servisi
  final AuthPreferencesService authPreferences;

  const BiruniConnect({
    super.key,
    required this.authPreferences,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.lightTheme, // Aydınlık tema
      darkTheme: AppTheme.darkTheme, // Karanlık tema
      themeMode: ThemeMode.system, // Sistem temasını kullan
      debugShowCheckedModeBanner: false, // Debug banner'ı gizle
      routerConfig: AppRouter.router, // Go Router yapılandırması
    );
  }
}
