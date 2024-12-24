import 'package:biruni_connect/config/routes/route_names.dart';
import 'package:biruni_connect/core/constants/ui/asset_constants.dart';
import 'package:biruni_connect/core/theme/app_colors.dart';
import 'package:biruni_connect/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;

/// Uygulamanın başlangıç ekranını temsil eden splash screen widget'ı.
/// Animasyonlu logo, yükleme göstergesi ve versiyon bilgisi içerir.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // Logo animasyonu için kullanılan controller
  late AnimationController _controller;
  // Logonun toplam dönüş açısını tutan değişken
  double _totalRotation = 0.0;
  // Animasyonun ileri yönde mi yoksa geri yönde mi olduğunu belirten flag
  bool _isForward = true;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _navigateToHome();
  }

  /// Animasyonları başlatan ve yapılandıran metod.
  /// Logo için özel bir dönüş ve salınım animasyonu oluşturur.
  void _setupAnimations() {
    // 4 saniyelik yavaş bir animasyon için controller oluşturulur
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );

    // Her frame'de çalışacak listener ile logo rotasyonu güncellenir
    _controller.addListener(() {
      setState(() {
        if (_isForward) {
          // İleri yönde: 360 derece dönüş + hafif salınım efekti
          double progress = _controller.value;
          _totalRotation =
              2 * math.pi * progress + 0.1 * math.sin(4 * math.pi * progress);
        } else {
          // Geri yönde: Mevcut pozisyondan geri dönüş + güçlü salınım
          double progress = 1 - _controller.value;
          _totalRotation = 2 * math.pi +
              (progress * 2 * math.pi) +
              0.3 * math.sin(3 * math.pi * progress);
        }
      });
    });

    // Animasyon tamamlandığında veya sıfırlandığında yön değiştirilir
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _isForward = false;
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _isForward = true;
        _controller.forward();
      }
    });

    _controller.forward();
  }

  /// 4 saniye sonra ana sayfaya yönlendirme yapan metod.
  /// Widget hala mount edilmiş durumdaysa yönlendirme gerçekleştirilir.
  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 4));
    if (mounted) {
      context.go(RoutePath.home);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Koyu/açık tema için farklı gradient arka plan
        decoration: BoxDecoration(
          gradient: context.isDark
              ? AppColors.primaryGradientDark
              : AppColors.primaryGradient,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Dönen ve ölçeklenen logo animasyonu
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(milliseconds: 800),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Transform.rotate(
                      angle: _totalRotation,
                      child: Image.asset(
                        AssetConstants.splash,
                        height: 300,
                      ),
                    ),
                  );
                },
              ),
              context.spaceL,

              // Yavaşça beliren dairesel ilerleme göstergesi
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(milliseconds: 1000),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: SizedBox(
                      width: 48,
                      height: 48,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          context.isDark
                              ? AppColors.secondaryDark
                              : AppColors.secondary,
                        ),
                      ),
                    ),
                  );
                },
              ),
              context.spaceL,

              // En son beliren versiyon metni
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(milliseconds: 1200),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Text(
                      'Versiyon 1.0.0',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: AppColors.surface.withOpacity(0.7),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
