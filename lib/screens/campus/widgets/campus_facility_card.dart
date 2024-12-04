// Gerekli paketlerin ve dosyaların import edilmesi
import 'package:biruni_connect/core/theme/app_colors.dart';
import 'package:biruni_connect/core/theme/app_text_styles.dart';
import 'package:biruni_connect/core/utils/extensions/context_extension.dart';
import 'package:biruni_connect/screens/campus/models/campus_facility.dart';
import 'package:biruni_connect/shared/widgets/custom_card.dart';
import 'package:flutter/material.dart';

/// Kampüs tesisi hakkındaki bilgileri kart formatında gösteren widget.
/// Tesisin ikonu, adı, konumu, açıklaması ve çalışma saatlerini içerir.
class CampusFacilityCard extends StatelessWidget {
  // Kart için gerekli parametreler
  final CampusFacility facility; // Tesis veri modeli
  final VoidCallback onTap; // Karta tıklandığında çalışacak fonksiyon

  const CampusFacilityCard({
    Key? key,
    required this.facility,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      type: CustomCardType.elevated,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tesis İkonu ve İsim Bölümü
          // İkon ve yanında tesis adı ile konumunu gösterir
          Row(
            children: [
              // Tesis İkonu Containerı
              // Tesis ikonunu yarı saydam secondary renk arkaplanı ile gösterir
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: context.isDark
                      ? AppColors.secondaryDark.withOpacity(0.1)
                      : AppColors.secondary.withOpacity(0.1),
                  borderRadius: context.radiusL,
                ),
                child: Icon(
                  IconData(int.parse(facility.iconName),
                      fontFamily: 'MaterialIcons'),
                  color: context.isDark
                      ? AppColors.secondaryDark
                      : AppColors.secondary,
                ),
              ),
              context.horizontalSpaceM,
              // Tesis Adı ve Konum Bilgisi
              // Tesis adını ve altında konumunu gösterir
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      facility.name,
                      style: AppTextStyles.h4(isDark: context.isDark),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      facility.location,
                      style: AppTextStyles.bodySmall(isDark: context.isDark),
                    ),
                  ],
                ),
              ),
            ],
          ),

          context.spaceM,

          // Tesis Açıklaması
          // Tesisin açıklamasını 2 satır ile sınırlı olarak gösterir
          Text(
            facility.description,
            style: AppTextStyles.bodyMedium(isDark: context.isDark),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          context.spaceM,

          // Alt Bilgiler Satırı
          // Çalışma saatleri ve detaylar butonunu içerir
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Çalışma Saatleri
              // Saat ikonu ile birlikte tesisin çalışma saatlerini gösterir
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: context.isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondary,
                  ),
                  context.horizontalSpaceS,
                  Text(
                    facility.openingHours,
                    style: AppTextStyles.bodySmall(isDark: context.isDark),
                  ),
                ],
              ),
              // Detaylar Butonu
              // Info ikonu ile birlikte detaylar yazısını gösterir
              Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 16,
                    color: context.isDark
                        ? AppColors.secondaryDark
                        : AppColors.secondary,
                  ),
                  context.horizontalSpaceS,
                  Text(
                    'Detaylar',
                    style: AppTextStyles.bodySmall(
                      isDark: context.isDark,
                      color: context.isDark
                          ? AppColors.secondaryDark
                          : AppColors.secondary,
                    ),
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
