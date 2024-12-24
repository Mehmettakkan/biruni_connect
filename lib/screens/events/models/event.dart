import 'package:flutter/material.dart';
import 'event_type.dart';
import 'event_status.dart';

class Event {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final DateTime date;
  final String location;
  final EventType eventType;
  final int capacity;
  final int registeredCount;
  final bool registrationRequired;
  final EventStatus status;
  final String organizer;
  final TimeOfDay startTime;
  final TimeOfDay? endTime;
  final List<String> tags;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.date,
    required this.location,
    required this.eventType,
    required this.capacity,
    required this.registeredCount,
    required this.registrationRequired,
    required this.status,
    required this.organizer,
    required this.startTime,
    this.endTime,
    required this.tags,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      date: DateTime.parse(json['date'] as String),
      location: json['location'] as String,
      eventType: EventType.values.firstWhere(
        (e) => e.name == json['eventType'],
        orElse: () => EventType.other,
      ),
      capacity: json['capacity'] as int,
      registeredCount: json['registeredCount'] as int,
      registrationRequired: json['registrationRequired'] as bool,
      status: EventStatus.values.firstWhere(
        (s) => s.name == json['status'],
        orElse: () => EventStatus.upcoming,
      ),
      organizer: json['organizer'] as String,
      startTime: TimeOfDay(
        hour: (json['startTime'] as List<dynamic>)[0] as int,
        minute: (json['startTime'] as List<dynamic>)[1] as int,
      ),
      endTime: json['endTime'] != null
          ? TimeOfDay(
              hour: (json['endTime'] as List<dynamic>)[0] as int,
              minute: (json['endTime'] as List<dynamic>)[1] as int,
            )
          : null,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'date': date.toIso8601String(),
      'location': location,
      'eventType': eventType.name,
      'capacity': capacity,
      'registeredCount': registeredCount,
      'registrationRequired': registrationRequired,
      'status': status.name,
      'organizer': organizer,
      'startTime': [startTime.hour, startTime.minute],
      'endTime': endTime != null ? [endTime!.hour, endTime!.minute] : null,
      'tags': tags,
    };
  }
}
