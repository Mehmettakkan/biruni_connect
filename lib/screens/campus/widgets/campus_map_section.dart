// Gerekli paketlerin ve dosyaların import edilmesi
import 'package:biruni_connect/core/theme/app_colors.dart';
import 'package:biruni_connect/core/theme/app_text_styles.dart';
import 'package:biruni_connect/core/utils/extensions/context_extension.dart';
import 'package:biruni_connect/screens/campus/models/campus_building.dart';
import 'package:biruni_connect/shared/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

/// Kampüs haritasını ve bina işaretleyicilerini gösteren widget.
/// Haritada binaları gösterir, kullanıcının konumunu alır ve bina seçimine izin verir.
class CampusMapSection extends StatefulWidget {
  // Widget için gerekli parametreler
  final List<CampusBuilding> buildings; // Bina listesi
  final Function(CampusBuilding)
      onBuildingSelected; // Bina seçildiğinde çalışacak fonksiyon
  final bool isFullScreen; // Tam ekran modunda gösterilip gösterilmeyeceği

  const CampusMapSection({
    Key? key,
    required this.buildings,
    required this.onBuildingSelected,
    this.isFullScreen = false,
  }) : super(key: key);

  @override
  State<CampusMapSection> createState() => _CampusMapSectionState();
}

class _CampusMapSectionState extends State<CampusMapSection> {
  // Harita kontrolcüsü ve durum değişkenleri
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  CampusBuilding? _selectedBuilding;
  bool _isLoading = true;
  bool _hasLocationPermission = false;

  // Sabit değerler
  static const LatLng _campusCenter =
      LatLng(41.055314, 28.809657); // Kampüs merkezi koordinatları
  static const double _defaultZoom = 10.0; // Varsayılan zoom seviyesi

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  // Harita başlatma işlemleri
  Future<void> _initializeMap() async {
    try {
      setState(() => _isLoading = true);
      await _checkLocationPermission();
      await _createMarkers();
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // Konum izni kontrolü
  Future<void> _checkLocationPermission() async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      final requestedPermission = await Geolocator.requestPermission();
      setState(() => _hasLocationPermission =
          requestedPermission != LocationPermission.denied);
    } else {
      setState(() => _hasLocationPermission = true);
    }
  }

  // İşaretleyicileri oluşturma
  Future<void> _createMarkers() async {
    _markers = widget.buildings.map((building) {
      final markerConfig = _getMarkerConfiguration(building);
      return Marker(
        markerId: MarkerId(building.id),
        position: LatLng(building.latitude, building.longitude),
        onTap: () => _handleMarkerTap(building),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(
          title: '${markerConfig.prefix}${building.name}',
          snippet: building.buildingCode,
        ),
      );
    }).toSet();
    setState(() {});
  }

  // İşaretleyici konfigürasyonu alma
  MarkerConfiguration _getMarkerConfiguration(CampusBuilding building) {
    final name = building.name.toLowerCase();
    if (name.contains('hastane')) {
      return const MarkerConfiguration('🏥 ');
    }
    if (name.contains('fakülte')) {
      return const MarkerConfiguration('🎓 ');
    }
    if (name.contains('yurt')) {
      return const MarkerConfiguration('🏠 ');
    }
    if (name.contains('spor')) {
      return const MarkerConfiguration('⚽ ');
    }
    if (name.contains('kütüphane')) {
      return const MarkerConfiguration('📚 ');
    }
    if (name.contains('kafeterya') || name.contains('yemekhane')) {
      return const MarkerConfiguration('🍽️ ');
    }
    return const MarkerConfiguration('🏢 ');
  }

