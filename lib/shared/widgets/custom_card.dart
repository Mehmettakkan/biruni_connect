import 'package:biruni_connect/core/constants/ui/ui_constants.dart';
import 'package:biruni_connect/core/theme/app_decorations.dart';
import 'package:flutter/material.dart';

/// Kartların farklı tiplerini tanımlayan enum
enum CustomCardType {
  info, // Bilgi kartları için
  event, // Etkinlik kartları için
  program, // Program kartları için
  elevated, // Yükseltilmiş kartlar
  outlined // Çerçeveli kartlar
}

class CustomCard extends StatelessWidget {
  // Sabit değerler
  static const EdgeInsets _defaultPadding = EdgeInsets.all(16.0);

  // Widget parametreleri
  final Widget child;
  final CustomCardType type;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final String? heroTag;

  const CustomCard({
    super.key,
    required this.type,
    required this.child,
    this.onTap,
    this.padding,
    this.width,
    this.height,
    this.backgroundColor,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Widget cardContent = Container(
      width: width,
      height: height,
      padding: padding ?? _defaultPadding,
      decoration: _getDecoration(isDark),
      child: child,
    );

    // Hero animasyonu için wrapper
    if (heroTag != null) {
      cardContent = Hero(
        tag: heroTag!,
        child: cardContent,
      );
    }

    // Tıklanabilir wrapper
    if (onTap != null) {
      cardContent = Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(UIConstants.radiusXL),
          child: cardContent,
        ),
      );
    }

    return cardContent;
  }

  BoxDecoration _getDecoration(bool isDark) {
    switch (type) {
      case CustomCardType.info:
        return AppDecorations.info(isDark);
      case CustomCardType.event:
        return AppDecorations.event(isDark);
      case CustomCardType.program:
        return AppDecorations.program(isDark);
      case CustomCardType.elevated:
        return AppDecorations.elevated(isDark);
      case CustomCardType.outlined:
        return AppDecorations.outlined(isDark);
    }
  }
}
