// lib/screens/auth/widgets/auth_remember_me.dart
import 'package:flutter/material.dart';
import 'package:biruni_connect/core/utils/extensions/context_extension.dart';

class AuthRememberMe extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const AuthRememberMe({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
        Text(
          'Beni Hatırla',
          style: context.textTheme.bodyMedium,
        ),
      ],
    );
  }
}
