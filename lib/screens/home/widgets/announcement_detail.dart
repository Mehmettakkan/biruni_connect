import 'package:biruni_connect/core/utils/extensions/context_extension.dart';
import 'package:biruni_connect/mock/announcement_mock.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:biruni_connect/core/constants/ui/ui_constants.dart';
import 'package:biruni_connect/core/theme/app_colors.dart';
import 'package:biruni_connect/core/theme/app_text_styles.dart';
import 'package:biruni_connect/core/theme/app_decorations.dart';

class AnnouncementDetail extends StatelessWidget {
  final String? id;

  const AnnouncementDetail({
    Key? key,
    required this.id,
  }) : super(key: key);

  Color _getCategoryColor(String category, bool isDark) {
    switch (category) {
      case 'announcement':
        return isDark ? AppColors.primaryDark : AppColors.primary;
      case 'event':
        return isDark ? AppColors.secondaryDark : AppColors.secondary;
      case 'news':
        return isDark ? AppColors.accentDark : AppColors.accent;
      default:
        return isDark ? AppColors.primaryDark : AppColors.primary;
    }
  }

  String _getCategoryText(String category) {
    switch (category) {
      case 'announcement':
        return 'DUYURU';
      case 'event':
        return 'ETKİNLİK';
      case 'news':
        return 'HABER';
      default:
        return 'DUYURU';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (id == null) {
      return const Scaffold(
        body: Center(child: Text('Duyuru bulunamadı')),
      );
    }

    final isDark = context.isDark;
    final dateFormat = DateFormat('dd MMMM yyyy', 'tr_TR');

    final announcement = mockCarouselItems.firstWhere(
      (item) => item.id == id,
      orElse: () => throw Exception('Duyuru bulunamadı'),
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar ve Görsel
          SliverAppBar(
            expandedHeight: context.height * 0.4, // Yükseklik artırıldı
            pinned: true,
            stretch: true,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
              ],
              background: Hero(
                tag: 'hero_${announcement.id}',
                child: Container(
                  padding: EdgeInsets.only(top: context.topPadding),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        announcement.imageUrl,
                        fit: BoxFit.cover,
                        cacheWidth: 1024,
                      ),
                      // Gradient overlay
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // İçerik
          SliverToBoxAdapter(
            child: Container(
              decoration: AppDecorations.elevated(isDark),
              margin: context.paddingM,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Kategori ve Tarih
                  Padding(
                    padding: context.paddingM,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: UIConstants.paddingM,
                            vertical: UIConstants.paddingXS,
                          ),
                          decoration: BoxDecoration(
                            color:
                                _getCategoryColor(announcement.category, isDark)
                                    .withOpacity(0.1),
                            borderRadius: context.radiusL,
                            border: Border.all(
                              color: _getCategoryColor(
                                  announcement.category, isDark),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            _getCategoryText(announcement.category),
                            style: AppTextStyles.caption(
                              color: _getCategoryColor(
                                  announcement.category, isDark),
                              isDark: isDark,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: UIConstants.iconS,
                              color: isDark
                                  ? AppColors.textSecondaryDark
                                  : AppColors.textSecondary,
                            ),
                            context.horizontalSpaceXS,
                            Text(
                              dateFormat.format(announcement.date),
                              style: AppTextStyles.caption(isDark: isDark),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: context.paddingM,
                    child: Text(
                      announcement.title,
                      style: AppTextStyles.h2(isDark: isDark),
                    ),
                  ),

                  if (announcement.description.isNotEmpty) ...[
                    Padding(
                      padding: context.paddingM,
                      child: Text(
                        announcement.description,
                        style: AppTextStyles.bodyLarge(isDark: isDark),
                      ),
                    ),
                  ],

                  Padding(
                    padding: context.paddingM,
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              // Paylaşım fonksiyonu
                            },
                            icon: const Icon(Icons.share),
                            label: const Text('Paylaş'),
                            style: OutlinedButton.styleFrom(
                              padding: context.paddingM,
                            ),
                          ),
                        ),
                        context.horizontalSpaceM,
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // Takvime Ekle fonksiyonu
                            },
                            icon: const Icon(Icons.calendar_month),
                            label: const Text('Takvime Ekle'),
                            style: ElevatedButton.styleFrom(
                              padding: context.paddingM,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
