import 'package:biruni_connect/mock/events_mock.dart';
import 'package:biruni_connect/screens/events/models/event_status.dart';
import 'package:biruni_connect/screens/events/widgets/event_actions.dart';
import 'package:flutter/material.dart';
import 'package:biruni_connect/core/constants/ui/ui_constants.dart';
import 'package:biruni_connect/core/theme/app_colors.dart';
import 'package:biruni_connect/core/theme/app_decorations.dart';
import 'package:biruni_connect/core/theme/app_text_styles.dart';
import 'package:biruni_connect/core/utils/extensions/context_extension.dart';
import 'package:biruni_connect/shared/widgets/custom_button.dart';
import 'package:intl/intl.dart';

/// Etkinlik detaylarını gösteren tam sayfa görünüm.
/// Mock veriden gelen etkinlik bilgilerini detaylı şekilde sergiler.
class EventDetailsView extends StatelessWidget {
  final String id;

  const EventDetailsView({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final event = EventsMock.events.firstWhere(
      (event) => event.id == id,
      orElse: () => EventsMock.events.first,
    );

    final isDark = context.isDark;
    final dateFormat = DateFormat('dd MMMM yyyy', 'tr_TR');
    final timeFormat = DateFormat('HH:mm');

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
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
              background: Container(
                padding: EdgeInsets.only(top: context.topPadding),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      event.imageUrl,
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
          SliverToBoxAdapter(
            child: Container(
              decoration: AppDecorations.elevated(isDark),
              margin: EdgeInsets.all(UIConstants.paddingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildEventStatus(context, event, isDark),
                  _buildEventHeader(
                      context, event, isDark, dateFormat, timeFormat),
                  _buildEventInfo(context, event, isDark),
                  _buildDescription(context, event, isDark),
                  if (event.registrationRequired)
                    _buildCapacity(context, event, isDark),
                  if (event.tags.isNotEmpty) _buildTags(context, event, isDark),
                  _buildActions(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Durum ve tür etiketleri
  Widget _buildEventStatus(BuildContext context, dynamic event, bool isDark) {
    return Padding(
      padding: EdgeInsets.all(UIConstants.paddingM),
      child: Wrap(
        spacing: UIConstants.spacingS,
        children: [
          _buildChip(
            context,
            event.status.label,
            _getStatusColor(event.status, isDark),
            isDark,
          ),
          _buildChip(
            context,
            event.eventType.label,
            isDark ? AppColors.secondaryDark : AppColors.secondary,
            isDark,
          ),
        ],
      ),
    );
  }

  /// Başlık ve tarih bilgileri
  Widget _buildEventHeader(BuildContext context, dynamic event, bool isDark,
      DateFormat dateFormat, DateFormat timeFormat) {
    return Padding(
      padding: EdgeInsets.all(UIConstants.paddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event.title,
            style: AppTextStyles.h2(isDark: isDark),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          context.spaceM,
          _buildInfoRow(
            context,
            Icons.calendar_today,
            dateFormat.format(event.date),
            isDark,
            isLarge: true,
          ),
          context.spaceS,
          _buildInfoRow(
            context,
            Icons.access_time,
            '${timeFormat.format(DateTime(2024, 1, 1, event.startTime.hour, event.startTime.minute))}${event.endTime != null ? ' - ${timeFormat.format(DateTime(2024, 1, 1, event.endTime!.hour, event.endTime!.minute))}' : ''}',
            isDark,
            isLarge: true,
          ),
        ],
      ),
    );
  }

  /// Lokasyon ve organizatör bilgileri
  Widget _buildEventInfo(BuildContext context, dynamic event, bool isDark) {
    return Container(
      padding: EdgeInsets.all(UIConstants.paddingM),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceDark.withOpacity(0.5)
            : Colors.grey.shade50,
        border: Border(
          top: BorderSide(
              color: isDark ? AppColors.borderDark : AppColors.border),
          bottom: BorderSide(
              color: isDark ? AppColors.borderDark : AppColors.border),
        ),
      ),
      child: Column(
        children: [
          _buildInfoRow(context, Icons.location_on, event.location, isDark),
          context.spaceM,
          _buildInfoRow(
              context, Icons.group, 'Düzenleyen: ${event.organizer}', isDark),
        ],
      ),
    );
  }

  /// Etkinlik açıklaması
  Widget _buildDescription(BuildContext context, dynamic event, bool isDark) {
    return Padding(
      padding: EdgeInsets.all(UIConstants.paddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Etkinlik Açıklaması', style: AppTextStyles.h4(isDark: isDark)),
          context.spaceS,
          Text(event.description,
              style: AppTextStyles.bodyLarge(isDark: isDark)),
        ],
      ),
    );
  }

  /// Kapasite göstergesi
  Widget _buildCapacity(BuildContext context, dynamic event, bool isDark) {
    final progress = event.registeredCount / event.capacity;
    final isAlmostFull = progress >= 0.8;
    final progressColor = isAlmostFull
        ? AppColors.warning
        : (isDark ? AppColors.secondaryDark : AppColors.secondary);

    return Padding(
      padding: EdgeInsets.all(UIConstants.paddingM),
      child: Container(
        padding: EdgeInsets.all(UIConstants.paddingM),
        decoration: BoxDecoration(
          color: (isDark ? AppColors.primaryDark : AppColors.primary)
              .withOpacity(0.1),
          borderRadius: BorderRadius.circular(UIConstants.radiusL),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Katılımcı Kapasitesi',
                    style: AppTextStyles.bodyMedium(isDark: isDark)),
                Text('${event.registeredCount}/${event.capacity}',
                    style: AppTextStyles.h4(isDark: isDark)),
              ],
            ),
            context.spaceM,
            ClipRRect(
              borderRadius: BorderRadius.circular(UIConstants.radiusS),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor:
                    isDark ? AppColors.borderDark : AppColors.border,
                valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                minHeight: 6,
              ),
            ),
            if (isAlmostFull) ...[
              context.spaceS,
              Text(
                'Kontenjan dolmak üzere!',
                style: AppTextStyles.caption(
                    isDark: isDark, color: AppColors.warning),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Etiketler
  Widget _buildTags(BuildContext context, dynamic event, bool isDark) {
    return Padding(
      padding: EdgeInsets.all(UIConstants.paddingM),
      child: Wrap(
        spacing: UIConstants.spacingS,
        runSpacing: UIConstants.spacingS,
        children: event.tags
            .map<Widget>((tag) => Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: UIConstants.paddingM,
                    vertical: UIConstants.paddingXS,
                  ),
                  decoration: BoxDecoration(
                    color:
                        isDark ? AppColors.surfaceDark : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(UIConstants.radiusM),
                    border: Border.all(
                        color:
                            isDark ? AppColors.borderDark : AppColors.border),
                  ),
                  child: Text('#$tag',
                      style: AppTextStyles.bodySmall(isDark: isDark)),
                ))
            .toList(),
      ),
    );
  }

  /// Alt kısımdaki butonlar
  Widget _buildActions(BuildContext context) {
    final event = EventsMock.events.firstWhere(
      (event) => event.id == id,
      orElse: () => EventsMock.events.first,
    );

    return Padding(
      padding: EdgeInsets.all(UIConstants.paddingM),
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              type: ButtonType.secondary,
              text: 'Paylaş',
              icon: Icons.share,
              onPressed: () => EventActions.shareEvent(context, event),
              size: ButtonSize.large,
              isFullWidth: true,
              isLoading: false,
            ),
          ),
          context.horizontalSpaceM,
          Expanded(
            child: CustomButton(
              type: ButtonType.primary,
              text: 'Ekle',
              icon: Icons.calendar_month,
              onPressed: () => EventActions.addToCalendar(context, event),
              size: ButtonSize.large,
              isFullWidth: true,
              isLoading: false,
            ),
          ),
        ],
      ),
    );
  }

