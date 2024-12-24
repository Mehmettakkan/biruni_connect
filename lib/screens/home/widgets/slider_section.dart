// Gerekli paketlerin import edilmesi
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

// Ana widget sınıfı - Kategori değişimi ve slider indeks değişimlerini tutmak için
class SliderSection extends StatefulWidget {
  const SliderSection({super.key});

  @override
  State<SliderSection> createState() => _SliderSectionState();
}

class _SliderSectionState extends State<SliderSection> {
  // Slider'ın aktif slide indeksi
  int _currentIndex = 0;
  // Seçili kategori (varsayılan olarak duyurular)
  String _selectedCategory = 'announcements';

  // Seçili kategoriye göre gösterilecek içeriği döndüren getter methodu
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
    // Dark mode kontrolü
    final isDark = context.isDark;

    return Column(
      children: [
        // Üst kısımdaki kategori butonları
        Padding(
          padding: context.paddingHorizontalL,
          child: Row(
            children: [
              // Duyurular butonu
              _CategoryButton(
                title: 'Duyurular',
                isSelected: _selectedCategory == 'announcements',
                onTap: () => _updateCategory('announcements'),
              ),
              context.horizontalSpaceS,
              // Etkinlikler butonu
              _CategoryButton(
                title: 'Etkinlikler',
                isSelected: _selectedCategory == 'events',
                onTap: () => _updateCategory('events'),
              ),
              context.horizontalSpaceS,
              // Haberler butonu
              _CategoryButton(
                title: 'Haberler',
                isSelected: _selectedCategory == 'news',
                onTap: () => _updateCategory('news'),
              ),
            ],
          ),
        ),
        context.spaceM,
        // Carousel Slider widget'ı
        CarouselSlider.builder(
          itemCount: _filteredItems.length, // Kaç tane slide olacak
          itemBuilder: (context, index, realIndex) {
            // Her bir slide nasıl görünecek
            final item = _filteredItems[index]; // O anki slide'ın verisi

            // Her bir slide için tıklanabilir widget
            // Tıklanabilir olması için
            return GestureDetector(
              // Detay sayfasına yönlendirme
              onTap: () => context.push('/${_selectedCategory}/${item.id}'),
              // Sayfa geçişlerinde animasyon için Hero widget'ı
              child: Hero(
                tag: 'hero_${item.id}',
                child: Container(
                  // Slide container'ı için stil
                  decoration: BoxDecoration(
                    borderRadius: context.radiusXL,
                    // Gölge efekti
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
                    // İç içe widget'lar için Stack
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // Arka plan resmi
                        Image.asset(
                          item.imageUrl,
                          fit: BoxFit.cover,
                        ),
                        // Gradient overlay - resmin üzerine siyah gradient
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
                        // Alt kısımdaki başlık ve etiket
                        Positioned(
                          bottom: UIConstants.paddingM,
                          left: UIConstants.paddingM,
                          right: UIConstants.paddingM,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Kategori etiketi (DUYURU, ETKİNLİK, HABER)
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
                              // İçerik başlığı
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
          // Carousel ayarları
          options: CarouselOptions(
            // Responsive yükseklik
            height: context.isPhone ? 280 : 360,
            // Görünür alan oranı
            viewportFraction: context.isPhone ? 0.85 : 0.75,
            // Ortadaki slide'ı büyüt
            enlargeCenterPage: true,
            enlargeFactor: 0.2,
            // Sonsuz scroll
            enableInfiniteScroll: true,
            // Otomatik geçiş
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.easeInOutCubic,
            // Slide değiştiğinde index'i güncelle
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        context.spaceM,
        // Alt kısımdaki slider gösterge noktaları
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            // Her slide için bir nokta oluştur
            _filteredItems.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              // Aktif nokta daha geniş
              width: _currentIndex == index ? 24 : 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                // Aktif/pasif noktalar için farklı renkler
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

  // Kategori değiştirme methodu
  void _updateCategory(String category) {
    setState(() {
      _selectedCategory = category;
      _currentIndex = 0; // Kategori değişince slider'ı başa al
    });
  }

  // Kategoriye göre renk döndüren method
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

  // Kategoriye göre metin döndüren method
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

// Kategori butonları için özel widget
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

    // Butonun expanded içinde olması her butona eşit genişlik verir
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        // Animasyonlu container - seçilme durumuna göre renk değişir
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: context.paddingVerticalS,
          decoration: BoxDecoration(
            // Seçili durumda dolgu rengi, değilse şeffaf
            color: isSelected
                ? (isDark ? AppColors.primaryDark : AppColors.primary)
                : Colors.transparent,
            borderRadius: context.radiusM,
            // Kenarlık
            border: Border.all(
              color: isDark ? AppColors.primaryDark : AppColors.primary,
              width: 1.5,
            ),
          ),
          child: Text(
            title,
            style: AppTextStyles.buttonMedium(
              // Seçili durumda yazı rengi beyaz, değilse primary renk
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
