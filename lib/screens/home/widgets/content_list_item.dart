import 'package:flutter/material.dart';
import 'package:biruni_connect/core/theme/app_text_styles.dart';
import 'package:biruni_connect/core/utils/extensions/context_extension.dart';
import 'package:go_router/go_router.dart';
import 'content_list_view.dart';

/// İçerik listesi başlığı ve "Tümünü Gör" butonu ile birlikte
/// içerik listesini gösteren widget.
class ContentListItem extends StatelessWidget {
  /// İçerik tipi ('announcement', 'event', 'news')
  final String contentType;

  /// Gösterilecek maksimum içerik sayısı
  final int limitedItems;

  /// Başlık metni
  final String title;

  /// "Tümünü Gör" buton metni
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
        // Başlık ve "Tümünü Gör" butonu satırı
        Padding(
          padding: context.paddingHorizontalS,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Başlık
              Text(
                title,
                style: AppTextStyles.h3(isDark: context.isDark),
              ),
              // Tümünü Gör butonu
              TextButton(
                onPressed: () => context.push("/$contentType"),
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  // Buton boyutunu optimize et
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

        // Boşluk
        context.spaceM,

        // İçerik listesi
        ContentListView(
          contentType: contentType,
        ),
      ],
    );
  }
}
