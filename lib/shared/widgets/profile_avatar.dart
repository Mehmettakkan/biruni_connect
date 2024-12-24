import 'package:flutter/material.dart';
import 'package:biruni_connect/core/constants/ui/ui_constants.dart';
import 'package:biruni_connect/core/theme/app_colors.dart';
import 'package:biruni_connect/core/theme/app_text_styles.dart';
import 'package:biruni_connect/core/utils/extensions/context_extension.dart';
import 'package:biruni_connect/screens/auth/models/user_model.dart';

/// Kullanıcı profil resmi veya baş harflerini gösteren avatar widget'ı
/// Profil fotoğrafı varsa onu gösterir, yoksa kullanıcının baş harflerini veya varsayılan bir ikon gösterir
class ProfileAvatar extends StatelessWidget {
  // Kullanıcı bilgilerini içeren model
  final UserModel? user;
  // Avatar boyutu (null ise varsayılan boyut kullanılır)
  final double? size;
  // Avatar'a tıklandığında çalışacak fonksiyon
  final VoidCallback? onTap;
  // Çerçeve gösterilsin mi
  final bool showBorder;

  const ProfileAvatar({
    super.key,
    this.user,
    this.size,
    this.onTap,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    // Avatar boyutunu belirle (varsayılan veya özel)
    final avatarSize = size ?? UIConstants.iconXL;
    final isDark = context.isDark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        // Kenarlık gösterilecekse daire şeklinde border ekle
        decoration: showBorder
            ? BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isDark ? AppColors.secondaryDark : AppColors.secondary,
                  width: 2,
                ),
              )
            : null,
        child: CircleAvatar(
          radius: avatarSize / 2,
          backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surface,
          child: _buildAvatarContent(context, avatarSize),
        ),
      ),
    );
  }

  /// Avatar içeriğini oluşturan metot
  /// Sırasıyla şunları kontrol eder:
  /// 1. Profil fotoğrafı var mı?
  /// 2. Ad veya soyad var mı? (baş harfler için)
  /// 3. Hiçbiri yoksa varsayılan ikon
  Widget _buildAvatarContent(BuildContext context, double size) {
    // Kullanıcı fotoğrafı varsa onu göster
    if (user?.photoURL != null) {
      return ClipOval(
        child: Image.network(
          user!.photoURL!,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _buildPlaceholder(
              context, size), // Yükleme hatası olursa placeholder göster
        ),
      );
    }

    // Kullanıcı adı varsa baş harflerini göster
    if (user?.firstName != null || user?.lastName != null) {
      final initials = _getInitials();
      return Text(
        initials,
        style: AppTextStyles.h3(
          isDark: context.isDark,
          color: context.isDark
              ? AppColors.textPrimaryDark
              : AppColors.textPrimary,
        ),
      );
    }

    // Hiçbiri yoksa varsayılan ikon göster
    return _buildPlaceholder(context, size);
  }

  /// Kullanıcının adının ve soyadının baş harflerini alır
  /// Örnek: Mehmet Akkan -> MA
  String _getInitials() {
    String initials = '';
    if (user?.firstName != null && user!.firstName!.isNotEmpty) {
      initials += user!.firstName![0]; // İlk adın baş harfi
    }
    if (user?.lastName != null && user!.lastName!.isNotEmpty) {
      initials += user!.lastName![0]; // Soyadın baş harfi
    }
    return initials.toUpperCase(); // Büyük harfe çevir
  }

  /// Varsayılan placeholder ikonunu oluşturur
  /// Profil fotoğrafı ve isim yoksa gösterilir
  Widget _buildPlaceholder(BuildContext context, double size) {
    return Icon(
      Icons.person_outline_rounded,
      size: size * 0.6, // İkon boyutunu avatar boyutuna göre ayarla
      color: context.isDark
          ? AppColors.textSecondaryDark
          : AppColors.textSecondary,
    );
  }
}
