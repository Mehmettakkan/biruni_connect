import 'package:biruni_connect/config/routes/app_router.dart';
import 'package:biruni_connect/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('tr_TR', null);
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
