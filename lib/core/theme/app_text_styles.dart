import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const String _fontFamily = 'Inter';

  // Display Styles
  static TextStyle display({Color? color, bool isDark = false}) => TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: color ??
            (isDark ? AppColors.textPrimaryDark : AppColors.textPrimary),
        fontFamily: _fontFamily,
        letterSpacing: -0.5,
        height: 1.2,
      );

  // Heading Styles
  static TextStyle h1({Color? color, bool isDark = false}) => TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: color ??
            (isDark ? AppColors.textPrimaryDark : AppColors.textPrimary),
        fontFamily: _fontFamily,
        letterSpacing: -0.5,
        height: 1.3,
      );

  static TextStyle h2({Color? color, bool isDark = false}) => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: color ??
            (isDark ? AppColors.textPrimaryDark : AppColors.textPrimary),
        fontFamily: _fontFamily,
        letterSpacing: -0.3,
        height: 1.35,
      );

  static TextStyle h3({Color? color, bool isDark = false}) => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: color ??
            (isDark ? AppColors.textPrimaryDark : AppColors.textPrimary),
        fontFamily: _fontFamily,
        letterSpacing: -0.2,
        height: 1.4,
      );

  static TextStyle h4({Color? color, bool isDark = false}) => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: color ??
            (isDark ? AppColors.textPrimaryDark : AppColors.textPrimary),
        fontFamily: _fontFamily,
        letterSpacing: -0.2,
        height: 1.45,
      );

  // Body Styles
  static TextStyle bodyLarge({Color? color, bool isDark = false}) => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: color ??
            (isDark ? AppColors.textPrimaryDark : AppColors.textPrimary),
        fontFamily: _fontFamily,
        height: 1.5,
        letterSpacing: 0.15,
      );

  static TextStyle bodyMedium({Color? color, bool isDark = false}) => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: color ??
            (isDark ? AppColors.textSecondaryDark : AppColors.textSecondary),
        fontFamily: _fontFamily,
        height: 1.5,
        letterSpacing: 0.15,
      );

  static TextStyle bodySmall({Color? color, bool isDark = false}) => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: color ??
            (isDark ? AppColors.textSecondaryDark : AppColors.textSecondary),
        fontFamily: _fontFamily,
        height: 1.5,
        letterSpacing: 0.2,
      );

  // Interactive Element Styles
  static TextStyle buttonLarge({Color? color}) => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: color ?? AppColors.surface,
        fontFamily: _fontFamily,
        letterSpacing: 0.5,
        height: 1.25,
      );

  static TextStyle buttonMedium({Color? color}) => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: color ?? AppColors.surface,
        fontFamily: _fontFamily,
        letterSpacing: 0.5,
        height: 1.25,
      );

  static TextStyle buttonSmall({Color? color}) => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: color ?? AppColors.surface,
        fontFamily: _fontFamily,
        letterSpacing: 0.5,
        height: 1.25,
      );

  // Link Styles
  static TextStyle linkLarge({Color? color, bool isDark = false}) => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color:
            color ?? (isDark ? AppColors.secondaryDark : AppColors.secondary),
        fontFamily: _fontFamily,
        decoration: TextDecoration.underline,
        decorationColor:
            color ?? (isDark ? AppColors.secondaryDark : AppColors.secondary),
        height: 1.5,
      );

  static TextStyle linkMedium({Color? color, bool isDark = false}) => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color:
            color ?? (isDark ? AppColors.secondaryDark : AppColors.secondary),
        fontFamily: _fontFamily,
        decoration: TextDecoration.underline,
        decorationColor:
            color ?? (isDark ? AppColors.secondaryDark : AppColors.secondary),
        height: 1.5,
      );

  // Caption & Label Styles
  static TextStyle caption({Color? color, bool isDark = false}) => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: color ??
            (isDark ? AppColors.textSecondaryDark : AppColors.textSecondary),
        fontFamily: _fontFamily,
        letterSpacing: 0.4,
        height: 1.33,
      );

  static TextStyle label({Color? color, bool isDark = false}) => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: color ??
            (isDark ? AppColors.textSecondaryDark : AppColors.textSecondary),
        fontFamily: _fontFamily,
        letterSpacing: 0.1,
        height: 1.4,
      );
}
