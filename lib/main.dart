import 'package:biruni_connect/config/routes/app_router.dart';
import 'package:biruni_connect/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const BiruniConnect());
}

class BiruniConnect extends StatelessWidget {
  const BiruniConnect({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router, // AppRouter sınıfından router'a erişim
    );
  }
}
