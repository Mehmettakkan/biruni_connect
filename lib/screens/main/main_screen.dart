import 'package:biruni_connect/config/routes/route_names.dart'; // Rota adlarını içeren sabitler
import 'package:biruni_connect/shared/widgets/custom_bottom_bar.dart'; // Özel Bottom Navigation Bar
import 'package:flutter/material.dart'; // Flutter widgetları için
import 'package:go_router/go_router.dart'; // Yönlendirme paketi

// Ana ekranı temsil eden StatelessWidget
class MainScreen extends StatelessWidget {
  // Çocuk widget (Alt bar'ın üstündeki sayfa içeriği)
  final Widget child;

  // Constructor: Ana ekrana hangi içerik gösterileceğini belirler
  const MainScreen({
    super.key,
    required this.child,
  });

  // Şu anki URL'ye (location) göre seçili sekmenin index'ini döner
  int _getCurrentIndex(String location) {
    switch (location) {
      case RoutePath.home: // Eğer URL RoutePath.home ile eşleşiyorsa
        return 0; // İlk sekme seçili (Ana Sayfa)
      case RoutePath.university: // Üniversite sekmesi URL'si
        return 1; // İkinci sekme
      case RoutePath.campus: // Kampüs sekmesi URL'si
        return 2; // Üçüncü sekme
      case RoutePath.events: // Etkinlikler sekmesi URL'si
        return 3; // Dördüncü sekme
      default: // Hiçbir URL eşleşmezse
        return 0; // Varsayılan olarak ilk sekme
    }
  }

  // Kullanıcı bir sekmeye tıkladığında ne yapılacağını belirler
  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0: // İlk sekme tıklanırsa
        context.go(RoutePath.home); // RoutePath.home URL'sine git
        break;
      case 1: // İkinci sekme tıklanırsa
        context.go(RoutePath.university); // RoutePath.university URL'sine git
        break;
      case 2: // Üçüncü sekme tıklanırsa
        context.go(RoutePath.campus); // RoutePath.campus URL'sine git
        break;
      case 3: // Dördüncü sekme tıklanırsa
        context.go(RoutePath.events); // RoutePath.events URL'sine git
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Mevcut URL'yi al
    final location = GoRouterState.of(context).uri.toString();

    // URL'ye göre hangi sekmenin seçili olduğunu belirle
    final currentIndex = _getCurrentIndex(location);

    return Scaffold(
      // Sayfanın ana içeriği
      body: child, // Geçerli sayfanın widget'ı
      bottomNavigationBar: CustomBottomBar(
        currentIndex: currentIndex, // Şu anki seçili sekme
        onTap: (index) => _onItemTapped(context, index), // Tıklama işlemi
      ),
    );
  }
}
