// lib/screens/auth/login_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:biruni_connect/config/routes/route_names.dart';
import 'package:biruni_connect/core/constants/ui/asset_constants.dart';
import 'package:biruni_connect/core/utils/extensions/context_extension.dart';
import 'package:biruni_connect/screens/auth/services/auth_service.dart';
import 'package:biruni_connect/screens/auth/widgets/auth_button.dart';
import 'package:biruni_connect/screens/auth/widgets/auth_google_button.dart';
import 'package:biruni_connect/screens/auth/widgets/auth_remember_me.dart';
import 'package:biruni_connect/screens/auth/widgets/auth_text_field.dart';
import 'package:biruni_connect/shared/widgets/custom_card.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _isLoading = false;
  bool _isGoogleLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String _getErrorMessage(String error) {
    if (error.contains('user-not-found')) {
      return 'Bu e-posta adresi ile kayıtlı kullanıcı bulunamadı';
    } else if (error.contains('wrong-password')) {
      return 'Hatalı şifre';
    } else if (error.contains('network-request-failed')) {
      return 'İnternet bağlantınızı kontrol edin';
    }
    return 'Bir hata oluştu, lütfen tekrar deneyin';
  }

  Future<void> _handlePasswordReset() async {
    if (_emailController.text.isEmpty) {
      context.showSnackBar('Lütfen e-posta adresinizi girin', isError: true);
      return;
    }

    try {
      final authService = await AuthService.create();
      await authService.resetPassword(_emailController.text);
      if (mounted) {
        context.showSnackBar(
            'Şifre sıfırlama bağlantısı e-posta adresinize gönderildi');
      }
    } catch (e) {
      if (mounted) {
        context.showSnackBar(_getErrorMessage(e.toString()), isError: true);
      }
    }
  }

  Future<void> _handleEmailLogin() async {
    if (!_formKey.currentState!.validate()) return;

    context.unfocus;
    setState(() => _isLoading = true);

    try {
      final authService = await AuthService.create();
      final user = await authService.signInWithEmail(
        email: _emailController.text,
        password: _passwordController.text,
        rememberMe: _rememberMe,
      );

      if (user != null && mounted) {
        context.showSnackBar('Giriş başarılı');
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

  Future<void> _handleGoogleLogin() async {
    setState(() => _isGoogleLoading = true);

    try {
      final authService = await AuthService.create();
      final user = await authService.signInWithGoogle();

      if (user != null && mounted) {
        context.showSnackBar('Google ile giriş başarılı');
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
                        height: 300,
                      ),
                      context.spaceL,

                      // Başlık
                      Text(
                        'Biruni Connect\'e\nHoş Geldiniz',
                        style: context.textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                      context.spaceXL,

                      // Form Card
                      CustomCard(
                        type: CustomCardType.outlined,
                        child: Column(
                          children: [
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
                          ],
                        ),
                      ),
                      context.spaceS,

                      // Remember Me ve Forgot Password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AuthRememberMe(
                            value: _rememberMe,
                            onChanged: (value) =>
                                setState(() => _rememberMe = value ?? false),
                          ),
                          Flexible(
                            child: TextButton(
                              onPressed:
                                  _isLoading ? null : _handlePasswordReset,
                              child: const Text('Şifremi Unuttum'),
                            ),
                          ),
                        ],
                      ),
                      context.spaceM,

                      // Login Button
                      AuthButton(
                        text: 'Giriş Yap',
                        onPressed: (_isLoading || _isGoogleLoading)
                            ? null
                            : _handleEmailLogin,
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

                      // Google Login
                      AuthGoogleButton(
                        onPressed: (_isLoading || _isGoogleLoading)
                            ? null
                            : _handleGoogleLogin,
                        isLoading: _isGoogleLoading,
                      ),
                      context.spaceL,

                      // Register Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Hesabınız yok mu?',
                            style: context.textTheme.bodyMedium,
                          ),
                          Flexible(
                            child: TextButton(
                              onPressed: (_isLoading || _isGoogleLoading)
                                  ? null
                                  : () => context.go(RoutePath.register),
                              child: const Text('Kayıt Ol'),
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
