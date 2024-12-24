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
        // Başlık kısmı
        Padding(
          padding: context.paddingHorizontalS,
          child: Text(
            'Hızlı Erişim',
            style: AppTextStyles.h3(isDark: context.isDark),
          ),
        ),
        context.spaceM, // Başlık ile grid arasında boşluk

        // Responsive grid yapısı için LayoutBuilder
        LayoutBuilder(
          builder: (context, constraints) {
            // Ekran genişliğine göre grid sütun sayısını hesapla
            final crossAxisCount =
                _calculateCrossAxisCount(constraints.maxWidth);

            // Grid yapısını oluştur
            return GridView.builder(
              shrinkWrap: true, // Grid'in içeriğe göre büzülmesini sağlar
              physics:
                  const NeverScrollableScrollPhysics(), // Scroll'u devre dışı bırak
              padding: context.paddingHorizontalS,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount, // Sütun sayısı
                mainAxisSpacing: UIConstants.spacingM, // Dikey boşluk
                crossAxisSpacing: UIConstants.spacingM, // Yatay boşluk
                childAspectRatio: 1.2, // Grid item'larının en-boy oranı
              ),
              itemCount: mockQuickAccessItems.length, // Toplam item sayısı
              itemBuilder: (context, index) => _QuickAccessCard(
                item: mockQuickAccessItems[index],
              ),
            );
          },
        ),
      ],
    );
  }

  // Ekran genişliğine göre grid sütun sayısını hesaplayan method
  int _calculateCrossAxisCount(double width) {
    if (width < 600) return 2; // Mobil için 2 sütun
    if (width < 900) return 3; // Tablet için 3 sütun
    return 4; // Desktop için 4 sütun
  }
}

// Her bir hızlı erişim kartını oluşturan widget
class _QuickAccessCard extends StatelessWidget {
  final QuickAccessItem item;

  const _QuickAccessCard({
    required this.item,
  });

  // URL'leri açmak için kullanılan method
  Future<void> _handleUrl(BuildContext context, String urlString) async {
    try {
      final Uri url = Uri.parse(urlString);
      // Önce uygulama içi web view'da açmayı dene
      final inAppResult = await launchUrl(
        url,
        mode: LaunchMode.inAppWebView,
        webViewConfiguration: const WebViewConfiguration(
          enableJavaScript: true,
          enableDomStorage: true,
        ),
      );

      // Uygulama içi açılamazsa harici tarayıcıda aç
      if (!inAppResult && context.mounted) {
        await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      // Hata durumunda kullanıcıya bildir
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
    // Özel tasarlanmış kart widget'ı
    return CustomCard(
      type: CustomCardType.info,
      onTap: () async {
        // Eğer harici bir link ise URL'i aç
        if (item.isExternal) {
          await _handleUrl(context, item.route);
        }
      },
      padding: context.paddingM,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // İkon container'ı
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
          context.spaceS, // İkon ile başlık arası boşluk
          // Başlık metni
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
          // Alt başlık varsa göster
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
