import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:add_2_calendar/add_2_calendar.dart' as add2calendar;
import 'package:biruni_connect/screens/events/models/event.dart';

class EventActions {
  static Future<void> shareEvent(BuildContext context, Event event) async {
    try {
      final String shareText = '''
${event.title}

📅 Tarih: ${_formatDate(event.date)}
⏰ Saat: ${_formatTime(event.startTime)}${event.endTime != null ? ' - ${_formatTime(event.endTime!)}' : ''}
📍 Konum: ${event.location}
👥 Düzenleyen: ${event.organizer}

${event.description}

#BiruniConnect ${event.tags.map((tag) => '#$tag').join(' ')}
''';

      await Share.share(
        shareText,
        subject: event.title,
      );
    } catch (e) {
      _showErrorSnackbar(context, 'Paylaşım sırasında bir hata oluştu');
    }
  }

  static Future<void> addToCalendar(BuildContext context, Event event) async {
    try {
      final calendarEvent = add2calendar.Event(
        title: event.title,
        description: event.description,
        location: event.location,
        startDate: DateTime(
          event.date.year,
          event.date.month,
          event.date.day,
          event.startTime.hour,
          event.startTime.minute,
        ),
        endDate: event.endTime != null
            ? DateTime(
                event.date.year,
                event.date.month,
                event.date.day,
                event.endTime!.hour,
                event.endTime!.minute,
              )
            : DateTime(
                event.date.year,
                event.date.month,
                event.date.day,
                event.startTime.hour + 1,
                event.startTime.minute,
              ),
      );

      final bool success =
          await add2calendar.Add2Calendar.addEvent2Cal(calendarEvent);

      if (success && context.mounted) {
        _showSuccessSnackbar(context, 'Etkinlik takviminize eklendi');
      }
    } catch (e) {
      _showErrorSnackbar(context, 'Takvime eklenirken bir hata oluştu');
    }
  }

  static String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  static String _formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  static void _showErrorSnackbar(BuildContext context, String message) {
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  static void _showSuccessSnackbar(BuildContext context, String message) {
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }
}
