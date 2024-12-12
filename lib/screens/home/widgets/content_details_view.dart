import 'package:biruni_connect/core/utils/extensions/context_extension.dart';
import 'package:biruni_connect/mock/announcements_mock.dart';
import 'package:biruni_connect/mock/events_mock.dart';
import 'package:biruni_connect/mock/news_mock.dart';
import 'package:biruni_connect/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:biruni_connect/core/constants/ui/ui_constants.dart';
import 'package:biruni_connect/core/theme/app_colors.dart';
import 'package:biruni_connect/core/theme/app_text_styles.dart';
import 'package:biruni_connect/core/theme/app_decorations.dart';

class ContentDetailsView extends StatelessWidget {
  final String? id;

  const ContentDetailsView({
    Key? key,
    required this.id,
  }) : super(key: key);

  Color _getCategoryColor(String id, bool isDark) {
    if (id.startsWith('announcements')) {
      return isDark ? AppColors.primaryDark : AppColors.primary;
    } else if (id.startsWith('events')) {
      return isDark ? AppColors.secondaryDark : AppColors.secondary;
    } else if (id.startsWith('news')) {
      return isDark ? AppColors.accentDark : AppColors.accent;
    }
    return isDark ? AppColors.primaryDark : AppColors.primary;
  }

  String _getCategoryText(String id) {
    if (id.startsWith('announcements')) {
      return 'DUYURU';
    } else if (id.startsWith('events')) {
      return 'ETKİNLİK';
    } else if (id.startsWith('news')) {
      return 'HABER';
    }
    return 'DUYURU';
  }

  dynamic _getContentById(String id) {
    if (id.startsWith('announcements')) {
      return AnnouncementsMock.announcements.firstWhere(
        (item) => item.id == id,
        orElse: () => throw Exception('İçerik bulunamadı'),
      );
    } else if (id.startsWith('events')) {
      return EventsMock.events.firstWhere(
        (item) => item.id == id,
        orElse: () => throw Exception('İçerik bulunamadı'),
      );
    } else if (id.startsWith('news')) {
      return NewsMock.news.firstWhere(
        (item) => item.id == id,
        orElse: () => throw Exception('İçerik bulunamadı'),
      );
    }
    throw Exception('İçerik bulunamadı');
  }

  @override
  Widget build(BuildContext context) {
    if (id == null) {
      return const Scaffold(
        body: Center(child: Text('İçerik bulunamadı')),
      );
    }

    final isDark = context.isDark;
    final dateFormat = DateFormat('dd MMMM yyyy', 'tr_TR');
    final content = _getContentById(id!);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar ve Görsel
          SliverAppBar(
            expandedHeight: context.height * 0.4,
            pinned: true,
            stretch: true,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
              ],
              background: Hero(
                tag: 'hero_${content.id}',
                child: Container(
                  padding: EdgeInsets.only(top: context.topPadding),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        content.imageUrl,
                        fit: BoxFit.cover,
                        cacheWidth: 1024,
                      ),
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
                                _getCategoryColor(id!, isDark).withOpacity(0.1),
                            borderRadius: context.radiusL,
                            border: Border.all(
                              color: _getCategoryColor(id!, isDark),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            _getCategoryText(id!),
                            style: AppTextStyles.caption(
                              color: _getCategoryColor(id!, isDark),
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
                              dateFormat.format(content.date),
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
                      content.title,
                      style: AppTextStyles.h2(isDark: isDark),
                    ),
                  ),

                  if (content.description.isNotEmpty) ...[
                    Padding(
                      padding: context.paddingM,
                      child: Text(
                        content.description,
                        style: AppTextStyles.bodyLarge(isDark: isDark),
                      ),
                    ),
                  ],

                  Padding(
                    padding: context.paddingM,
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            type: ButtonType.secondary,
                            text: 'Paylaş',
                            icon: Icons.share,
                            onPressed: () {},
                            size: ButtonSize.large,
                            isLoading: false,
                            isFullWidth: true,
                          ),
                        ),
                        context.horizontalSpaceM,
                        Expanded(
                          child: CustomButton(
                            type: ButtonType.primary,
                            text: 'Ekle',
                            icon: Icons.calendar_month,
                            onPressed: () {},
                            size: ButtonSize.large,
                            isLoading: false,
                            isFullWidth: true,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
