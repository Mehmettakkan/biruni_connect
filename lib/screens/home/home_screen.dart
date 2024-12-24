import 'package:biruni_connect/config/routes/route_names.dart';
import 'package:biruni_connect/core/constants/ui/asset_constants.dart';
import 'package:biruni_connect/core/constants/ui/ui_constants.dart';
import 'package:biruni_connect/core/theme/app_colors.dart';
import 'package:biruni_connect/core/utils/extensions/context_extension.dart';
import 'package:biruni_connect/screens/home/widgets/content_list_item.dart'; // Liste öğeleri widget'ı
import 'package:biruni_connect/screens/home/widgets/slider_section.dart'; // Slider bölümü
import 'package:biruni_connect/screens/home/widgets/quick_links_section.dart'; // Hızlı erişim bağlantıları
import 'package:biruni_connect/shared/widgets/profile_avatar.dart'; // Profil avatar widget'ı
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark; // Tema durumunu al (dark/light)

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          // Yenileme işlemi için bekleme süresi
          await Future.delayed(const Duration(seconds: 1));
        },
        child: CustomScrollView(
          // Kaydırma fiziği ayarları
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          slivers: <Widget>[
            // Üst başlık çubuğu
            SliverAppBar(
              pinned: true, // Yukarı kaydırıldığında sabit kal
              floating: true, // Aşağı kaydırıldığında göster
              snap: false, // Ani snap efekti kapalı
              expandedHeight: 90, // Genişletilmiş yükseklik
              // Sol taraftaki bildirim ikonu
              leading: IconButton(
                icon: Icon(
                  Icons.notifications_outlined,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondary,
                ),
                iconSize: UIConstants.iconL,
                onPressed: () {
                  // Bildirimler sayfasına yönlendirme
                },
              ),
              // Esnek başlık alanı
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                // Esneme modları
                stretchModes: const <StretchMode>[
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground,
                  StretchMode.fadeTitle,
                ],
                // Logo
                title: SvgPicture.asset(
                  AssetConstants.logo,
                  height: UIConstants.iconXL,
                ),
              ),
              // Sağ taraftaki profil avatarı
              actions: [
                Padding(
                  padding: context.paddingS,
                  child: ProfileAvatar(
                    onTap: () => context.push(
                        RoutePath.profile), // Profil sayfasına yönlendirme
                    size: UIConstants.iconL,
                  ),
                ),
                context.horizontalSpaceS,
              ],
            ),
            // Ana içerik alanı
            SliverSafeArea(
              sliver: SliverPadding(
                // Kenar boşlukları
                padding: EdgeInsets.only(
                  left: context.paddingM.left,
                  right: context.paddingM.right,
                  bottom: context.paddingM.bottom,
                ),
                // İçerik listesi
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const SliderSection(), // Slider bölümü
                    context.spaceM, // Boşluk
                    const QuickLinksSection(), // Hızlı erişim bağlantıları
                    context.spaceM, // Boşluk
                    const ContentListItem(
                      contentType: 'announcements',
                      title: 'Duyurular',
                      viewAllText: 'Tüm Duyurular',
                    ),
                    context.spaceM, // Boşluk
                    const ContentListItem(
                      contentType: 'news',
                      title: 'Haberler',
                      viewAllText: 'Tüm Haberler',
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
