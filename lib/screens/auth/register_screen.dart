// lib/screens/auth/screens/register_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:biruni_connect/config/routes/route_names.dart';
import 'package:biruni_connect/core/constants/ui/asset_constants.dart';
import 'package:biruni_connect/core/utils/extensions/context_extension.dart';
import 'package:biruni_connect/screens/auth/services/auth_service.dart';
import 'package:biruni_connect/screens/auth/widgets/auth_button.dart';
import 'package:biruni_connect/screens/auth/widgets/auth_google_button.dart';
import 'package:biruni_connect/screens/auth/widgets/auth_text_field.dart';
import 'package:biruni_connect/shared/widgets/custom_card.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isLoading = false;
  bool _isGoogleLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  String _getErrorMessage(String error) {
    if (error.contains('email-already-in-use')) {
      return 'Bu e-posta adresi zaten kullanımda';
    } else if (error.contains('weak-password')) {
      return 'Şifre çok zayıf';
    } else if (error.contains('network-request-failed')) {
      return 'İnternet bağlantınızı kontrol edin';
    }
    return 'Bir hata oluştu, lütfen tekrar deneyin';
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    context.unfocus;
    setState(() => _isLoading = true);

    try {
      final authService = await AuthService.create();
      final user = await authService.registerWithEmail(
        email: _emailController.text,
        password: _passwordController.text,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        phoneNumber: _phoneController.text,
      );

      if (user != null && mounted) {
        context.showSnackBar('Kayıt başarılı');
        context.go(RoutePath.home);
      }
    } catch (e) {
      if (mounted) {
        context.showSnackBar(_getErrorMessage(e.toString()), isError: true);
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _handleGoogleRegister() async {
    setState(() => _isGoogleLoading = true);

    try {
      final authService = await AuthService.create();
      final user = await authService.signInWithGoogle();

      if (user != null && mounted) {
        context.showSnackBar('Google ile kayıt başarılı');
        context.go(RoutePath.home);
      }
    } catch (e) {
      if (mounted) {
        context.showSnackBar(_getErrorMessage(e.toString()), isError: true);
      }
    } finally {
      if (mounted) setState(() => _isGoogleLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: context.paddingM,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Logo
                      Image.asset(
                        AssetConstants.splash,
                        height: 100,
                      ),
                      context.spaceL,

                      // Başlık
                      Text(
                        'Biruni Connect\'e\nKayıt Ol',
                        style: context.textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                      context.spaceXL,

                      // Form Card
                      // Form Card
                      CustomCard(
                        type: CustomCardType.outlined,
                        child: Column(
                          children: [
                            // Kişisel Bilgiler
                            AuthTextField(
                              controller: _firstNameController,
                              labelText: 'Ad',
                              hintText: 'Adınız',
                              keyboardType: TextInputType.name,
                              prefixIcon: const Icon(Icons.person_outline),
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Ad alanı gerekli';
                                }
                                return null;
                              },
                            ),
                            context.spaceM,
                            AuthTextField(
                              controller: _lastNameController,
                              labelText: 'Soyad',
                              hintText: 'Soyadınız',
                              keyboardType: TextInputType.name,
                              prefixIcon: const Icon(Icons.person_outline),
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Soyad alanı gerekli';
                                }
                                return null;
                              },
                            ),
                            context.spaceM,
                            AuthTextField(
                              controller: _phoneController,
                              labelText: 'Telefon',
                              hintText: '5XX XXX XX XX',
                              keyboardType: TextInputType.phone,
                              prefixIcon: const Icon(Icons.phone_outlined),
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Telefon numarası gerekli';
                                }
                                // Basit bir telefon numarası validasyonu
                                if (!RegExp(r'^5[0-9]{9}$').hasMatch(value!)) {
                                  return 'Geçerli bir telefon numarası girin';
                                }
                                return null;
                              },
                            ),
                            context.spaceM,

                            // Hesap Bilgileri
                            AuthTextField(
                              controller: _emailController,
                              labelText: 'E-posta',
                              hintText: 'ornek@st.biruni.edu.tr',
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: const Icon(Icons.email_outlined),
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'E-posta adresi gerekli';
                                }
                                if (!value!.endsWith('@st.biruni.edu.tr')) {
                                  return 'Geçerli bir Biruni mail adresi girin';
                                }
                                return null;
                              },
                            ),
                            context.spaceM,
                            AuthTextField(
                              controller: _passwordController,
                              labelText: 'Şifre',
                              isPassword: true,
                              prefixIcon: const Icon(Icons.lock_outlined),
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Şifre gerekli';
                                }
                                if (value!.length < 6) {
                                  return 'Şifre en az 6 karakter olmalı';
                                }
                                return null;
                              },
                            ),
                            context.spaceM,
                            AuthTextField(
                              controller: _confirmPasswordController,
                              labelText: 'Şifre Tekrar',
                              isPassword: true,
                              prefixIcon: const Icon(Icons.lock_outlined),
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Şifre tekrarı gerekli';
                                }
                                if (value != _passwordController.text) {
                                  return 'Şifreler eşleşmiyor';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      context.spaceL,

                      // Register Button
                      AuthButton(
                        text: 'Kayıt Ol',
                        onPressed: (_isLoading || _isGoogleLoading)
                            ? null
                            : _handleRegister,
                        isLoading: _isLoading,
                      ),
                      context.spaceM,

                      // Divider
                      Row(
                        children: [
                          const Expanded(child: Divider()),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'veya',
                              style: context.textTheme.bodyMedium,
                            ),
                          ),
                          const Expanded(child: Divider()),
                        ],
                      ),
                      context.spaceM,

                      // Google Register Button
                      AuthGoogleButton(
                        onPressed: (_isLoading || _isGoogleLoading)
                            ? null
                            : _handleGoogleRegister,
                        isLoading: _isGoogleLoading,
                      ),
                      context.spaceL,

                      // Login Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Zaten hesabınız var mı?',
                            style: context.textTheme.bodyMedium,
                          ),
                          Flexible(
                            child: TextButton(
                              onPressed: (_isLoading || _isGoogleLoading)
                                  ? null
                                  : () => context.go(RoutePath.login),
                              child: const Text('Giriş Yap'),
                            ),
                          ),
                        ],
                      ),
                      context.spaceM,
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
