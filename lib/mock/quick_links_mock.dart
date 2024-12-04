import 'package:flutter/material.dart';

class QuickAccessItem {
  final String id;
  final String title;
  final IconData icon;
  final String route;
  final String? subtitle;
  final Color? iconColor;
  final bool isExternal;

  QuickAccessItem({
    required this.id,
    required this.title,
    required this.icon,
    required this.route,
    this.subtitle,
    this.iconColor,
    this.isExternal = false,
  });
}

final List<QuickAccessItem> mockQuickAccessItems = [
  QuickAccessItem(
    id: 'student_portal',
    title: 'Öğrenci Portalı',
    icon: Icons.person,
    route: 'https://sis.biruni.edu.tr/',
    subtitle: 'Kişisel bilgiler ve duyurular',
    isExternal: true,
  ),
  QuickAccessItem(
    id: 'class_schedule',
    title: 'Ders Programı',
    icon: Icons.schedule,
    route: 'https://ders.biruni.edu.tr/index.php',
    subtitle: 'Günlük ve haftalık ders saatleri',
    isExternal: true,
  ),
  QuickAccessItem(
    id: 'library',
    title: 'Kütüphane',
    icon: Icons.library_books,
    route: 'https://kutuphane.biruni.edu.tr/',
    subtitle: 'Kitap ve dijital kaynaklar',
    isExternal: true,
  ),
  QuickAccessItem(
    id: 'academic_calendar',
    title: 'Akademik Takvim',
    icon: Icons.calendar_month,
    route: 'https://www.biruni.edu.tr/ogrenci/akademik-takvim',
    subtitle: 'Tatil ve sınav tarihleri',
  ),
  QuickAccessItem(
    id: 'email',
    title: 'E-Posta',
    icon: Icons.mail,
    route: 'https://www.biruni.edu.tr/iletisimm',
    isExternal: true,
  ),
  QuickAccessItem(
    id: 'lms',
    title: 'Eğitim Platformu',
    icon: Icons.laptop_chromebook,
    route: 'https://bem.biruni.edu.tr/',
    subtitle: 'Ödev ve online dersler',
    isExternal: true,
  ),
  QuickAccessItem(
    id: 'cafeteria_menu',
    title: 'Yemekhane Menüsü',
    icon: Icons.fastfood,
    route: 'https://www.biruni.edu.tr/YEMEK/YEMEK.PDF',
    subtitle: 'Günlük yemek seçenekleri',
    isExternal: true,
  ),
  QuickAccessItem(
    id: 'transportation',
    title: 'Ulaşım Bilgisi',
    icon: Icons.directions_bus,
    route:
        'https://aday.biruni.edu.tr/haberler/haberler/istanbul-un-kalbinin-attigi-yerde-sehir-merkezindeyiz',
    subtitle: 'Servis ve otobüs saatleri',
    isExternal: true,
  ),
];
