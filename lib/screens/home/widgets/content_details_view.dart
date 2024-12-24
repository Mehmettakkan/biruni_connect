import 'package:biruni_connect/core/utils/extensions/context_extension.dart';
import 'package:biruni_connect/mock/announcements_mock.dart';
import 'package:biruni_connect/mock/news_mock.dart';
import 'package:biruni_connect/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:biruni_connect/core/constants/ui/ui_constants.dart';
import 'package:biruni_connect/core/theme/app_colors.dart';
import 'package:biruni_connect/core/theme/app_text_styles.dart';
import 'package:biruni_connect/core/theme/app_decorations.dart';
import 'package:share_plus/share_plus.dart';
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/services.dart';

/// İçerik detaylarını gösteren ana ekran widget'ı
class ContentDetailsView extends StatelessWidget {
  // İçeriğin benzersiz kimliği
  final String? id;

  // Constructor tanımı
  const ContentDetailsView({
    super.key,
    required this.id,
  });

  /// İçerik kategorisine göre renk döndüren yardımcı metod
  /// [id] içeriğin kimliği
  /// [isDark] dark mode durumu
  Color _getCategoryColor(String id, bool isDark) {
    if (id.startsWith('announcements')) {
      return isDark ? AppColors.primaryDark : AppColors.primary;
    } else if (id.startsWith('news')) {
      return isDark ? AppColors.accentDark : AppColors.accent;
    }
    return isDark ? AppColors.primaryDark : AppColors.primary;
  }

  /// İçerik kategorisine göre metin döndüren yardımcı metod
  /// [id] içeriğin kimliği
  String _getCategoryText(String id) {
    if (id.startsWith('announcements')) {
      return 'DUYURU';
    } else if (id.startsWith('news')) {
      return 'HABER';
    }
    return 'DUYURU';
  }

  /// Verilen ID'ye göre içeriği getiren yardımcı metod
  /// [id] içeriğin kimliği
  /// İçerik bulunamazsa Exception fırlatır
  dynamic _getContentById(String id) {
    if (id.startsWith('announcements')) {
      return AnnouncementsMock.announcements.firstWhere(
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

  /// İçeriği paylaşmak için kullanılan metod
  /// [context] build context
  /// [content] paylaşılacak içerik objesi
  Future<void> _shareContent(BuildContext context, dynamic content) async {
    try {
      // Paylaşılacak metni formatla
      final String shareText = '''
${content.title}

${content.description}

Tarih: ${DateFormat('dd MMMM yyyy', 'tr_TR').format(content.date)}
''';

      // Share.share ile paylaşım yap
      await Share.share(shareText);
    } catch (e) {
      // Context kontrolü
      if (!context.mounted) return;

      // Hata durumunda kullanıcıya bilgi ver
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e is PlatformException
              ? 'Paylaşma özelliği şu anda kullanılamıyor'
              : 'Paylaşma sırasında bir hata oluştu'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
      // Hata logunu yazdır
      debugPrint('Share error: $e');
    }
  }

  /// İçeriği takvime eklemek için kullanılan metod
  /// [context] build context
  /// [content] takvime eklenecek içerik objesi
  Future<void> _addToCalendar(BuildContext context, dynamic content) async {
    try {
      // Takvim event'ini oluştur
      final Event event = Event(
        title: content.title,
        description: content.description,
        location: 'Biruni Üniversitesi',
        startDate: content.date,
        endDate:
            content.date.add(const Duration(hours: 1)), // Varsayılan 1 saat
      );

      // Takvime eklemeyi dene
      final bool result = await Add2Calendar.addEvent2Cal(event);

      // Context kontrolü
      if (!context.mounted) return;

      // Başarılı ekleme durumunda bilgi ver
      if (result) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Etkinlik takvime eklendi'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      // Context kontrolü
      if (!context.mounted) return;

      // Hata durumunda kullanıcıya bilgi ver
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e is PlatformException
              ? 'Takvim özelliği şu anda kullanılamıyor'
              : 'Takvime ekleme sırasında bir hata oluştu'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
      // Hata logunu yazdır
      debugPrint('Calendar error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // ID null kontrolü
    if (id == null) {
      return const Scaffold(
        body: Center(child: Text('İçerik bulunamadı')),
      );
    }

    // Tema ve format değişkenlerinin hazırlanması
    final isDark = context.isDark;
    final dateFormat = DateFormat('dd MMMM yyyy', 'tr_TR');
    final content = _getContentById(id!);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar ve Görsel Bölümü
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
                      // İçerik görseli
                      Image.asset(
                        content.imageUrl,
                        fit: BoxFit.cover,
                        cacheWidth: 1024,
                      ),
                      // Görsel üzerine gradient efekti
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

          // İçerik Detay Bölümü
          SliverToBoxAdapter(
            child: Container(
              decoration: AppDecorations.elevated(isDark),
              margin: context.paddingM,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Kategori ve Tarih Satırı
                  Padding(
                    padding: context.paddingM,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Kategori etiketi
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
                        // Tarih gösterimi
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

                  // Başlık
                  Padding(
                    padding: context.paddingM,
                    child: Text(
                      content.title,
                      style: AppTextStyles.h2(isDark: isDark),
                    ),
                  ),

                  // Açıklama (eğer varsa)
                  if (content.description.isNotEmpty) ...[
                    Padding(
                      padding: context.paddingM,
                      child: Text(
                        content.description,
                        style: AppTextStyles.bodyLarge(isDark: isDark),
                      ),
                    ),
                  ],

                  // Alt Butonlar (Paylaş ve Takvime Ekle)
                  Padding(
                    padding: context.paddingM,
                    child: Row(
                      children: [
                        // Paylaş butonu
                        Expanded(
                          child: CustomButton(
                            type: ButtonType.secondary,
                            text: 'Paylaş',
                            icon: Icons.share,
                            onPressed: () => _shareContent(context, content),
                            size: ButtonSize.large,
                            isLoading: false,
                            isFullWidth: true,
                          ),
                        ),
                        context.horizontalSpaceM,
                        // Takvime ekle butonu
                        Expanded(
                          child: CustomButton(
                            type: ButtonType.primary,
                            text: 'Ekle',
                            icon: Icons.calendar_month,
                            onPressed: () => _addToCalendar(context, content),
                            size: ButtonSize.large,
                            isLoading: false,
                            isFullWidth: true,
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
