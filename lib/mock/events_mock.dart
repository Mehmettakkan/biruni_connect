import 'package:biruni_connect/screens/events/models/event.dart';
import 'package:biruni_connect/screens/events/models/event_type.dart';
import 'package:biruni_connect/screens/events/models/event_status.dart';
import 'package:flutter/material.dart';

class EventsMock {
  static final List<Event> events = [
    Event(
      id: 'events_1',
      title: 'Bahar Şenlikleri 2024',
      description:
          'Geleneksel bahar şenlikleri 15-20 Nisan tarihleri arasında düzenlenecektir.',
      imageUrl: 'assets/images/placeholder_festival.jpg',
      date: DateTime(2024, 4, 15),
      location: 'Merkez Kampüs',
      eventType: EventType.festival,
      capacity: 1000,
      registeredCount: 750,
      registrationRequired: true,
      status: EventStatus.upcoming,
      organizer: 'Öğrenci Konseyi',
      startTime: const TimeOfDay(hour: 10, minute: 0),
      endTime: const TimeOfDay(hour: 18, minute: 0),
      tags: ['müzik', 'eğlence', 'konser', 'yemek'],
    ),
    Event(
      id: 'events_2',
      title: 'Kariyer Günleri',
      description:
          'Sektör liderleri ile buluşma fırsatı sunan kariyer günleri etkinliği.',
      imageUrl: 'assets/images/placeholder_career.jpg',
      date: DateTime(2024, 5, 10),
      location: 'Konferans Salonu',
      eventType: EventType.career,
      capacity: 300,
      registeredCount: 180,
      registrationRequired: true,
      status: EventStatus.upcoming,
      organizer: 'Kariyer Merkezi',
      startTime: const TimeOfDay(hour: 9, minute: 30),
      endTime: const TimeOfDay(hour: 17, minute: 0),
      tags: ['kariyer', 'networking', 'iş dünyası'],
    ),
    Event(
      id: 'events_3',
      title: 'Bilim ve Teknoloji Festivali',
      description:
          'Öğrenci projelerinin sergileneceği bilim ve teknoloji festivali.',
      imageUrl: 'assets/images/placeholder_tech.jpg',
      date: DateTime(2024, 5, 20),
      location: 'Merkez Kampüs Fuaye Alanı',
      eventType: EventType.cultural,
      capacity: 500,
      registeredCount: 320,
      registrationRequired: false,
      status: EventStatus.upcoming,
      organizer: 'Mühendislik Fakültesi',
      startTime: const TimeOfDay(hour: 10, minute: 0),
      endTime: const TimeOfDay(hour: 16, minute: 30),
      tags: ['teknoloji', 'bilim', 'proje', 'sergi'],
    ),
    Event(
      id: 'events_4',
      title: 'Spor Turnuvaları',
      description: 'Fakülteler arası spor turnuvaları başlıyor.',
      imageUrl: 'assets/images/placeholder_sports.jpg',
      date: DateTime(2024, 4, 1),
      location: 'Spor Kompleksi',
      eventType: EventType.sports,
      capacity: 200,
      registeredCount: 160,
      registrationRequired: true,
      status: EventStatus.ongoing,
      organizer: 'Spor Koordinatörlüğü',
      startTime: const TimeOfDay(hour: 13, minute: 0),
      endTime: const TimeOfDay(hour: 19, minute: 0),
      tags: ['spor', 'turnuva', 'yarışma'],
    ),
    Event(
      id: 'events_5',
      title: 'Kültür ve Sanat Haftası',
      description: 'Bir hafta boyunca sürecek kültür ve sanat etkinlikleri.',
      imageUrl: 'assets/images/placeholder_culture.jpg',
      date: DateTime(2024, 6, 15),
      location: 'Kültür Merkezi',
      eventType: EventType.cultural,
      capacity: 400,
      registeredCount: 0,
      registrationRequired: false,
      status: EventStatus.upcoming,
      organizer: 'Güzel Sanatlar Fakültesi',
      startTime: const TimeOfDay(hour: 11, minute: 0),
      endTime: const TimeOfDay(hour: 20, minute: 0),
      tags: ['sanat', 'kültür', 'sergi', 'workshop'],
    ),
  ];
}
