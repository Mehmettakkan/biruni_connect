// home_screen.dart

import 'package:biruni_connect/core/constants/ui/asset_constants.dart';
import 'package:biruni_connect/core/constants/ui/ui_constants.dart';
import 'package:biruni_connect/core/theme/app_colors.dart';
import 'package:biruni_connect/core/utils/extensions/context_extension.dart';
import 'package:biruni_connect/screens/home/widgets/content_list_item.dart'; // Yeni import
import 'package:biruni_connect/screens/home/widgets/hero_section.dart';
import 'package:biruni_connect/screens/home/widgets/quick_links_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return Scaffold(
        body: RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            floating: true,
            snap: false,
            expandedHeight: 90,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              stretchModes: const <StretchMode>[
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle,
              ],
              title: SvgPicture.asset(
                AssetConstants.logo,
                height: UIConstants.iconXL,
              ),
            ),
            actions: [
              IconButton(
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
              context.horizontalSpaceS,
            ],
          ),
          SliverSafeArea(
              sliver: SliverPadding(
            padding: EdgeInsets.only(
              left: context.paddingM.left,
              right: context.paddingM.right,
              bottom: context.paddingM.bottom,
            ),
            sliver: SliverList(
                delegate: SliverChildListDelegate([
              const HeroSection(),
              context.spaceM,
              const QuickLinksSection(),
              context.spaceM,
              // AnnouncementsSection yerine ContentListItem kullanımı:
              const ContentListItem(
                contentType: 'announcements',
                title: 'Duyurular',
                viewAllText: 'Tüm Duyurular',
              ),
              context.spaceM,
              // İsterseniz diğer content type'ları da ekleyebilirsiniz:
              const ContentListItem(
                contentType: 'events',
                title: 'Etkinlikler',
                viewAllText: 'Tüm Etkinlikler',
              ),
              context.spaceM,
              const ContentListItem(
                contentType: 'news',
                title: 'Haberler',
                viewAllText: 'Tüm Haberler',
              ),
            ])),
          ))
        ],
      ),
    ));
  }
}
