import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:biruni_connect/config/routes/route_names.dart';
import 'package:biruni_connect/core/theme/app_colors.dart';
import 'package:biruni_connect/core/theme/app_text_styles.dart';
import 'package:biruni_connect/core/utils/extensions/context_extension.dart';
import 'package:biruni_connect/screens/auth/models/user_model.dart';
import 'package:biruni_connect/screens/auth/services/auth_service.dart';
import 'package:biruni_connect/screens/auth/widgets/auth_button.dart';
import 'package:biruni_connect/shared/widgets/custom_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoading = false;
  UserModel? _user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final authService = await AuthService.create();
    setState(() => _user = authService.currentUser);
  }

  Future<void> _handleLogout() async {
    setState(() => _isLoading = true);
    try {
      final authService = await AuthService.create();
      await authService.signOut();
      if (mounted) {
        context.showSnackBar('Çıkış yapıldı');
        context.go(RoutePath.login);
      }
    } catch (e) {
      if (mounted) {
        context.showSnackBar('Çıkış yapılırken bir hata oluştu', isError: true);
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Gradient App Bar
          SliverAppBar(
            pinned: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: isDark
                      ? AppColors.primaryGradientDark
                      : AppColors.primaryGradient,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Profil Fotoğrafı
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: context.colors.surface,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: context.colors.primary.withOpacity(0.2),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor:
                            context.colors.primary.withOpacity(0.1),
                        child: _user?.photoURL != null
                            ? ClipOval(
                                child: Image.network(
                                  _user!.photoURL!,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>
                                      _buildAvatarIcon(),
                                ),
                              )
                            : _buildAvatarIcon(),
                      ),
                    ),
                    context.spaceM,
                    // İsim ve Öğrenci No
                    Text(
                      _user?.displayName ?? 'İsimsiz Öğrenci',
                      style: AppTextStyles.h3(color: AppColors.surface),
                    ),
                    Text(
                      _user?.studentId ?? '',
                      style: AppTextStyles.bodyMedium(
                        color: AppColors.surface.withOpacity(0.8),
                      ),
                    ),
                    context.spaceM,
                  ],
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: _handleLogout,
                icon: const Icon(Icons.logout, color: AppColors.surface),
                tooltip: 'Çıkış Yap',
              ),
            ],
          ),

          // İçerik
          SliverToBoxAdapter(
            child: Padding(
              padding: context.paddingM,
              child: Column(
                children: [
                  // Profil Kartı
                  CustomCard(
                    type: CustomCardType.outlined,
                    child: Column(
                      children: [
                        _buildInfoTile(
                          title: 'Öğrenci Numarası',
                          value: _user?.studentId ?? '',
                          icon: Icons.badge_outlined,
                        ),
                        const Divider(),
                        _buildInfoTile(
                          title: 'E-posta',
                          value: _user?.email ?? '',
                          icon: Icons.email_outlined,
                        ),
                        const Divider(),
                        _buildInfoTile(
                          title: 'Telefon',
                          value: _user?.phoneNumber ?? 'Belirtilmemiş',
                          icon: Icons.phone_outlined,
                        ),
                      ],
                    ),
                  ),
                  context.spaceL,

                  // Çıkış Butonu
                  AuthButton(
                    text: 'Çıkış Yap',
                    onPressed: _isLoading ? null : _handleLogout,
                    isLoading: _isLoading,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarIcon() {
    return Icon(
      Icons.person_outline,
      size: 48,
      color: context.colors.primary,
    );
  }

  Widget _buildInfoTile({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Padding(
      padding: context.paddingM,
      child: Row(
        children: [
          Container(
            padding: context.paddingS,
            decoration: BoxDecoration(
              color: context.colors.primary.withOpacity(0.1),
              borderRadius: context.radiusM,
            ),
            child: Icon(
              icon,
              color: context.colors.primary,
            ),
          ),
          context.horizontalSpaceM,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
                Text(
                  value,
                  style: context.textTheme.titleMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
