import 'package:biruni_connect/screens/events/models/event.dart';
import 'package:biruni_connect/screens/events/models/event_type.dart';
import 'package:biruni_connect/screens/events/models/event_status.dart';
import 'package:flutter/material.dart';

class EventsMock {
  static final List<Event> events = [
    Event(
      id: 'events_1',
      title: 'Sinirbilim Kursu: Prof. Dr. Oytun Erbaş ile Derinlemesine Eğitim',
      description: '''
30 Kasım - 1 Aralık tarihlerinde Biruni Üniversitesi Konferans Salonu'nda gerçekleşecek Sinirbilim Kursu, beyin ve sinir sistemi üzerine derinlemesine bir eğitim sunuyor. 
Kurs kapsamında, deney hayvanlarının özellikleri, ilaç uygulama teknikleri, beyin loblarının anatomik ve fonksiyonel yapıları ile nöron ve glia kavramları üzerinde durulacak. Ayrıca aksiyon potansiyeli, EPSP, IPSP ve nörotransmitterlerin biyokimyasal özellikleri detaylandırılacak. Öğrenme, hafıza, hipokampüsün fonksiyonları gibi önemli beyin süreçlerinin yanı sıra depresyon, bipolar bozukluk, şizofreni ve otizm gibi psikiyatrik bozuklukların beyin üzerindeki etkileri tartışılacak. Kurs boyunca, nörodejeneratif ve konjenital hastalıkların mekanizmaları, deney hayvanları üzerinde yapılan davranış testleri ve bu hastalıkların modellemeleri de ele alınacak. 
EEG ve EMG elektrot yapımı ve kayıt süreçleriyle ilgili uygulamalı bilgiler sunulacak. 
Tüm katılımcılara sertifika verilecektir.''',
      imageUrl: 'assets/images/events/neuroscience-course.jpeg',
      date: DateTime(2024, 11, 30),
      location: 'Biruni Üniversitesi Konferans Salonu',
      eventType: EventType.seminar,
      capacity: 1000,
      registeredCount: 750,
      registrationRequired: true,
      status: EventStatus.completed,
      organizer: 'Öğrenci Konseyi',
      startTime: const TimeOfDay(hour: 10, minute: 0),
      endTime: const TimeOfDay(hour: 18, minute: 0),
      tags: [
        'sinirbilim',
        'eğitim',
        'kurs',
        'psikiyatri',
        'beyin',
        'nörolojik hastalıklar'
      ],
    ),
    Event(
      id: 'events_2',
      title: '4. Adli Bilimler Sempozyumu',
      description:
          '''Moleküler Biyoloji ve Genetik Topluluğu'nun her yıl geleneksel olarak düzenlediği Adli Bilimler Sempozyumu'nun 4.sü bu sene büyük bir ilgiyle gerçekleştirildi. Vaka çözümlemeleri ve kullanılan yöntemlerin derinlemesine ele alındığı sempozyumda, alanında uzman isimler değerli bilgilerini katılımcılarla paylaştı. Biruni Üniversitesi olarak bilime olan katkımızı sürdürüyoruz, teşekkürler tüm katılımcılara!''',
      imageUrl: 'assets/images/events/forensic-sciences.jpeg',
      date: DateTime(2024, 5, 10),
      location: 'Konferans Salonu',
      eventType: EventType.seminar,
      capacity: 300,
      registeredCount: 180,
      registrationRequired: false,
      status: EventStatus.upcoming,
      organizer: 'Moleküler Biyoloji ve Genetik Topluluğu',
      startTime: const TimeOfDay(hour: 9, minute: 30),
      endTime: const TimeOfDay(hour: 17, minute: 0),
      tags: [
        'adli bilimler',
        'moleküler biyoloji',
        'genetik',
        'bilimsel etkinlik',
        'akademik'
      ],
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
      title:
          'İmza Günü Etkinliği: Multidisipliner Yaklaşımla Doğaya Saygılı Bitki Bazlı Beslenme Rehberi 📚',
      description:
          "Alanında uzman 26 yazarın katkılarıyla, Dr. Öğr. Üy. Enver Çıracı'nın editörlüğünü yaptığı 'Multidisipliner Yaklaşımla Doğaya Saygılı Bitki Bazlı Beslenme Rehberi' adlı kitabının imza günü etkinliğinde sizleri aramızda görmekten mutluluk duyarız. Bitki bazlı beslenme konusunda rehber niteliği taşıyan bu eserin geliri, UNICEF Türkiye'ye bağışlanarak çocukların geleceğine katkı sağlanacaktır.",
      imageUrl: 'assets/images/events/book-event.jpg',
      date: DateTime(2024, 10, 17),
      location: 'Medbooks & Coffe',
      eventType: EventType.cultural,
      capacity: 400,
      registeredCount: 0,
      registrationRequired: false,
      status: EventStatus.completed,
      organizer: 'Beslenme ve Diyetetik',
      startTime: const TimeOfDay(hour: 16, minute: 30),
      endTime: const TimeOfDay(hour: 18, minute: 0),
      tags: ['sanat', 'kültür', 'sergi', 'workshop'],
    ),
  ];
}
