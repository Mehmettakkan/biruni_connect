// lib/screens/auth/widgets/auth_google_button.dart
import 'package:biruni_connect/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'auth_button.dart';

class AuthGoogleButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;

  const AuthGoogleButton({
    super.key,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return AuthButton(
      text: 'Google ile Devam Et',
      onPressed: onPressed,
      isLoading: isLoading,
      type: ButtonType.secondary,
      icon: FontAwesomeIcons.google,
    );
  }
}
