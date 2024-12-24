import 'package:biruni_connect/mock/university_mock.dart';
import 'package:flutter/material.dart';
import 'package:biruni_connect/core/utils/extensions/context_extension.dart';
import 'package:biruni_connect/screens/university/models/faculty.dart';
import 'package:biruni_connect/screens/university/models/academic_program.dart';
import 'package:biruni_connect/screens/university/models/university_info.dart';
import 'package:biruni_connect/screens/university/models/contact_info.dart';
import 'package:biruni_connect/screens/university/widgets/about_section.dart';
import 'package:biruni_connect/screens/university/widgets/academic_programs_section.dart';
import 'package:biruni_connect/screens/university/widgets/contact_section.dart';

/// Üniversite bilgilerini gösteren ana ekran.
/// Hakkında, akademik programlar ve iletişim bölümlerini içerir.
class UniversityScreen extends StatefulWidget {
  const UniversityScreen({super.key});

  @override
  State<UniversityScreen> createState() => _UniversityScreenState();
}

class _UniversityScreenState extends State<UniversityScreen> {
  /// Üniversite genel bilgileri
  late final UniversityInfo universityInfo;

  /// Fakülte listesi
  late final List<Faculty> faculties;

  /// Akademik program listesi
  late final List<AcademicProgram> programs;

  /// İletişim bilgileri
  late final ContactInfo contactInfo;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  /// Mock verileri yükleyen fonksiyon
  /// NOT: Gerçek uygulamada bu veriler API'den gelecek
  void _initializeData() {
    // Mock veri setini al
    final mockData = universityMockData;

    // Üniversite bilgilerini dönüştür
    universityInfo = UniversityInfo.fromJson(
      Map<String, dynamic>.from(mockData['universityInfo'] as Map),
    );

    // Fakülte listesini dönüştür
    faculties = (mockData['faculties'] as List)
        .map((faculty) =>
            Faculty.fromJson(Map<String, dynamic>.from(faculty as Map)))
        .toList();

    // Program listesini dönüştür
    programs = (mockData['programs'] as List)
        .map((program) =>
            AcademicProgram.fromJson(Map<String, dynamic>.from(program as Map)))
        .toList();

    // İletişim bilgilerini dönüştür
    contactInfo = ContactInfo.fromJson(
      Map<String, dynamic>.from(mockData['contactInfo'] as Map),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Üniversite'),
      ),
      // Dikey kaydırma için SingleChildScrollView
      body: SingleChildScrollView(
        child: Padding(
          padding: context.paddingM,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Üniversite hakkında bilgileri içeren bölüm
              AboutSection(universityInfo: universityInfo),

              context.spaceXL,

              // Fakülte ve programları gösteren bölüm
              AcademicProgramsSection(
                faculties: faculties,
                programs: programs,
              ),

              context.spaceXL,

              // İletişim bilgilerini gösteren bölüm
              ContactSection(contactInfo: contactInfo),

              // En altta boşluk
              context.spaceL,
            ],
          ),
        ),
      ),
    );
  }
}
