// Gerekli paketlerin ve dosyaların import edilmesi
import 'package:biruni_connect/core/theme/app_colors.dart';
import 'package:biruni_connect/core/theme/app_text_styles.dart';
import 'package:biruni_connect/core/utils/extensions/context_extension.dart';
import 'package:biruni_connect/screens/campus/models/campus_building.dart';
import 'package:biruni_connect/shared/widgets/custom_card.dart';
import 'package:flutter/material.dart';

/// Kampüs binası hakkındaki bilgileri kart formatında gösteren widget.
/// Binanın görseli, kodu, adı, açıklaması ve çalışma saatlerini içerir.
class CampusBuildingCard extends StatelessWidget {
  // Kart için gerekli parametreler
  final CampusBuilding building; // Bina veri modeli
  final VoidCallback onTap; // Karta tıklandığında çalışacak fonksiyon

  const CampusBuildingCard({
    super.key,
    required this.building,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      type: CustomCardType.info,
      onTap: onTap,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bina Görsel Bölümü
          // Binanın görselini üst köşeleri yuvarlatılmış şekilde gösterir
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(context.radiusXL.topLeft.x),
            ),
            child: Image.asset(
              building.imageUrl,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Bina Bilgileri Bölümü
          // Bina kodu, adı, açıklaması ve çalışma saatlerini içerir
          Padding(
            padding: context.paddingM,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bina Kodu ve Adı Satırı
                // Renkli container içinde bina kodu ve yanında bina adını gösterir
                Row(
                  children: [
                    // Bina Kodu Containerı
                    // Bina kodunu primary renk arkaplanı ile gösterir
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: context.isDark
                            ? AppColors.primaryDark
                            : AppColors.primary,
                        borderRadius: context.radiusM,
                      ),
                      child: Text(
                        'Bina ${building.buildingCode}',
                        style: AppTextStyles.bodySmall(
                          color: AppColors.surface,
                        ),
                      ),
                    ),
                    context.horizontalSpaceM,
                    // Bina Adı
                    // Bina adını gösterir, uzun olması durumunda kırpılır
                    Expanded(
                      child: Text(
                        building.name,
                        style: AppTextStyles.h4(isDark: context.isDark),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                context.spaceS,

                // Bina Açıklaması
                // Bina açıklamasını 2 satır ile sınırlı olarak gösterir
                Text(
                  building.description,
                  style: AppTextStyles.bodyMedium(isDark: context.isDark),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                context.spaceM,

                // Çalışma Saatleri Bölümü
                // Saat ikonu ile birlikte binanın çalışma saatlerini gösterir
                Row(
                  children: [
                    // Saat İkonu
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: context.isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondary,
                    ),
                    context.horizontalSpaceS,
                    // Çalışma Saatleri Metni
                    Text(
                      building.openingHours,
                      style: AppTextStyles.bodySmall(isDark: context.isDark),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
