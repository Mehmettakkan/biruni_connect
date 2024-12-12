import 'package:biruni_connect/core/constants/ui/ui_constants.dart';
import 'package:biruni_connect/core/theme/app_colors.dart';
import 'package:biruni_connect/core/theme/app_text_styles.dart';
import 'package:biruni_connect/core/utils/extensions/context_extension.dart';
import 'package:biruni_connect/mock/announcements_mock.dart';
import 'package:biruni_connect/mock/events_mock.dart';
import 'package:biruni_connect/mock/news_mock.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  int _currentIndex = 0;
  String _selectedCategory = 'announcements';

  List<dynamic> get _filteredItems {
    switch (_selectedCategory) {
      case 'announcements':
        return AnnouncementsMock.announcements;
      case 'events':
        return EventsMock.events;
      case 'news':
        return NewsMock.news;
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return Column(
      children: [
        Padding(
          padding: context.paddingHorizontalL,
          child: Row(
            children: [
              _CategoryButton(
                title: 'Duyurular',
                isSelected: _selectedCategory == 'announcements',
                onTap: () => _updateCategory('announcements'),
              ),
              context.horizontalSpaceS,
              _CategoryButton(
                title: 'Etkinlikler',
                isSelected: _selectedCategory == 'events',
                onTap: () => _updateCategory('events'),
              ),
              context.horizontalSpaceS,
              _CategoryButton(
                title: 'Haberler',
                isSelected: _selectedCategory == 'news',
                onTap: () => _updateCategory('news'),
              ),
            ],
          ),
        ),
        context.spaceM,
        CarouselSlider.builder(
          itemCount: _filteredItems.length,
          itemBuilder: (context, index, realIndex) {
            final item = _filteredItems[index];

            return GestureDetector(
              onTap: () => context.push('/${_selectedCategory}/${item.id}'),
              child: Hero(
                tag: 'hero_${item.id}',
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: context.radiusXL,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: context.radiusXL,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          item.imageUrl,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.8),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: UIConstants.paddingM,
                          left: UIConstants.paddingM,
                          right: UIConstants.paddingM,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: UIConstants.paddingS,
                                  vertical: UIConstants.paddingXS,
                                ),
                                decoration: BoxDecoration(
                                  color: _getCategoryColor(
                                      _selectedCategory, isDark),
                                  borderRadius: context.radiusM,
                                ),
                                child: Text(
                                  _getCategoryText(_selectedCategory),
                                  style: AppTextStyles.caption(
                                    color: AppColors.surface,
                                  ),
                                ),
                              ),
                              context.spaceS,
                              Text(
                                item.title,
                                style: AppTextStyles.h3(
                                  color: AppColors.surface,
                                ).copyWith(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: context.isPhone ? 280 : 360,
            viewportFraction: context.isPhone ? 0.85 : 0.75,
            enlargeCenterPage: true,
            enlargeFactor: 0.2,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.easeInOutCubic,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        context.spaceM,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _filteredItems.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: _currentIndex == index ? 24 : 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: _currentIndex == index
                    ? (isDark ? AppColors.secondaryDark : AppColors.secondary)
                    : (isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondary)
                        .withOpacity(0.3),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _updateCategory(String category) {
    setState(() {
      _selectedCategory = category;
      _currentIndex = 0;
    });
  }

  Color _getCategoryColor(String category, bool isDark) {
    switch (category) {
      case 'announcements':
        return isDark ? AppColors.primaryDark : AppColors.primary;
      case 'events':
        return isDark ? AppColors.secondaryDark : AppColors.secondary;
      case 'news':
        return isDark ? AppColors.accentDark : AppColors.accent;
      default:
        return isDark ? AppColors.primaryDark : AppColors.primary;
    }
  }

  String _getCategoryText(String category) {
    switch (category) {
      case 'announcements':
        return 'DUYURU';
      case 'events':
        return 'ETKİNLİK';
      case 'news':
        return 'HABER';
      default:
        return 'DUYURU';
    }
  }
}

class _CategoryButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryButton({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: context.paddingVerticalS,
          decoration: BoxDecoration(
            color: isSelected
                ? (isDark ? AppColors.primaryDark : AppColors.primary)
                : Colors.transparent,
            borderRadius: context.radiusM,
            border: Border.all(
              color: isDark ? AppColors.primaryDark : AppColors.primary,
              width: 1.5,
            ),
          ),
          child: Text(
            title,
            style: AppTextStyles.buttonMedium(
              color: isSelected
                  ? AppColors.surface
                  : (isDark ? AppColors.primaryDark : AppColors.primary),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
