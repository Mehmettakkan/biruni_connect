import 'package:biruni_connect/core/constants/ui/ui_constants.dart';
import 'package:biruni_connect/mock/quick_links_mock.dart';
import 'package:flutter/material.dart';
import 'package:biruni_connect/core/theme/app_text_styles.dart';
import 'package:biruni_connect/core/utils/extensions/context_extension.dart';
import 'package:biruni_connect/shared/widgets/custom_card.dart';
import 'package:url_launcher/url_launcher.dart';

class QuickLinksSection extends StatelessWidget {
  const QuickLinksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: context.paddingHorizontalS,
          child: Text(
            'Hızlı Erişim',
            style: AppTextStyles.h3(isDark: context.isDark),
          ),
        ),
        context.spaceM,
        LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount =
                _calculateCrossAxisCount(constraints.maxWidth);

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: context.paddingHorizontalS,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: UIConstants.spacingM,
                crossAxisSpacing: UIConstants.spacingM,
                childAspectRatio: 1.2,
              ),
              itemCount: mockQuickAccessItems.length,
              itemBuilder: (context, index) => _QuickAccessCard(
                item: mockQuickAccessItems[index],
              ),
            );
          },
        ),
      ],
    );
  }

  int _calculateCrossAxisCount(double width) {
    if (width < 600) return 2;
    if (width < 900) return 3;
    return 4;
  }
}

class _QuickAccessCard extends StatelessWidget {
  final QuickAccessItem item;

  const _QuickAccessCard({
    required this.item,
  });

  Future<void> _handleUrl(BuildContext context, String urlString) async {
    try {
      final Uri url = Uri.parse(urlString);
      final inAppResult = await launchUrl(
        url,
        mode: LaunchMode.inAppWebView,
        webViewConfiguration: const WebViewConfiguration(
          enableJavaScript: true,
          enableDomStorage: true,
        ),
      );

      if (!inAppResult && context.mounted) {
        await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Bağlantı açılamadı'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      type: CustomCardType.info,
      onTap: () async {
        if (item.isExternal) {
          await _handleUrl(context, item.route);
        }
      },
      padding: context.paddingM,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: context.paddingS,
            decoration: BoxDecoration(
              color:
                  (item.iconColor ?? context.colors.secondary).withOpacity(0.1),
              borderRadius: context.radiusCircular,
            ),
            child: Icon(
              item.icon,
              size: UIConstants.iconL,
              color: item.iconColor ?? context.colors.secondary,
            ),
          ),
          context.spaceS,
          Text(
            item.title,
            style: AppTextStyles.bodyMedium(
              isDark: context.isDark,
              color: context.colors.onSurface,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (item.subtitle != null) ...[
            context.spaceXS,
            Text(
              item.subtitle!,
              style: AppTextStyles.caption(
                isDark: context.isDark,
                color: context.colors.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }
}
