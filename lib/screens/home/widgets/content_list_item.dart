import 'package:flutter/material.dart';
import 'package:biruni_connect/core/theme/app_text_styles.dart';
import 'package:biruni_connect/core/utils/extensions/context_extension.dart';
import 'package:go_router/go_router.dart';
import 'content_list_view.dart';

class ContentListItem extends StatelessWidget {
  final String contentType; // 'announcement', 'event', 'news'
  final int limitedItems;
  final String title;
  final String viewAllText;

  const ContentListItem({
    super.key,
    required this.contentType,
    this.limitedItems = 4,
    required this.title,
    required this.viewAllText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: context.paddingHorizontalS,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyles.h3(isDark: context.isDark),
              ),
              TextButton(
                onPressed: () => context.push("/$contentType"),
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  viewAllText,
                  style: AppTextStyles.bodyMedium(isDark: context.isDark),
                ),
              ),
            ],
          ),
        ),
        context.spaceM,
        ContentListView(
          contentType: contentType,
        ),
      ],
    );
  }
}
