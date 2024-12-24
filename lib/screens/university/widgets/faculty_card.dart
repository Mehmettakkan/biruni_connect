import 'package:flutter/material.dart';
import 'package:biruni_connect/core/theme/app_colors.dart';
import 'package:biruni_connect/core/theme/app_text_styles.dart';
import 'package:biruni_connect/core/constants/ui/ui_constants.dart';
import 'package:biruni_connect/core/utils/extensions/context_extension.dart';
import 'package:biruni_connect/shared/widgets/custom_card.dart';
import 'package:biruni_connect/screens/university/models/faculty.dart';

/// Fakülte bilgilerini gösteren kart bileşeni.
///
/// Bu kart şunları içerir:
/// - Fakülte ikonu
/// - Program sayısı rozeti
/// - Fakülte adı
/// - Fakülte açıklaması
/// - Alt bilgi çubuğu (Öğretim üyeleri ve eğitim süresi)
///
/// Seçili durumu ve karanlık mod desteği vardır.
class FacultyCard extends StatelessWidget {
  /// Gösterilecek fakülte verisi
  final Faculty faculty;

  /// Karta tıklandığında çağrılacak fonksiyon
  final VoidCallback? onTap;

  /// Kartın seçili olup olmadığını belirten değer
  final bool isSelected;

  const FacultyCard({
    super.key,
    required this.faculty,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    // Tema modunu al (karanlık/aydınlık)
    final isDark = context.isDark;

    return CustomCard(
      type: CustomCardType.program,
      onTap: onTap,
      padding: EdgeInsets.zero,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          // Seçili durumda arka plan rengini değiştir
          color: isSelected
              ? (isDark ? AppColors.primaryDark : AppColors.primary)
                  .withOpacity(UIConstants.opacityHover)
              : null,
          borderRadius: context.radiusXL,
        ),
        child: Padding(
          padding: context.paddingL,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Üst kısım - Fakülte ikonu ve program sayısı
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Fakülte ikonu container'ı
                  Container(
                    padding: context.paddingM,
                    decoration: BoxDecoration(
                      color:
                          (isDark ? AppColors.primaryDark : AppColors.primary)
                              .withOpacity(UIConstants.opacityHover),
                      borderRadius: context.radiusL,
                    ),
                    child: Icon(
                      Icons.account_balance,
                      size: UIConstants.iconM,
                      color: isDark ? AppColors.primaryDark : AppColors.primary,
                    ),
                  ),
                  // Program sayısı rozeti
                  _buildProgramCountBadge(context, isDark),
                ],
              ),

              context.spaceM,

              // Fakülte adı - En fazla 2 satır gösterilir
              Text(
                faculty.name,
                style: AppTextStyles.h3(
                  isDark: isDark,
                  color: isSelected
                      ? (isDark ? AppColors.primaryDark : AppColors.primary)
                      : null,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              context.spaceS,

              // Fakülte açıklaması - Kalan alanı doldurur
              Expanded(
                child: Text(
                  faculty.description,
                  style: AppTextStyles.bodyMedium(
                    isDark: isDark,
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondary,
                  ),
                  overflow: TextOverflow.fade,
                ),
              ),

              context.spaceM,

              // Alt bilgiler (Öğretim üyeleri ve eğitim süresi)
              _buildBottomInfo(context, isDark),
            ],
          ),
        ),
      ),
    );
  }

  /// Program sayısını gösteren rozet widget'ı
  Widget _buildProgramCountBadge(BuildContext context, bool isDark) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: UIConstants.paddingM,
        vertical: UIConstants.paddingXS,
      ),
      decoration: BoxDecoration(
        color: (isDark ? AppColors.primaryDark : AppColors.primary)
            .withOpacity(UIConstants.opacityHover),
        borderRadius: context.radiusL,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.school_outlined,
            size: UIConstants.iconS,
            color: isDark ? AppColors.primaryDark : AppColors.primary,
          ),
          context.horizontalSpaceXS,
          Text(
            '${faculty.programIds.length} Program',
            style: AppTextStyles.caption(
              isDark: isDark,
              color: isDark ? AppColors.primaryDark : AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  /// Alt bilgi çubuğunu oluşturan widget
  Widget _buildBottomInfo(BuildContext context, bool isDark) {
    return Container(
      padding: EdgeInsets.all(UIConstants.paddingS),
      decoration: BoxDecoration(
        color: (isDark ? AppColors.surfaceDark : AppColors.surface)
            .withOpacity(UIConstants.opacityHover),
        borderRadius: context.radiusL,
        border: Border.all(
          color: (isDark ? AppColors.borderDark : AppColors.border)
              .withOpacity(UIConstants.opacityHover),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildInfoItem(
            context,
            Icons.person_outline,
            'Öğretim Üyeleri',
            isDark,
          ),
          _buildInfoItem(
            context,
            Icons.schedule_outlined,
            'Eğitim Süresi',
            isDark,
          ),
        ],
      ),
    );
  }

  /// Alt bilgi öğelerini oluşturan yardımcı widget
  Widget _buildInfoItem(
    BuildContext context,
    IconData icon,
    String label,
    bool isDark,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: UIConstants.iconS,
          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
        ),
        context.horizontalSpaceXS,
        Text(
          label,
          style: AppTextStyles.caption(
            isDark: isDark,
            color:
                isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
