// mock/campus_mock.dart

import 'package:biruni_connect/screens/campus/models/campus_building.dart';
import 'package:biruni_connect/screens/campus/models/campus_facility.dart';
import 'package:flutter/material.dart';

class CampusMock {
  static final List<CampusBuilding> buildings = [
    CampusBuilding(
      id: 'b1',
      name: 'Ana Bina',
      description: 'Biruni Üniversitesi\'nin ana eğitim ve yönetim binası',
      imageUrl: 'assets/images/university/university.jpeg',
      latitude: 41.01744,
      longitude: 28.91595,
      buildingCode: 'A',
      departments: [
        'Tıp Fakültesi',
        'Diş Hekimliği Fakültesi',
        'Rektörlük',
        'Öğrenci İşleri',
      ],
      facilities: [
        'Konferans Salonu',
        'Kafeterya',
        'Öğrenci Lounge',
      ],
      floorCount: '8',
      openingHours: '07:00 - 23:00',
    ),
    CampusBuilding(
      id: 'b2',
      name: 'Sağlık Bilimleri Binası',
      description:
          'Sağlık bilimleri fakültelerinin eğitim ve laboratuvar binası',
      imageUrl: 'assets/images/university/university.jpeg',
      latitude: 41.01767,
      longitude: 28.91645,
      buildingCode: 'B',
      departments: [
        'Hemşirelik Bölümü',
        'Fizyoterapi ve Rehabilitasyon Bölümü',
        'Beslenme ve Diyetetik Bölümü',
      ],
      facilities: [
        'Simülasyon Laboratuvarı',
        'Anatomi Laboratuvarı',
        'Çalışma Alanları',
      ],
      floorCount: '6',
      openingHours: '08:00 - 22:00',
    ),
    CampusBuilding(
      id: 'b3',
      name: 'Kütüphane ve Araştırma Merkezi',
      description: 'Merkez kütüphane ve dijital araştırma merkezi',
      imageUrl: 'assets/images/university/university.jpeg',
      latitude: 41.01783,
      longitude: 28.91709,
      buildingCode: 'KB',
      departments: [
        'Kütüphane',
        'Dijital Öğrenme Merkezi',
        'Araştırma Laboratuvarları',
      ],
      facilities: [
        'Sessiz Çalışma Alanları',
        'Grup Çalışma Odaları',
        'Multimedya Merkezi',
      ],
      floorCount: '4',
      openingHours: '07:00 - 24:00',
    ),
    CampusBuilding(
      id: 'b4',
      name: 'Mühendislik ve Mimarlık Fakültesi',
      description:
          'Mühendislik ve Mimarlık programları için eğitim ve laboratuvar binası',
      imageUrl: 'assets/images/university/university.jpeg',
      latitude: 41.01761613016886,
      longitude: 28.916842199463254,
      buildingCode: 'C',
      departments: [
        'Bilgisayar Mühendisliği',
        'Yazılım Mühendisliği',
        'Mimarlık',
        'İç Mimarlık ve Çevre Tasarımı',
        'Endüstri Mühendisliği'
      ],
      facilities: [
        'Bilgisayar Laboratuvarları',
        'Tasarım Stüdyoları',
        'Maker Lab',
        'CAD/CAM Laboratuvarı',
      ],
      floorCount: '7',
      openingHours: '08:00 - 22:00',
    ),
    CampusBuilding(
      id: 'b5',
      name: 'Biruni Üniversitesi Diş Hastanesi',
      description: 'Modern diş tedavi ve eğitim hastanesi',
      imageUrl: 'assets/images/university/university.jpeg',
      latitude: 41.01803458593299,
      longitude: 28.91721193904041,
      buildingCode: 'D',
      departments: [
        'Diş Klinikleri',
        'Ortodonti',
        'Ağız ve Diş Cerrahisi',
        'Protez Laboratuvarı'
      ],
      facilities: [
        'Hasta Kabul',
        'Radyoloji',
        'Sterilizasyon Ünitesi',
        'Öğrenci Klinikleri'
      ],
      floorCount: '5',
      openingHours: '08:00 - 17:00',
    ),
    CampusBuilding(
      id: 'b6',
      name: 'Biruni Üniversitesi Hastanesi',
      description: 'Tam teşekküllü eğitim ve araştırma hastanesi',
      imageUrl: 'assets/images/university/university.jpeg',
      latitude: 40.99809430518678,
      longitude: 28.796504495023747,
      buildingCode: 'H',
      departments: [
        'Acil Servis',
        'Poliklinikler',
        'Ameliyathane',
        'Yoğun Bakım',
        'Görüntüleme Merkezi'
      ],
      facilities: [
        'MR ve Tomografi',
        'Laboratuvarlar',
        'Kafeterya',
        'Eczane',
        'Hasta Kabul'
      ],
      floorCount: '10',
      openingHours: '24 Saat Açık',
    ),
    CampusBuilding(
      id: 'b7',
      name: 'Kız Öğrenci Yurdu',
      description: 'Modern ve güvenli kız öğrenci yurdu',
      imageUrl: 'assets/images/university/university.jpeg',
      latitude: 41.003239,
      longitude: 28.919963,
      buildingCode: 'G',
      departments: ['Yurt Yönetimi', 'Öğrenci Yaşam Alanları'],
      facilities: [
        'Etüt Salonları',
        'Çamaşırhane',
        'Mutfak',
        'Dinlenme Salonları',
        'Spor Salonu'
      ],
      floorCount: '8',
      openingHours: '24 Saat Açık',
    ),
    CampusBuilding(
      id: 'b8',
      name: 'Erkek Öğrenci Yurdu',
      description: 'Modern ve güvenli erkek öğrenci yurdu',
      imageUrl: 'assets/images/university/university.jpeg',
      latitude: 41.003889,
      longitude: 28.920094,
      buildingCode: 'H',
      departments: ['Yurt Yönetimi', 'Öğrenci Yaşam Alanları'],
      facilities: [
        'Etüt Salonları',
        'Çamaşırhane',
        'Mutfak',
        'Dinlenme Salonları',
        'Spor Salonu'
      ],
      floorCount: '8',
      openingHours: '24 Saat Açık',
    ),
    CampusBuilding(
      id: 'b9',
      name: 'Biruni Teknopark',
      description: 'Teknoloji ve inovasyon merkezi',
      imageUrl: 'assets/images/university/university.jpeg',
      latitude: 41.00318884795413,
      longitude: 28.918958741854816,
      buildingCode: 'I',
      departments: [
        'Kuluçka Merkezi',
        'AR-GE Ofisleri',
        'Teknoloji Transfer Ofisi',
        'Start-up Merkezleri'
      ],
      facilities: [
        'Toplantı Salonları',
        'Co-Working Alanları',
        'Seminer Salonları',
        'Prototip Atölyeleri'
      ],
      floorCount: '6',
      openingHours: '08:00 - 20:00',
    ),
  ];
  static final List<CampusFacility> facilities = [
    CampusFacility(
      id: 'f1',
      name: 'Merkez Kütüphane',
      description:
          'Modern kaynaklar ve çalışma alanları ile donatılmış merkez kütüphane',
      iconName: Icons.local_library.codePoint.toString(), // Library icon
      location: '3. Kat',
      openingHours: '7/24 Açık',
      contactInfo: 'kutuphane@biruni.edu.tr',
      services: [
        'Kitap Ödünç Alma',
        'Online Veritabanı Erişimi',
        'Grup Çalışma Odaları',
        'Bireysel Çalışma Alanları',
      ],
      buildingId: 'b3',
    ),
    CampusFacility(
      id: 'f2',
      name: 'Ana Kafeterya',
      description: 'Öğrenci ve personel için merkezi yemek alanı',
      iconName: Icons.restaurant.codePoint.toString(), // Restaurant icon
      location: 'Zemin Kat',
      openingHours: '08:00 - 20:00',
      contactInfo: 'kafeterya@biruni.edu.tr',
      services: [
        'Kahvaltı',
        'Öğle Yemeği',
        'Akşam Yemeği',
        'Cafe Hizmetleri',
      ],
      buildingId: 'b1',
    ),
    CampusFacility(
      id: 'f3',
      name: 'Spor Merkezi',
      description: 'Kapalı spor salonu ve fitness merkezi',
      iconName:
          Icons.fitness_center.codePoint.toString(), // Fitness center icon
      location: '-1. Kat',
      openingHours: '09:00 - 22:00',
      contactInfo: 'spor@biruni.edu.tr',
      services: [
        'Fitness Salonu',
        'Basketbol Sahası',
        'Pilates Stüdyosu',
        'Duş ve Soyunma Odaları',
      ],
      buildingId: 'b1',
    ),
  ];
}
