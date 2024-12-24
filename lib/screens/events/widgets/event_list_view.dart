import 'package:flutter/material.dart';
import 'package:biruni_connect/core/constants/ui/ui_constants.dart';
import 'package:biruni_connect/core/theme/app_colors.dart';
import 'package:biruni_connect/core/theme/app_text_styles.dart';
import 'package:biruni_connect/core/theme/app_decorations.dart';
import 'package:biruni_connect/core/utils/extensions/context_extension.dart';
import 'package:biruni_connect/screens/events/models/event.dart';
import 'package:biruni_connect/screens/events/widgets/event_card.dart';
import 'package:go_router/go_router.dart';

/// Etkinlikleri liste halinde gösteren ana widget
/// Yükleme durumu, hata mesajları ve boş durum gösterimini yönetir
class EventListView extends StatelessWidget {
  // Gösterilecek etkinlik listesi
  final List<Event> events;
  // Yükleme durumunu belirten flag
  final bool isLoading;
  // Kartların tam ekran mı yoksa kompakt mı gösterileceğini belirten flag
  final bool isFullScreen;
  // Liste boş olduğunda gösterilecek mesaj
  final String? emptyMessage;
  // Hata durumunda gösterilecek mesaj
  final String? errorMessage;
  // Yenileme butonu için callback
  final VoidCallback? onRefresh;

  const EventListView({
    super.key,
    required this.events,
    this.isLoading = false,
    this.isFullScreen = true,
    this.emptyMessage,
    this.errorMessage,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    // Duruma göre uygun widget'ı göster
    if (isLoading) {
      return _buildLoadingState(context); // Yükleme durumu
    }

    if (errorMessage != null) {
      return _buildMessageState(
        // Hata durumu
        context,
        icon: Icons.error_outline,
        iconColor: AppColors.error,
        message: errorMessage!,
        showRetry: true,
      );
    }

    if (events.isEmpty) {
      return _buildMessageState(
        // Boş liste durumu
        context,
        icon: Icons.event_busy,
        iconColor: context.isDark ? AppColors.primaryDark : AppColors.primary,
        message: emptyMessage ?? 'Henüz etkinlik bulunmamaktadır.',
        description: 'Yeni etkinlikler eklendiğinde burada görüntülenecektir.',
      );
    }

    // Normal liste görünümü
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true, // Liste boyutunu içeriğe göre ayarla
      physics: const ScrollPhysics(), // Kaydırma davranışını belirle
      itemCount: events.length,
      itemBuilder: (context, index) {
        // İlk öğe hariç üst padding ekle
        if (index != 0) {
          return Padding(
            padding: EdgeInsets.only(top: UIConstants.spacingM),
            child: _buildEventCard(context, events[index]),
          );
        }
        return _buildEventCard(context, events[index]);
      },
    );
  }

  /// Tekil etkinlik kartını oluşturan metot
  /// [context]: Build context
  /// [event]: Gösterilecek etkinlik verisi
  Widget _buildEventCard(BuildContext context, Event event) {
    return EventCard(
      event: event,
      onTap: () =>
          context.push('/events/${event.id}'), // Detay sayfasına yönlendir
      isCompact: !isFullScreen, // Görünüm modunu ayarla
    );
  }

  /// Yükleme durumunu gösteren placeholder liste
  Widget _buildLoadingState(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: 3, // 3 adet yükleme placeholder'ı göster
      itemBuilder: (context, index) {
        if (index != 0) {
          return Padding(
            padding: EdgeInsets.only(top: UIConstants.spacingM),
            child: _LoadingCard(isFullScreen: isFullScreen),
          );
        }
        return _LoadingCard(isFullScreen: isFullScreen);
      },
    );
  }

  /// Mesaj durumlarını gösteren widget (hata, boş liste vb.)
  /// [icon]: Gösterilecek ikon
  /// [iconColor]: İkonun rengi
  /// [message]: Ana mesaj metni
  /// [description]: Opsiyonel açıklama metni
  /// [showRetry]: Yeniden deneme butonu gösterilsin mi
  Widget _buildMessageState(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String message,
    String? description,
    bool showRetry = false,
  }) {
    final isDark = context.isDark;

    return Container(
      decoration: AppDecorations.elevated(isDark),
      padding: context.paddingL,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: UIConstants.iconXL,
            color: iconColor,
          ),
          SizedBox(height: UIConstants.spacingM),
          Text(
            message,
            style: AppTextStyles.bodyLarge(
              isDark: isDark,
              color: showRetry
                  ? AppColors.error
                  : null, // Hata durumunda kırmızı text
            ),
            textAlign: TextAlign.center,
          ),
          // Opsiyonel açıklama metni
          if (description != null) ...[
            SizedBox(height: UIConstants.spacingM),
            Text(
              description,
              style: AppTextStyles.bodyMedium(isDark: isDark),
              textAlign: TextAlign.center,
            ),
          ],
          // Yeniden deneme butonu (opsiyonel)
          if (showRetry && onRefresh != null) ...[
            SizedBox(height: UIConstants.spacingM),
            OutlinedButton.icon(
              onPressed: onRefresh,
              icon: const Icon(Icons.refresh),
              label: const Text('Tekrar Dene'),
            ),
          ],
        ],
      ),
    );
  }
}

/// Yükleme durumunda gösterilen placeholder kart widget'ı
class _LoadingCard extends StatelessWidget {
  // Kartın tam ekran mı yoksa kompakt mı olacağını belirten flag
  final bool isFullScreen;

  const _LoadingCard({required this.isFullScreen});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    // Placeholder rengi (tema renginin %10 opaklığında)
    final placeholderColor =
        (isDark ? AppColors.borderDark : AppColors.border).withOpacity(0.1);

    return Container(
      height: isFullScreen ? 200 : 120, // Mod'a göre yükseklik ayarla
      decoration: AppDecorations.elevated(isDark),
      child: Row(
        children: [
          // Sol taraftaki tarih alanı placeholder'ı
          Container(
            width: 70,
            decoration: BoxDecoration(
              color: placeholderColor,
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(UIConstants.radiusXL),
              ),
            ),
          ),
          // Sağ taraftaki içerik placeholder'ları
          Expanded(
            child: Padding(
              padding: context.paddingM,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildPlaceholder(context,
                      width: double.infinity, height: 20), // Başlık
                  SizedBox(height: UIConstants.spacingM),
                  _buildPlaceholder(context,
                      width: context.width * 0.6, height: 16), // Alt başlık
                  // Tam ekran modunda ek detay satırı
                  if (isFullScreen) ...[
                    SizedBox(height: UIConstants.spacingM),
                    _buildPlaceholder(context,
                        width: context.width * 0.3, height: 16), // Detay
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Tekil placeholder container'ı oluşturan yardımcı metot
  /// [width]: Genişlik
  /// [height]: Yükseklik
  Widget _buildPlaceholder(
    BuildContext context, {
    required double width,
    required double height,
  }) {
    final isDark = context.isDark;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color:
            (isDark ? AppColors.borderDark : AppColors.border).withOpacity(0.1),
        borderRadius: context.radiusM,
      ),
    );
  }
}
