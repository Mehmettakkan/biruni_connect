import 'package:flutter/material.dart';
import 'package:biruni_connect/core/theme/app_colors.dart';
import 'package:biruni_connect/core/theme/app_text_styles.dart';
import 'package:biruni_connect/core/constants/ui/ui_constants.dart';
import 'package:biruni_connect/core/utils/extensions/context_extension.dart';
import 'package:biruni_connect/shared/widgets/custom_card.dart';
import 'package:biruni_connect/screens/university/models/academic_program.dart';

/// Akademik program bilgilerini kart formatında gösteren widget.
///
/// Bu kart aşağıdaki program detaylarını içerir:
/// - Program adı
/// - Eğitim dili
/// - Program açıklaması
/// - Eğitim süresi
/// - Derece türü
///
/// Kart, karanlık mod desteği sunar ve uygulamanın temasından özel stilleri kullanır.
class ProgramCard extends StatelessWidget {
  /// Gösterilecek akademik program verisi
  final AcademicProgram program;

  /// Karta tıklandığında tetiklenecek fonksiyon
  final VoidCallback? onTap;

  const ProgramCard({
    super.key,
    required this.program,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Mevcut tema modunu al (karanlık/aydınlık)
    final isDark = context.isDark;

    return CustomCard(
      type: CustomCardType.info,
      onTap: onTap,
      padding: context.paddingL,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Program adı ve eğitim dili bilgisini içeren üst kısım
          Row(
            children: [
              // Program adı - Sola hizalı ve genişleyebilir
              Expanded(
                child: Text(
                  program.name,
                  style: AppTextStyles.h4(isDark: isDark),
                ),
              ),
              // Eğitim dili - Sağda yer alan etiket
              Container(
                padding: context.paddingS,
                decoration: BoxDecoration(
                  color:
                      (isDark ? AppColors.secondaryDark : AppColors.secondary)
                          .withOpacity(0.1),
                  borderRadius: BorderRadius.circular(UIConstants.radiusM),
                ),
                child: Text(
                  program.language,
                  style: AppTextStyles.caption(
                    isDark: isDark,
                    color:
                        isDark ? AppColors.secondaryDark : AppColors.secondary,
                  ),
                ),
              ),
            ],
          ),

          // Dikey boşluk
          context.spaceM,

          // Program açıklaması - En fazla 2 satır gösterilir
          Text(
            program.description,
            style: AppTextStyles.bodyMedium(isDark: isDark),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          // Dikey boşluk
          context.spaceM,

          // Alt bilgiler - Eğitim süresi ve derece bilgisi
          Row(
            children: [
              // Eğitim süresi göstergesi
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.timer_outlined,
                    size: UIConstants.iconS,
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondary,
                  ),
                  context.horizontalSpaceXS,
                  Text(
                    program.duration,
                    style: AppTextStyles.caption(isDark: isDark),
                  ),
                ],
              ),

              // Yatay boşluk
              context.horizontalSpaceM,

              // Derece türü göstergesi
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.school_outlined,
                    size: UIConstants.iconS,
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondary,
                  ),
                  context.horizontalSpaceXS,
                  Text(
                    program.degree,
                    style: AppTextStyles.caption(isDark: isDark),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
