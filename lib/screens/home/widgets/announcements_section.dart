import 'package:biruni_connect/screens/home/widgets/announcements_section_list.dart';
import 'package:flutter/material.dart';
import 'package:biruni_connect/core/theme/app_text_styles.dart';
import 'package:biruni_connect/core/utils/extensions/context_extension.dart';
import 'package:biruni_connect/mock/announcement_mock.dart';
import 'package:go_router/go_router.dart';

class AnnouncementsSection extends StatelessWidget {
  const AnnouncementsSection({super.key});

  @override
  Widget build(BuildContext context) {
    const int limitedItems = 4;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: context.paddingHorizontalS,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Duyurular',
                style: AppTextStyles.h3(isDark: context.isDark),
              ),
              TextButton(
                onPressed: () => context.push("/announcements"),
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Tüm Duyurular',
                  style: AppTextStyles.bodyMedium(isDark: context.isDark),
                ),
              ),
            ],
          ),
        ),
        context.spaceM,
        AnnouncementsSectionList(
          items: mockCarouselItems.take(limitedItems).toList(),
        ),
      ],
    );
  }
}
