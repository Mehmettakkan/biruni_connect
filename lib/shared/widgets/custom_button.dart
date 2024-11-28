import 'package:flutter/material.dart';

enum ButtonType { primary, secondary, text }

enum ButtonSize { small, medium, large }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final ButtonSize size;
  final IconData? icon;
  final bool isLoading;
  final bool isFullWidth;
  final EdgeInsets? padding;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    required this.type,
    required this.size,
    this.icon,
    required this.isLoading,
    required this.isFullWidth,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget buttonChild = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon),
          const SizedBox(width: 8),
        ],
        Text(text),
        if (isLoading) ...[
          const SizedBox(width: 8),
          const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ],
      ],
    );

    return switch (type) {
      ButtonType.primary => ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: theme.elevatedButtonTheme.style,
          child: buttonChild,
        ),
      ButtonType.secondary => OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: theme.outlinedButtonTheme.style,
          child: buttonChild,
        ),
      ButtonType.text => TextButton(
          onPressed: isLoading ? null : onPressed,
          style: theme.textButtonTheme.style,
          child: buttonChild,
        ),
      _ => ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: theme.elevatedButtonTheme.style,
          child: buttonChild,
        ),
    };
  }
}
