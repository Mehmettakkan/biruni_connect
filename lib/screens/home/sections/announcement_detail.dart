import 'package:biruni_connect/core/theme/app_text_styles.dart';
import 'package:biruni_connect/mock/hero_section_mock.dart';
import 'package:flutter/material.dart';

class AnnouncementDetail extends StatelessWidget {
  final String? id;

  const AnnouncementDetail({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    // id'yi kullanarak ilgili duyuruyu bulun
    final announcement = mockCarouselItems.firstWhere(
      (item) => item.id == id && item.category == 'announcement',
      orElse: () => throw Exception('Announcement not found'),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Duyuru Detayı'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(announcement.imageUrl),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    announcement.title,
                    style: AppTextStyles.h2(),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    announcement.description,
                    style: AppTextStyles.bodyLarge(),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tarih: ${announcement.date.toString()}',
                    style: AppTextStyles.bodyMedium(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
