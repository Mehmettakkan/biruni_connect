import 'package:biruni_connect/screens/events/models/event_status.dart';
import 'package:flutter/material.dart';
import 'package:biruni_connect/core/constants/ui/ui_constants.dart';
import 'package:biruni_connect/core/theme/app_colors.dart';
import 'package:biruni_connect/core/theme/app_text_styles.dart';
import 'package:biruni_connect/core/utils/extensions/context_extension.dart';
import 'package:biruni_connect/shared/widgets/custom_card.dart';
import 'package:biruni_connect/screens/events/models/event.dart';
import 'package:intl/intl.dart';

/// Etkinlik detaylarını gösteren kart bileşeni.
/// [event] parametresi ile gelen etkinlik bilgilerini kartın farklı bölümlerinde sergiler.
/// [isCompact] true olduğunda sadece temel bilgileri gösterir.
class EventCard extends StatelessWidget {
  final Event event;
  final VoidCallback onTap;
  final bool isCompact;

  const EventCard({
    super.key,
    required this.event,
    required this.onTap,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final timeFormat = DateFormat('HH:mm');
    final statusColor = _getStatusColor(event.status, isDark);

    return CustomCard(
      type: CustomCardType.outlined,
      onTap: onTap,
      padding: EdgeInsets.zero,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildDateStrip(context, statusColor),
            Expanded(
              child: Padding(
                padding: context.paddingM,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitle(context, isDark),
                    context.spaceS,
                    _buildStatusChips(context, isDark, statusColor),
                    context.spaceS,
                    _buildTimeInfo(context, timeFormat, isDark),
                    if (!isCompact) ..._buildExpandedInfo(context, isDark),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Sol şeritte görünen tarih gösterimini oluşturur
  Widget _buildDateStrip(BuildContext context, Color color) {
    return Container(
      width: 70,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(UIConstants.radiusXL),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: UIConstants.paddingM),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            DateFormat('dd').format(event.date),
            style: AppTextStyles.h2(color: Colors.white),
          ),
          Text(
            DateFormat('MMM', 'tr_TR').format(event.date).toUpperCase(),
            style: AppTextStyles.bodyMedium(color: Colors.white),
          ),
        ],
      ),
    );
  }

  /// Etkinlik başlığını oluşturur
  Widget _buildTitle(BuildContext context, bool isDark) {
    return Text(
      event.title,
      style: AppTextStyles.h4(isDark: isDark),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  /// Başlangıç ve bitiş saati bilgisini oluşturur
  Widget _buildTimeInfo(
      BuildContext context, DateFormat timeFormat, bool isDark) {
    final endTimeText = event.endTime != null
        ? ' - ${timeFormat.format(DateTime(2024, 1, 1, event.endTime!.hour, event.endTime!.minute))}'
        : '';
    return _buildIconText(
      context,
      Icons.access_time,
      '${timeFormat.format(DateTime(2024, 1, 1, event.startTime.hour, event.startTime.minute))}$endTimeText',
      isDark,
    );
  }

  /// İkon ve metin içeren satır widget'ı oluşturur
  Widget _buildIconText(
    BuildContext context,
    IconData icon,
    String text,
    bool isDark, {
    Color? color,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: UIConstants.iconS,
          color: color ?? context.colors.onSurfaceVariant,
        ),
        context.horizontalSpaceXS,
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodySmall(isDark: isDark, color: color),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  /// Durum ve tür etiketleri için chip widget'ı oluşturur
  Widget _buildChip(
    BuildContext context,
    String label,
    Color color,
    bool isDark,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: UIConstants.paddingS,
        vertical: UIConstants.paddingXS,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: context.radiusM,
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption(color: color),
      ),
    );
  }

  /// Durum ve tür etiketlerini oluşturur
  Widget _buildStatusChips(
      BuildContext context, bool isDark, Color statusColor) {
    return Wrap(
      spacing: UIConstants.spacingS,
      children: [
        _buildChip(context, event.status.label, statusColor, isDark),
        _buildChip(
          context,
          event.eventType.label,
          isDark ? AppColors.secondaryDark : AppColors.secondary,
          isDark,
        ),
      ],
    );
  }

  /// Kapasite göstergesini oluşturur
  Widget _buildCapacityIndicator(BuildContext context, bool isDark) {
    final progress = event.registeredCount / event.capacity;
    final isAlmostFull = progress >= 0.8;
    final color = isAlmostFull
        ? AppColors.warning
        : (isDark ? AppColors.secondaryDark : AppColors.secondary);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildIconText(
          context,
          Icons.people,
          '${event.registeredCount}/${event.capacity} Katılımcı',
          isDark,
          color: isAlmostFull ? AppColors.warning : null,
        ),
        context.spaceXS,
        ClipRRect(
          borderRadius: context.radiusS,
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: context.colors.onSurfaceVariant.withOpacity(0.1),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 4,
          ),
        ),
      ],
    );
  }

  /// Kompakt olmayan görünümde gösterilen ek bilgileri oluşturur
  List<Widget> _buildExpandedInfo(BuildContext context, bool isDark) {
    final widgets = [
      context.spaceXS,
      _buildIconText(context, Icons.location_on, event.location, isDark),
    ];

    if (event.registrationRequired) {
      widgets.addAll([
        context.spaceXS,
        _buildCapacityIndicator(context, isDark),
      ]);
    }

    return widgets;
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
