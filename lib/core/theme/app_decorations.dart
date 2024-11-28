import 'package:biruni_connect/core/constants/ui/ui_constants.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppDecorations {
  // Info Card Decoration
  static BoxDecoration info(bool isDark) => BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        borderRadius: BorderRadius.circular(UIConstants.radiusXL),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 0,
            color: (isDark ? AppColors.primaryDark : AppColors.primary)
                .withOpacity(0.08),
          ),
        ],
      );

  // Event Card Decoration (Gradient background)
  static BoxDecoration event(bool isDark) => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            isDark ? AppColors.primaryDark : AppColors.primary,
            isDark ? AppColors.secondaryDark : AppColors.secondary,
          ],
        ),
        borderRadius: BorderRadius.circular(UIConstants.radiusXL),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 12,
            color: (isDark ? Colors.black : Colors.grey).withOpacity(0.1),
          ),
        ],
      );

  // Program Card Decoration
  static BoxDecoration program(bool isDark) => BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        borderRadius: BorderRadius.circular(UIConstants.radiusXL),
        border: Border.all(
          color: isDark ? AppColors.secondaryDark : AppColors.secondary,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 8,
            color: (isDark ? AppColors.secondaryDark : AppColors.secondary)
                .withOpacity(0.1),
          ),
        ],
      );

  // Elevated Container
  static BoxDecoration elevated(bool isDark) => BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        borderRadius: BorderRadius.circular(UIConstants.radiusXL),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 6),
            blurRadius: 16,
            spreadRadius: 0,
            color: (isDark ? Colors.black : Colors.grey).withOpacity(0.12),
          ),
        ],
      );

  // Outlined Card Decoration
  static BoxDecoration outlined(bool isDark) => BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        borderRadius: BorderRadius.circular(UIConstants.radiusXL),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.border,
          width: 1.5,
        ),
      );

  // Card Decorations
  static BoxDecoration card(bool isDark) => BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        borderRadius: BorderRadius.circular(UIConstants.radiusXL),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 12,
            spreadRadius: 2,
            color: (isDark ? AppColors.primaryDark : AppColors.primary)
                .withOpacity(0.08),
          ),
        ],
      );

  // Input Decorations
  static BoxDecoration input(bool isDark) => BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        borderRadius: BorderRadius.circular(UIConstants.radiusL),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.border,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 6,
            color: (isDark ? Colors.black : Colors.grey).withOpacity(0.05),
          ),
        ],
      );

  static BoxDecoration inputFocused(bool isDark) => BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        borderRadius: BorderRadius.circular(UIConstants.radiusL),
        border: Border.all(
          color: isDark ? AppColors.secondaryDark : AppColors.secondary,
          width: 2.0,
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 8,
            color: (isDark ? AppColors.secondaryDark : AppColors.secondary)
                .withOpacity(0.15),
          ),
        ],
      );

  // Gradient Background
  static BoxDecoration gradientBackground(bool isDark) => BoxDecoration(
        gradient:
            isDark ? AppColors.primaryGradientDark : AppColors.primaryGradient,
      );

  // Bottom Navigation Bar
  static BoxDecoration bottomNavBar(bool isDark) => BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -4),
            blurRadius: 12,
            spreadRadius: 0,
            color: (isDark ? Colors.black : Colors.grey).withOpacity(0.08),
          ),
        ],
      );

  // Container with Gradient Border
  static BoxDecoration gradientBorder(bool isDark) => BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        borderRadius: BorderRadius.circular(UIConstants.radiusXL),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [AppColors.primaryDark, AppColors.secondaryDark]
              : [AppColors.primary, AppColors.secondary],
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 12,
            color: (isDark ? Colors.black : Colors.grey).withOpacity(0.1),
          ),
        ],
      );
}
