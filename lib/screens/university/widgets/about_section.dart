import 'package:flutter/material.dart';
import 'package:biruni_connect/core/constants/ui/ui_constants.dart';
import 'package:biruni_connect/core/theme/app_colors.dart';
import 'package:biruni_connect/core/theme/app_text_styles.dart';
import 'package:biruni_connect/core/utils/extensions/context_extension.dart';
import 'package:biruni_connect/screens/university/models/university_info.dart';
import 'package:biruni_connect/shared/widgets/custom_card.dart';

/// Üniversite hakkında bilgileri gösteren bölüm widget'ı.
/// Misyon, vizyon ve tarihçe bilgilerini sekmeli yapıda sunar.
class AboutSection extends StatefulWidget {
  /// Gösterilecek üniversite bilgileri
  final UniversityInfo universityInfo;

  const AboutSection({
    super.key,
    required this.universityInfo,
  });

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection>
    with SingleTickerProviderStateMixin {
  /// Sekme kontrolcüsü
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // 3 sekme için controller oluştur (Misyon, Vizyon, Tarihçe)
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // Controller'ı temizle
    _tabController.dispose();
    super.dispose();
  }

  /// Kuruluş yılı rozetini oluşturan yardımcı widget
  Widget _buildFoundationYearBadge(bool isDark) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.paddingM.left,
        vertical: context.paddingXS.top,
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
            Icons.calendar_today_outlined,
            size: UIConstants.iconS,
            color: isDark ? AppColors.primaryDark : AppColors.primary,
          ),
          context.horizontalSpaceXS,
          Text(
            'Kuruluş ${widget.universityInfo.foundationYear}',
            style: AppTextStyles.bodySmall(
              color: isDark ? AppColors.primaryDark : AppColors.primary,
              isDark: isDark,
            ),
          ),
        ],
      ),
    );
  }

  /// Sekme içeriğini oluşturan yardımcı widget
  Widget _buildTabContent(String content, bool isDark) {
    return SingleChildScrollView(
      padding: context.paddingL,
      child: Text(
        content,
        style: AppTextStyles.bodyLarge(
          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
          isDark: isDark,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return CustomCard(
      type: CustomCardType.elevated,
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min, // Minimum yükseklikte olmasını sağlar
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Üst kısım - Başlık ve sekmeler
          Padding(
            padding: EdgeInsets.only(
              left: context.paddingL.left,
              right: context.paddingL.right,
              top: context.paddingL.top,
              bottom: context.paddingM.bottom,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Üniversite adı ve kuruluş yılı
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.universityInfo.name,
                        style: AppTextStyles.h2(isDark: isDark),
                      ),
                    ),
                    _buildFoundationYearBadge(isDark),
                  ],
                ),
                context.spaceL,
                // Sekme çubuğu
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color:
                            (isDark ? AppColors.primaryDark : AppColors.primary)
                                .withOpacity(UIConstants.opacityHover),
                        width: 2,
                      ),
                    ),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    labelColor:
                        isDark ? AppColors.primaryDark : AppColors.primary,
                    unselectedLabelColor: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondary,
                    labelStyle: AppTextStyles.bodyMedium(isDark: isDark),
                    indicatorWeight: 2,
                    indicatorColor:
                        isDark ? AppColors.primaryDark : AppColors.primary,
                    tabs: const [
                      Tab(text: 'Misyon'),
                      Tab(text: 'Vizyon'),
                      Tab(text: 'Tarihçe'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Sekme içerikleri - Sabit yükseklikte gösterilir
          SizedBox(
            height: 250,
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTabContent(widget.universityInfo.mission, isDark),
                _buildTabContent(widget.universityInfo.vision, isDark),
                _buildTabContent(widget.universityInfo.history, isDark),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
