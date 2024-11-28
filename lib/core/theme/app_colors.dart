import 'package:flutter/material.dart';

class AppColors {
  // Kurumsal Ana Renkler
  static const Color biruniBlue = Color(0xFF074583); // Koyu mavi
  static const Color biruniTeal = Color(0xFF00ABC5); // Turkuaz
  static const Color biruniOrange = Color(0xFFEF7F1D); // Turuncu

  // Ana Renkler - Light Theme
  static const Color primary = Color(0xFF074583); // biruniBlue
  static const Color secondary = Color(0xFF00ABC5); // biruniTeal
  static const Color accent = Color(0xFFEF7F1D); // biruniOrange
  static const Color background = Color(0xFFF8F9FA); // Açık gri arkaplan
  static const Color surface = Color(0xFFFFFFFF); // Beyaz yüzey
  static const Color textPrimary = Color(0xFF2D3436); // Koyu metin
  static const Color textSecondary = Color(0xFF636E72); // İkincil metin
  static const Color border = Color(0xFFE0E0E0); // Sınır rengi

  // Ana Renkler - Dark Theme
  static const Color primaryDark = Color(0xFF0A5DA8); // Daha parlak mavi
  static const Color secondaryDark = Color(0xFF00C2DE); // Daha parlak turkuaz
  static const Color accentDark = Color(0xFFFF8F3F); // Daha parlak turuncu
  static const Color backgroundDark =
      Color(0xFF121212); // Material dark arkaplan
  static const Color surfaceDark = Color(0xFF1E1E1E); // Koyu yüzey
  static const Color textPrimaryDark = Color(0xFFECECEC); // Açık metin
  static const Color textSecondaryDark =
      Color(0xFFB0B0B0); // İkincil açık metin
  static const Color borderDark = Color(0xFF2C2C2C); // Koyu sınır

  // Yardımcı Renkler
  static const Color primaryLight = Color(0xFF1A75B5); // Açık mavi
  static const Color primaryDarker = Color(0xFF053666); // Daha koyu mavi
  static const Color secondaryLight = Color(0xFF33C5DD); // Açık turkuaz
  static const Color accentLight = Color(0xFFFFAB40); // Açık turuncu

  // Durum Renkleri - Light/Dark ortak
  static const Color success = Color(0xFF2ECC71);
  static const Color error = Color(0xFFE74C3C);
  static const Color warning = Color(0xFFF1C40F);
  static const Color info = Color(0xFF00ABC5); // biruniTeal

  // Gradients
  static const Gradient primaryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF074583), // biruniBlue
      Color(0xFF00ABC5), // biruniTeal
      Color(0xFFEF7F1D), // biruniOrange
    ],
  );

  static const Gradient primaryGradientDark = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF0A5DA8), // Daha parlak mavi
      Color(0xFF00C2DE), // Daha parlak turkuaz
      Color(0xFFFF8F3F), // Daha parlak turuncu
    ],
  );

  // Material Theme için extension renkleri
  static const Color seedColor = biruniBlue;
  static const Color secondarySeedColor = biruniTeal;
  static const Color tertiarySeedColor = biruniOrange;
}
