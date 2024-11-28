import 'package:biruni_connect/core/theme/app_decorations.dart';
import 'package:biruni_connect/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:biruni_connect/core/constants/ui/ui_constants.dart';
import 'package:biruni_connect/core/theme/app_colors.dart';
import 'package:biruni_connect/core/theme/app_text_styles.dart';

// Bottom Navigation Bar'da kullanılacak her bir öğenin veri modelini temsil eder
// Bu sınıf sadece veri tutmaktan sorumludur (Data Layer)
class _BottomNavItem {
  // Item'ın altında gösterilecek metin
  final String label;

  // Seçili olmadığında gösterilecek ikon
  final IconData icon;

  // Seçili olduğunda gösterilecek ikon
  final IconData activeIcon;

  // Item üzerinde gösterilecek bildirim sayısı (opsiyonel)
  final String? badge;

  // Constructor: Tüm item verisini almak için kullanılır
  const _BottomNavItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
    this.badge,
  });
}

// Her bir navigation item'ın görünümünü oluşturan widget
// Sadece görünümden sorumludur (UI Layer)
class _BottomNavItemWidget extends StatelessWidget {
  // İtem verisi
  final _BottomNavItem item;

  // İtem'ın seçili olup olmadığını belirtir
  final bool isSelected;

  // İtem'a tıklandığında çalışacak fonksiyon
  final VoidCallback onTap;

  // Constructor: İlgili parametreleri alır
  const _BottomNavItemWidget({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Tema kontrolü (dark mode'da mı değil mi)
    final isDark = context.isDark;

    // Seçili duruma göre renk belirleme
    final color = isSelected
        ? (isDark ? AppColors.secondaryDark : AppColors.secondary)
        : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondary);

    return InkWell(
      // İtem'a tıklanınca çalışacak fonksiyon
      onTap: onTap,
      // Tıklama efektini yuvarlak yapar
      customBorder: const CircleBorder(),
      child: Container(
        // İçerik düzenleme: Padding ekleniyor
        padding: context.paddingM,
        child: Column(
          mainAxisSize: MainAxisSize.min, // Minimum alan kaplayacak
          children: [
            // İkon ve badge'i içeren Stack
            Stack(
              clipBehavior:
                  Clip.none, // Stack sınırları dışına taşmaya izin ver
              children: [
                // Ana ikon (seçili ya da seçili değil)
                Icon(
                  isSelected ? item.activeIcon : item.icon,
                  color: color, // Duruma göre renk
                  size: UIConstants.iconM, // Standart ikon boyutu
                ),
                // Eğer badge varsa (örneğin bildirim sayısı) göster
                if (item.badge != null)
                  Positioned(
                    right: -5, // Pozisyon: İkonun sağ üst köşesi
                    top: -5,
                    child: Container(
                      padding: const EdgeInsets.all(4), // Badge'in iç dolgusu
                      decoration: const BoxDecoration(
                        color: Colors.red, // Arka plan rengi (kırmızı)
                        shape: BoxShape.circle, // Daire şeklinde
                      ),
                      child: Text(
                        item.badge!, // Badge metni (örneğin "2")
                        style: AppTextStyles.bodyLarge(), // Metin stili
                      ),
                    ),
                  ),
              ],
            ),
            // İkon ile metin arası boşluk
            context.spaceXS,
            // Item metni (örneğin "Ana Sayfa")
            Text(
              item.label,
              style: AppTextStyles.caption(
                isDark: isDark, // Tema kontrolüne göre stil
                color: color, // Renk belirleme
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Ana Bottom Navigation Bar widget'ı
// Tüm navigation sistemini yönetir (Controller Layer)
class CustomBottomBar extends StatelessWidget {
  // Navigation item'ları: Uygulama boyunca değişmeyeceği için static ve const
  static const List<_BottomNavItem> _items = [
    _BottomNavItem(
      icon: Icons.home_outlined, // Seçili değilken ikon
      activeIcon: Icons.home, // Seçiliyken ikon
      label: 'Ana Sayfa', // Etiket
    ),
    _BottomNavItem(
      icon: Icons.school_outlined,
      activeIcon: Icons.school,
      label: 'Üniversite',
    ),
    _BottomNavItem(
      icon: Icons.map_outlined,
      activeIcon: Icons.map,
      label: 'Kampüs',
    ),
    _BottomNavItem(
      icon: Icons.event_outlined,
      activeIcon: Icons.event,
      label: 'Etkinlikler',
      // badge: '2', // Örnek badge
    ),
  ];

  // Şu an seçili olan item'ın index'i
  final int currentIndex;

  // Item'a tıklandığında çalışacak callback fonksiyonu
  final Function(int) onTap;

  // Constructor: Bottom Bar'ın state bilgilerini alır
  const CustomBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Alt bar tasarımı (tema durumuna göre belirleniyor)
      decoration: AppDecorations.bottomNavBar(context.isDark),
      child: SafeArea(
        // Üst taraftaki safe area'yı devre dışı bırak
        // alt navigasyon çubuğu gibi üst boşluğa ihtiyaç duymayan widget'larda gereksiz boşluk oluşmasını önler
        top: false,
        child: Row(
          // İtemları eşit aralıklarla dağıt
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            _items.length, // İtem sayısı kadar widget oluştur
            (index) => _BottomNavItemWidget(
              item: _items[index], // İlgili item verisi
              isSelected: currentIndex == index, // Seçili durumu kontrol et
              onTap: () => onTap(index), // Tıklama işlemi
            ),
          ),
        ),
      ),
    );
  }
}
