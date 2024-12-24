import 'package:flutter/material.dart';
import 'package:biruni_connect/core/constants/ui/ui_constants.dart';
import 'package:biruni_connect/core/theme/app_colors.dart';
import 'package:biruni_connect/core/theme/app_text_styles.dart';
import 'package:biruni_connect/core/theme/app_decorations.dart';
import 'package:biruni_connect/core/utils/extensions/context_extension.dart';
import 'package:biruni_connect/screens/events/models/event_type.dart';

/// Etkinlik listesi için arama ve filtreleme widget'ı
/// Kullanıcıların etkinlikler içinde arama yapmasını ve türlere göre filtrelemesini sağlar
class EventFilterBar extends StatefulWidget {
  // Arama metni değiştiğinde çağrılacak fonksiyon
  final Function(String) onSearch;
  // Filtre değiştiğinde çağrılacak fonksiyon
  final Function(EventType?) onFilterChange;
  // Arama çubuğunun görünürlüğü
  final bool showSearch;

  const EventFilterBar({
    super.key,
    required this.onSearch,
    required this.onFilterChange,
    this.showSearch = true,
  });

  @override
  State<EventFilterBar> createState() => _EventFilterBarState();
}

class _EventFilterBarState extends State<EventFilterBar> {
  // Seçili etkinlik türü
  EventType? _selectedType;
  // Arama çubuğu için controller
  final TextEditingController _searchController = TextEditingController();
  // Arama çubuğunun focus durumunu takip etmek için
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    // Memory leak'i önlemek için controller ve focus node temizlenir
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Tema durumunu kontrol et
    final isDark = context.isDark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        border: Border(
          bottom: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.border,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Arama çubuğunu koşullu göster
          if (widget.showSearch) _buildSearchBar(isDark),
          _buildFilterChips(isDark),
        ],
      ),
    );
  }

  /// Arama çubuğunu oluşturur
  /// Temaya göre renk ve stil ayarları yapılır
  Widget _buildSearchBar(bool isDark) {
    return Padding(
      padding: EdgeInsets.all(UIConstants.paddingM),
      child: Container(
        decoration: AppDecorations.input(isDark),
        child: TextField(
          controller: _searchController,
          focusNode: _focusNode,
          style: AppTextStyles.bodyLarge(isDark: isDark),
          cursorColor: isDark ? AppColors.secondaryDark : AppColors.secondary,
          decoration: InputDecoration(
            hintText: 'Etkinlik ara...',
            hintStyle: AppTextStyles.bodyMedium(
              isDark: isDark,
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondary,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: _getIconColor(isDark),
              size: UIConstants.iconM,
            ),
            suffixIcon: _buildClearButton(isDark),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              horizontal: UIConstants.paddingM,
              vertical: UIConstants.paddingS,
            ),
          ),
          onChanged: widget.onSearch,
        ),
      ),
    );
  }

  /// Arama metnini temizlemek için kullanılan buton
  /// Metin boşsa null döner ve buton gösterilmez
  Widget? _buildClearButton(bool isDark) {
    if (_searchController.text.isEmpty) return null;

    return IconButton(
      icon: Icon(
        Icons.clear,
        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
        size: UIConstants.iconS,
      ),
      onPressed: () {
        _searchController.clear(); // Metni temizle
        widget.onSearch(''); // Callback'i çağır
      },
    );
  }

  /// Filtre seçeneklerini gösteren yatayda kaydırılabilir chip listesi
  /// Tümü seçeneği ve etkinlik türlerini içerir
  Widget _buildFilterChips(bool isDark) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(
        horizontal: UIConstants.paddingM,
        vertical: UIConstants.paddingS,
      ),
      child: Row(
        children: [
          // Tümü seçeneği için chip
          _buildFilterChip(
            isDark: isDark,
            label: 'Tümü',
            isSelected: _selectedType == null,
            onSelected: (_) {
              setState(() => _selectedType = null);
              widget.onFilterChange(null);
            },
          ),
          // Etkinlik türleri için chip'ler
          ...EventType.values.map(
            (type) => Padding(
              padding: EdgeInsets.only(left: UIConstants.paddingS),
              child: _buildFilterChip(
                isDark: isDark,
                label: type.label,
                isSelected: _selectedType == type,
                onSelected: (selected) {
                  setState(() => _selectedType = selected ? type : null);
                  widget.onFilterChange(selected ? type : null);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Tekil filtre chip'i widget'ı
  /// [isDark]: Tema durumu
  /// [label]: Gösterilecek metin
  /// [isSelected]: Seçili durumu
  /// [onSelected]: Seçim değiştiğinde çağrılacak fonksiyon
  Widget _buildFilterChip({
    required bool isDark,
    required String label,
    required bool isSelected,
    required Function(bool) onSelected,
  }) {
    final color = isDark ? AppColors.secondaryDark : AppColors.secondary;

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: onSelected,
      backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surface,
      selectedColor: color.withOpacity(0.15),
      side: BorderSide(
        color: isSelected
            ? color
            : (isDark ? AppColors.borderDark : AppColors.border),
        width: 1,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: UIConstants.paddingS,
        vertical: UIConstants.paddingXS,
      ),
      labelStyle: AppTextStyles.bodyMedium(
        isDark: isDark,
        color: isSelected
            ? color
            : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimary),
      ),
      showCheckmark: false,
      elevation: 0,
      pressElevation: 0,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  /// Arama ikonu rengini hesaplar
  /// Focus durumuna göre renk döndürür
  Color _getIconColor(bool isDark) {
    if (_focusNode.hasFocus) {
      return isDark ? AppColors.secondaryDark : AppColors.secondary;
    }
    return isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;
  }
}
