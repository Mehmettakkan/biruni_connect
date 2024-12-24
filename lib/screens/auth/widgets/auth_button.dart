// lib/screens/auth/widgets/auth_button.dart
import 'package:flutter/material.dart';
import 'package:biruni_connect/shared/widgets/custom_button.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final ButtonType type;

  const AuthButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.icon,
    this.type = ButtonType.primary,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      type: type,
      size: ButtonSize.large,
      icon: icon,
      isLoading: isLoading,
      isFullWidth: true,
    );
  }
}
