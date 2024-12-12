// content_list_view.dart

import 'package:flutter/material.dart';
import 'package:biruni_connect/core/constants/ui/ui_constants.dart';
import 'package:biruni_connect/core/theme/app_colors.dart';
import 'package:biruni_connect/core/theme/app_text_styles.dart';
import 'package:biruni_connect/core/utils/extensions/context_extension.dart';
import 'package:biruni_connect/shared/widgets/custom_card.dart';
import 'package:biruni_connect/mock/announcements_mock.dart';
import 'package:biruni_connect/mock/events_mock.dart';
import 'package:biruni_connect/mock/news_mock.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

class ContentListView extends StatelessWidget {
  final String contentType; // 'announcement', 'event', 'news'
  final bool isFullScreen;

  const ContentListView({
    super.key,
    required this.contentType,
    this.isFullScreen = false,
  });

  Color _getCategoryColor(String type, bool isDark) {
    switch (type) {
      case 'announcements':
        return isDark ? AppColors.primaryDark : AppColors.primary;
      case 'events':
        return isDark ? AppColors.secondaryDark : AppColors.secondary;
      case 'news':
        return isDark ? AppColors.accentDark : AppColors.accent;
      default:
        return isDark ? AppColors.primaryDark : AppColors.primary;
    }
  }

  String _getTitle(String type) {
    switch (type) {
      case 'announcements':
        return 'Tüm Duyurular';
      case 'events':
        return 'Tüm Etkinlikler';
      case 'news':
        return 'Tüm Haberler';
      default:
        return 'İçerikler';
    }
  }

  List<dynamic> _getContentItems() {
    switch (contentType) {
      case 'announcements':
        return AnnouncementsMock.announcements;
      case 'events':
        return EventsMock.events;
      case 'news':
        return NewsMock.news;
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final displayItems = _getContentItems();
    final categoryColor = _getCategoryColor(contentType, isDark);

    Widget listContent = ListView.separated(
      shrinkWrap: !isFullScreen,
      physics: isFullScreen
          ? const AlwaysScrollableScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(
        horizontal: context.paddingS.left,
        vertical: isFullScreen ? context.paddingM.top : 0,
      ),
      itemCount: displayItems.length,
      separatorBuilder: (context, index) =>
          SizedBox(height: UIConstants.spacingM),
      itemBuilder: (context, index) {
        final item = displayItems[index];
        final date = item.date;

        return CustomCard(
          type: CustomCardType.outlined,
          onTap: () => context.push('/${contentType}/${item.id}'),
          padding: EdgeInsets.zero,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 70,
                decoration: BoxDecoration(
                  color: categoryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(UIConstants.radiusXL),
                    bottomLeft: Radius.circular(UIConstants.radiusXL),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: UIConstants.paddingM),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('dd').format(date),
                        style: AppTextStyles.h2(color: Colors.white),
                      ),
                      Text(
                        DateFormat('MMM', 'tr_TR').format(date).toUpperCase(),
                        style: AppTextStyles.bodyMedium(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(UIConstants.paddingM),
                  child: Text(
                    item.title,
                    style: AppTextStyles.bodyMedium(
                      isDark: isDark,
                      color: context.colors.onSurface,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(UIConstants.paddingM),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.chevron_right,
                      color: isDark ? AppColors.borderDark : AppColors.border,
                    ),
                    SizedBox(height: UIConstants.spacingXS),
                    Text(
                      'Detaylar',
                      style: AppTextStyles.caption(
                        isDark: isDark,
                        color: context.colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );

    if (isFullScreen) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            _getTitle(contentType),
            style: AppTextStyles.h3(isDark: isDark),
          ),
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
            },
            child: listContent,
          ),
        ),
      );
    }

    return listContent;
  }
}
