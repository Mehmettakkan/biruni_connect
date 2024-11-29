import 'package:flutter/material.dart';
import 'package:biruni_connect/shared/widgets/custom_card.dart';

class AnnouncementsSection extends StatelessWidget {
  const AnnouncementsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Duyurular'),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) => const Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: CustomCard(
              type: CustomCardType.info,
              child: ListTile(
                title: Text('Duyuru Başlığı'),
                subtitle: Text('Duyuru içeriği kısa açıklama'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