  // İşaretleyiciye tıklandığında
  void _handleMarkerTap(CampusBuilding building) {
    setState(() => _selectedBuilding = building);
    widget.onBuildingSelected(building);

    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(building.latitude, building.longitude),
        18,
      ),
    );
  }

  // Kullanıcı konumuna gitme
  Future<void> _goToUserLocation() async {
    if (!_hasLocationPermission) {
      context.showSnackBar('Konum izni gerekli', isError: true);
      return;
    }

    try {
      final position = await Geolocator.getCurrentPosition();
      await _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(position.latitude, position.longitude),
          18,
        ),
      );
    } catch (e) {
      context.showSnackBar('Konumunuz alınamadı', isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      type: CustomCardType.elevated,
      padding: EdgeInsets.zero,
      height: widget.isFullScreen ? null : context.heightPercent40,
      child: Stack(
        children: [
          // Ana harita widgetı
          ClipRRect(
            borderRadius: context.radiusXL,
            child: _buildMap(),
          ),
          // Kontrol butonları
          _buildControls(),
          // Yükleniyor göstergesi
          if (_isLoading) _buildLoadingIndicator(),
          // Seçili bina bilgisi
          if (_selectedBuilding != null) _buildBuildingInfo(),
        ],
      ),
    );
  }

  // Harita widgetını oluşturma
  Widget _buildMap() {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: _campusCenter,
        zoom: _defaultZoom,
      ),
      markers: _markers,
      myLocationEnabled: _hasLocationPermission,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      onMapCreated: (controller) => _mapController = controller,
    );
  }

  // Kontrol butonlarını oluşturma
  Widget _buildControls() {
    return Positioned(
      right: context.paddingM.right,
      bottom: context.paddingM.bottom,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Konum butonu
          if (_hasLocationPermission)
            FloatingActionButton.small(
              heroTag: 'location',
              backgroundColor:
                  context.isDark ? AppColors.surfaceDark : AppColors.surface,
              onPressed: _goToUserLocation,
              child: Icon(
                Icons.my_location,
                color: context.isDark
                    ? AppColors.secondaryDark
                    : AppColors.secondary,
              ),
            ),
          context.spaceS,
          // Merkeze dön butonu
          FloatingActionButton.small(
            heroTag: 'center',
            backgroundColor:
                context.isDark ? AppColors.surfaceDark : AppColors.surface,
            onPressed: () => _mapController?.animateCamera(
              CameraUpdate.newLatLngZoom(_campusCenter, _defaultZoom),
            ),
            child: Icon(
              Icons.center_focus_strong,
              color: context.isDark
                  ? AppColors.secondaryDark
                  : AppColors.secondary,
            ),
          ),
        ],
      ),
    );
  }

  // Yükleniyor göstergesini oluşturma
  Widget _buildLoadingIndicator() {
    return Container(
      color: context.isDark
          ? AppColors.backgroundDark.withOpacity(0.7)
          : AppColors.background.withOpacity(0.7),
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  // Seçili bina bilgisini oluşturma
  Widget _buildBuildingInfo() {
    return Positioned(
      left: context.paddingM.left,
      right: context.paddingM.right,
      bottom: context.paddingM.bottom,
      child: CustomCard(
        type: CustomCardType.info,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                // Bina kodu
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: context.isDark
                        ? AppColors.primaryDark
                        : AppColors.primary,
                    borderRadius: context.radiusM,
                  ),
                  child: Text(
                    'Bina ${_selectedBuilding!.buildingCode}',
                    style: AppTextStyles.bodySmall(color: AppColors.surface),
                  ),
                ),
                context.horizontalSpaceM,
                // Bina adı
                Expanded(
                  child: Text(
                    _selectedBuilding!.name,
                    style: AppTextStyles.h4(isDark: context.isDark),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // Kapat butonu
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => setState(() => _selectedBuilding = null),
                ),
              ],
            ),
            // Bölümler listesi
            if (_selectedBuilding!.departments.isNotEmpty) ...[
              context.spaceS,
              Text(
                _selectedBuilding!.departments.join(', '),
                style: AppTextStyles.bodyMedium(isDark: context.isDark),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// İşaretleyici konfigürasyonu için yardımcı sınıf
class MarkerConfiguration {
  final String prefix;

  const MarkerConfiguration(this.prefix);
}
