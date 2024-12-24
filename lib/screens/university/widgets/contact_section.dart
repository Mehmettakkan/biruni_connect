import 'package:flutter/material.dart';
import 'package:biruni_connect/core/theme/app_colors.dart';
import 'package:biruni_connect/core/theme/app_text_styles.dart';
import 'package:biruni_connect/core/constants/ui/ui_constants.dart';
import 'package:biruni_connect/core/utils/extensions/context_extension.dart';
import 'package:biruni_connect/shared/widgets/custom_card.dart';
import 'package:biruni_connect/screens/university/models/contact_info.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

/// İletişim bilgilerini gösteren ana bölüm widget'ı.
/// İçerisinde adres, telefon, e-posta, web sitesi ve sosyal medya bilgileri bulunur.
class ContactSection extends StatelessWidget {
  /// Gösterilecek iletişim bilgileri
  final ContactInfo contactInfo;

  const ContactSection({super.key, required this.contactInfo});

  /// URL'leri açmak için kullanılan yardımcı fonksiyon
  /// [isEmail] parametresi e-posta adresleri için mailto: prefix'i ekler
  Future<void> _launchUrl(String url, {bool isEmail = false}) async {
    final uri = Uri.parse(isEmail ? 'mailto:$url' : url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    // Tema modunu al
    final isDark = context.isDark;

    return CustomCard(
      type: CustomCardType.info,
      padding: context.paddingL,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Başlık
          Text('İletişim', style: AppTextStyles.h3(isDark: isDark)),
          context.spaceL,

          // İletişim bilgileri listesi
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              // Adres bilgisi
              _ContactItem(
                icon: Icons.location_on_outlined,
                title: 'Adres',
                content: contactInfo.address,
                onTap: () => _launchUrl(
                  'https://maps.google.com/?q=${contactInfo.location.latitude},${contactInfo.location.longitude}',
                ),
                isDark: isDark,
              ),
              context.spaceM,

              // Telefon bilgisi
              _ContactItem(
                icon: Icons.phone_outlined,
                title: 'Telefon',
                content: contactInfo.phone,
                onTap: () => _launchUrl('tel:${contactInfo.phone}'),
                isDark: isDark,
              ),
              context.spaceM,

              // E-posta bilgisi
              _ContactItem(
                icon: Icons.email_outlined,
                title: 'E-posta',
                content: contactInfo.email,
                onTap: () => _launchUrl(contactInfo.email, isEmail: true),
                isDark: isDark,
              ),
              context.spaceM,

              // Web sitesi bilgisi
              _ContactItem(
                icon: Icons.language_outlined,
                title: 'Web Sitesi',
                content: contactInfo.website,
                onTap: () => _launchUrl('https://${contactInfo.website}'),
                isDark: isDark,
              ),
            ],
          ),
          context.spaceL,

          // Sosyal medya bölümü
          Text('Sosyal Medya', style: AppTextStyles.h4(isDark: isDark)),
          context.spaceM,

          // Sosyal medya ikonları
          Wrap(
            spacing: UIConstants.spacingM,
            runSpacing: UIConstants.spacingM,
            children: [
              // Facebook ikonu
              _SocialIcon(
                icon: FontAwesomeIcons.facebook,
                username: contactInfo.socialMedia['facebook'],
                isDark: isDark,
              ),
              // Twitter ikonu
              _SocialIcon(
                icon: FontAwesomeIcons.xTwitter,
                username: contactInfo.socialMedia['twitter'],
                isDark: isDark,
              ),
              // Instagram ikonu
              _SocialIcon(
                icon: FontAwesomeIcons.instagram,
                username: contactInfo.socialMedia['instagram'],
                isDark: isDark,
              ),
              // LinkedIn ikonu
              _SocialIcon(
                icon: FontAwesomeIcons.linkedin,
                username: contactInfo.socialMedia['linkedin'],
                isDark: isDark,
              ),
              // YouTube ikonu
              _SocialIcon(
                icon: FontAwesomeIcons.youtube,
                username: contactInfo.socialMedia['youtube'],
                isDark: isDark,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// İletişim bilgisi öğelerini gösteren private widget
class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;
  final VoidCallback onTap;
  final bool isDark;

  const _ContactItem({
    required this.icon,
    required this.title,
    required this.content,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: context.radiusL,
      child: Container(
        padding: context.paddingM,
        decoration: BoxDecoration(
          color: (isDark ? AppColors.surfaceDark : AppColors.surface)
              .withOpacity(0.5),
          borderRadius: context.radiusL,
          border: Border.all(
            color: (isDark ? AppColors.borderDark : AppColors.border)
                .withOpacity(0.5),
          ),
        ),
        child: Row(
          children: [
            // İletişim bilgisi ikonu
            Icon(
              icon,
              size: UIConstants.iconM,
              color: isDark ? AppColors.primaryDark : AppColors.primary,
            ),
            context.horizontalSpaceM,
            // İletişim bilgisi içeriği
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.label(isDark: isDark)),
                  context.spaceXS,
                  Text(
                    content,
                    style: AppTextStyles.bodyMedium(
                      isDark: isDark,
                      color: isDark ? AppColors.primaryDark : AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Sosyal medya ikonlarını gösteren private widget
class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final String? username;
  final bool isDark;

  const _SocialIcon({
    required this.icon,
    required this.username,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    // Kullanıcı adı boşsa widget'ı gösterme
    if (username == null || username!.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(UIConstants.paddingM),
      decoration: BoxDecoration(
        color: (isDark ? AppColors.primaryDark : AppColors.primary)
            .withOpacity(0.1),
        borderRadius: context.radiusM,
      ),
      child: Icon(
        icon,
        size: UIConstants.iconL,
        color: isDark ? AppColors.primaryDark : AppColors.primary,
      ),
    );
  }
}
