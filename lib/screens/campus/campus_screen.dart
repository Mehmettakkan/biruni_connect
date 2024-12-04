// Gerekli paketlerin ve dosyaların import edilmesi
import 'package:flutter/material.dart';
import 'package:biruni_connect/core/utils/extensions/context_extension.dart';
import 'package:biruni_connect/screens/campus/widgets/campus_map_section.dart';
import 'package:biruni_connect/screens/campus/widgets/campus_building_card.dart';
import 'package:biruni_connect/screens/campus/widgets/campus_facility_card.dart';
import 'package:biruni_connect/mock/campus_mock.dart';
import 'package:biruni_connect/core/theme/app_text_styles.dart';

/// Kampüs ekranı widget'ı.
/// Kampüs haritası, binalar ve tesisler bölümlerini içerir.
class CampusScreen extends StatelessWidget {
  const CampusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar
      appBar: AppBar(
        title: Text(
          'Kampüs',
          style: AppTextStyles.h3(isDark: context.isDark),
        ),
      ),
      // Ana içerik
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Harita Bölümü
            // Kampüs haritasını ve bina işaretleyicilerini gösterir
            CampusMapSection(
              buildings: CampusMock.buildings,
              onBuildingSelected: (building) {
                // TODO: Bina detay sayfasına yönlendirme yapılacak
                print('Seçilen bina: ${building.name}');
              },
            ),

            context.spaceL,

            // Binalar Bölümü
            // Tüm kampüs binalarını liste halinde gösterir
            Padding(
              padding: context.paddingHorizontalS,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Başlık
                  Text(
                    'Binalar',
                    style: AppTextStyles.h3(isDark: context.isDark),
                  ),
                  context.spaceM,
                  // Bina Listesi
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: CampusMock.buildings.length,
                    separatorBuilder: (context, index) => context.spaceM,
                    itemBuilder: (context, index) {
                      final building = CampusMock.buildings[index];
                      return CampusBuildingCard(
                        building: building,
                        onTap: () {
                          // TODO: Bina detay sayfasına yönlendirme yapılacak
                          print('Tıklanan bina: ${building.name}');
                        },
                      );
                    },
                  ),
                ],
              ),
            ),

            context.spaceL,

            // Tesisler Bölümü
            // Kampüsteki tüm tesisleri liste halinde gösterir
            Padding(
              padding: context.paddingHorizontalS,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Başlık
                  Text(
                    'Tesisler',
                    style: AppTextStyles.h3(isDark: context.isDark),
                  ),
                  context.spaceM,
                  // Tesis Listesi
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: CampusMock.facilities.length,
                    separatorBuilder: (context, index) => context.spaceM,
                    itemBuilder: (context, index) {
                      final facility = CampusMock.facilities[index];
                      return CampusFacilityCard(
                        facility: facility,
                        onTap: () {
                          // TODO: Tesis detay sayfasına yönlendirme yapılacak
                          print('Tıklanan tesis: ${facility.name}');
                        },
                      );
                    },
                  ),
                ],
              ),
            ),

            context.spaceL,
          ],
        ),
      ),
    );
  }
}
