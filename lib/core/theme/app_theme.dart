import 'package:biruni_connect/core/constants/ui/ui_constants.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

/// Uygulama genelinde kullanılacak tema ayarlarını içeren sınıf
class AppTheme {
  /// Açık tema için ThemeData örneği
  static ThemeData lightTheme = _buildTheme(isDark: false);

  /// Koyu tema için ThemeData örneği
  static ThemeData darkTheme = _buildTheme(isDark: true);

  /// Tema oluşturucu metod
  /// [isDark] parametresi ile koyu/açık tema seçimi yapılır
  static ThemeData _buildTheme({required bool isDark}) {
    return ThemeData(
      // Material 3'ü aktif eder
      useMaterial3: true,

      // Tema parlaklığını ayarlar (koyu/açık)
      brightness: isDark ? Brightness.dark : Brightness.light,

      // Ana renk teması
      primaryColor: isDark ? AppColors.primaryDark : AppColors.primary,

      // Scaffold arkaplan rengi
      scaffoldBackgroundColor:
          isDark ? AppColors.backgroundDark : AppColors.background,

      /// Material 3 Renk Şeması
      /// Uygulamanın tüm renklerini yönetir
      colorScheme: ColorScheme(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: isDark ? AppColors.primaryDark : AppColors.primary,
        onPrimary: AppColors.surface,
        secondary: isDark ? AppColors.secondaryDark : AppColors.secondary,
        onSecondary: AppColors.surface,
        tertiary: isDark ? AppColors.accentDark : AppColors.accent,
        onTertiary: AppColors.surface,
        error: AppColors.error,
        onError: AppColors.surface,
        surface: isDark ? AppColors.surfaceDark : AppColors.surface,
        onSurface: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
        surfaceContainerHighest: isDark
            ? AppColors.surfaceDark.withOpacity(0.9)
            : AppColors.surface.withOpacity(0.9),
        onSurfaceVariant:
            isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
      ),

      /// AppBar Tema Ayarları
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surface,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: UIConstants.elevationS,
        surfaceTintColor: isDark ? AppColors.primaryDark : AppColors.primary,
        iconTheme: IconThemeData(
          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
          size: UIConstants.iconM,
        ),
        titleTextStyle: AppTextStyles.h3(
          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
          isDark: isDark,
        ),
      ),

      /// Alt Navigasyon Çubuğu Tema Ayarları
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surface,
        selectedItemColor:
            isDark ? AppColors.secondaryDark : AppColors.secondary,
        unselectedItemColor:
            isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: UIConstants.elevationL,
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
      ),

      /// Yükseltilmiş Buton Teması
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: UIConstants.elevationS,
          backgroundColor: isDark ? AppColors.primaryDark : AppColors.primary,
          foregroundColor: AppColors.surface,
          minimumSize: const Size(double.infinity, UIConstants.buttonHeightL),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(UIConstants.radiusM),
          ),
          textStyle: AppTextStyles.buttonLarge(),
        ),
      ),

      /// Çerçeveli Buton Teması
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: isDark ? AppColors.primaryDark : AppColors.primary,
          minimumSize: const Size(double.infinity, UIConstants.buttonHeightL),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(UIConstants.radiusL),
          ),
          side: BorderSide(
            color: isDark ? AppColors.primaryDark : AppColors.primary,
            width: 2,
          ),
          textStyle: AppTextStyles.buttonLarge(),
        ),
      ),

      /// Metin Buton Teması
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor:
              isDark ? AppColors.secondaryDark : AppColors.secondary,
          minimumSize: const Size(double.infinity, UIConstants.buttonHeightM),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(UIConstants.radiusM),
          ),
          textStyle: AppTextStyles.buttonMedium(),
        ),
      ),

      /// Form Alanları Dekorasyon Teması
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? AppColors.surfaceDark : AppColors.surface,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(UIConstants.radiusL),
          borderSide: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.border,
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(UIConstants.radiusL),
          borderSide: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.border,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(UIConstants.radiusL),
          borderSide: BorderSide(
            color: isDark ? AppColors.secondaryDark : AppColors.secondary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(UIConstants.radiusL),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 1.5,
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: AppTextStyles.label(isDark: isDark),
        hintStyle: AppTextStyles.bodyMedium(
          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
          isDark: isDark,
        ),
      ),

      /// Kart Teması
      cardTheme: CardTheme(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        elevation: UIConstants.elevationS,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UIConstants.radiusXL),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
      ),

      /// Metin Teması
      textTheme: TextTheme(
        displayLarge: AppTextStyles.display(isDark: isDark),
        headlineLarge: AppTextStyles.h1(isDark: isDark),
        headlineMedium: AppTextStyles.h2(isDark: isDark),
        headlineSmall: AppTextStyles.h3(isDark: isDark),
        titleLarge: AppTextStyles.h4(isDark: isDark),
        bodyLarge: AppTextStyles.bodyLarge(isDark: isDark),
        bodyMedium: AppTextStyles.bodyMedium(isDark: isDark),
        bodySmall: AppTextStyles.bodySmall(isDark: isDark),
        labelLarge: AppTextStyles.buttonLarge(),
        labelMedium: AppTextStyles.buttonMedium(),
        labelSmall: AppTextStyles.buttonSmall(),
      ),

      /// Ayırıcı Çizgi Teması
      dividerTheme: DividerThemeData(
        color: isDark ? AppColors.borderDark : AppColors.border,
        thickness: 1,
        space: UIConstants.spacingL,
      ),

      /// Chip Teması
      chipTheme: ChipThemeData(
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surface,
        labelStyle: AppTextStyles.bodySmall(isDark: isDark),
        side: BorderSide(
          color: isDark ? AppColors.borderDark : AppColors.border,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UIConstants.radiusM),
        ),
      ),

      /// Snackbar Teması
      snackBarTheme: SnackBarThemeData(
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surface,
        contentTextStyle: AppTextStyles.bodyMedium(isDark: isDark),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UIConstants.radiusM),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