  /// Durum ve tür etiketleri için chip widget'ı
  Widget _buildChip(
      BuildContext context, String label, Color color, bool isDark) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: UIConstants.paddingM,
        vertical: UIConstants.paddingXS,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(UIConstants.radiusM),
        border: Border.all(color: color),
      ),
      child: Text(label, style: AppTextStyles.caption(color: color)),
    );
  }

  /// İkon ve metin içeren satır widget'ı
  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String text,
    bool isDark, {
    bool isLarge = false,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: isLarge ? UIConstants.iconM : UIConstants.iconS,
          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
        ),
        SizedBox(width: isLarge ? UIConstants.spacingM : UIConstants.spacingS),
        Expanded(
          child: Text(
            text,
            style: isLarge
                ? AppTextStyles.bodyLarge(isDark: isDark)
                : AppTextStyles.bodyMedium(isDark: isDark),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ],
    );
  }

  /// Etkinlik durumuna göre renk döndürür
  Color _getStatusColor(EventStatus status, bool isDark) {
    switch (status) {
      case EventStatus.upcoming:
        return isDark ? AppColors.secondaryDark : AppColors.secondary;
      case EventStatus.ongoing:
        return AppColors.success;
      case EventStatus.completed:
        return isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;
      case EventStatus.cancelled:
        return AppColors.error;
    }
  }
}
