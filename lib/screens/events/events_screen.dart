import 'package:flutter/material.dart';
import 'package:biruni_connect/core/theme/app_colors.dart';
import 'package:biruni_connect/core/theme/app_text_styles.dart';
import 'package:biruni_connect/core/utils/extensions/context_extension.dart';
import 'package:biruni_connect/screens/events/models/event.dart';
import 'package:biruni_connect/screens/events/models/event_type.dart';
import 'package:biruni_connect/screens/events/widgets/event_filter_bar.dart';
import 'package:biruni_connect/screens/events/widgets/event_list_view.dart';
import 'package:biruni_connect/mock/events_mock.dart';

/// Etkinliklerin listelendiği ana ekran widget'ı
/// Arama, filtreleme, yenileme özellikleri ve farklı durumların yönetimini içerir
class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  // Arama metni
  String _searchQuery = '';
  // Seçili etkinlik türü filtresi
  EventType? _selectedType;
  // Filtrelenmiş etkinlik listesi
  List<Event> _filteredEvents = [];
  // İlk yükleme durumu
  bool _isLoading = true;
  // Yenileme durumu
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _loadEvents(); // Widget oluşturulduğunda etkinlikleri yükle
  }

  /// Mock etkinlik verilerini yükler
  /// Gerçek API entegrasyonunda bu metot API çağrısı yapacak
  Future<void> _loadEvents() async {
    try {
      // API simülasyonu için 1 saniye bekle
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return; // Widget dispose edilmiş mi kontrol et

      setState(() {
        _filteredEvents = EventsMock.events; // Mock verileri yükle
        _isLoading = false; // Yükleme durumunu güncelle
        _isRefreshing = false; // Yenileme durumunu güncelle
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
        _isRefreshing = false;
      });

      _showErrorSnackbar(); // Hata durumunda snackbar göster
    }
  }

  /// Hata durumunda kullanıcıya bilgi veren snackbar'ı gösterir
  void _showErrorSnackbar() {
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Etkinlikler yüklenirken bir hata oluştu.',
          style: AppTextStyles.bodyMedium(color: AppColors.surface),
        ),
        backgroundColor: AppColors.error,
      ),
    );
  }

  /// Pull-to-refresh ile tetiklenen yenileme işlemi
  Future<void> _refresh() async {
    setState(() => _isRefreshing = true);
    await _loadEvents();
  }

  /// Arama metni ve seçili filtreye göre etkinlikleri filtreler
  void _filterEvents() {
    setState(() {
      _filteredEvents = EventsMock.events.where((event) {
        // Etkinlik türü filtrelemesi
        if (_selectedType != null && event.eventType != _selectedType) {
          return false;
        }

        // Arama metni filtrelemesi
        if (_searchQuery.isNotEmpty) {
          final query = _searchQuery.toLowerCase();
          // Başlık, açıklama, konum, organizatör ve etiketlerde arama yap
          return event.title.toLowerCase().contains(query) ||
              event.description.toLowerCase().contains(query) ||
              event.location.toLowerCase().contains(query) ||
              event.organizer.toLowerCase().contains(query) ||
              event.tags.any((tag) => tag.toLowerCase().contains(query));
        }

        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refresh,
        color: isDark ? AppColors.secondaryDark : AppColors.secondary,
        child: CustomScrollView(
          slivers: [
            // Üst başlık barı
            SliverAppBar(
              pinned: true, // Scroll yaparken sabit kal
              title: Text(
                'Etkinlikler',
                style: AppTextStyles.h3(isDark: isDark),
              ),
              centerTitle: true,
            ),

            // Arama ve filtreleme barı
            SliverToBoxAdapter(
              child: EventFilterBar(
                onSearch: (query) {
                  _searchQuery = query; // Arama metnini güncelle
                  _filterEvents(); // Filtrelemeyi uygula
                },
                onFilterChange: (type) {
                  _selectedType = type; // Seçili türü güncelle
                  _filterEvents(); // Filtrelemeyi uygula
                },
              ),
            ),

            // Ana etkinlik listesi
            SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: context.paddingS.left,
                vertical: context.paddingS.top,
              ),
              sliver: SliverFillRemaining(
                child: EventListView(
                  events: _filteredEvents,
                  isLoading: _isLoading,
                  isFullScreen: true,
                  emptyMessage: _getEmptyMessage(), // Boş durumu mesajı
                  errorMessage:
                      _isRefreshing ? null : _getErrorMessage(), // Hata mesajı
                  onRefresh: _refresh,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Filtreleme durumuna göre uygun boş liste mesajını döndürür
  /// Arama ve filtre durumlarına göre özelleştirilmiş mesajlar üretir
  String _getEmptyMessage() {
    if (_searchQuery.isNotEmpty && _selectedType != null) {
      return 'Bu arama ve filtre kriterlerine uygun etkinlik bulunamadı.';
    }
    if (_searchQuery.isNotEmpty) {
      return '"$_searchQuery" araması için etkinlik bulunamadı.';
    }
    if (_selectedType != null) {
      return '${_selectedType!.label} tipinde etkinlik bulunamadı.';
    }
    return 'Henüz etkinlik bulunmamaktadır.';
  }

  /// Yükleme durumuna göre hata mesajını döndürür
  /// Yükleme ve yenileme durumlarında null döndürerek mesaj gösterilmesini engeller
  String? _getErrorMessage() {
    if (_isLoading || _isRefreshing) return null;
    if (_filteredEvents.isEmpty && EventsMock.events.isEmpty) {
      return 'Etkinlikler yüklenirken bir hata oluştu.\nLütfen tekrar deneyin.';
    }
    return null;
  }
}
