// lib/core/constants/map_constants.dart

import 'package:latlong2/latlong.dart';

class MapConstants {
  // Default Location (San Francisco)
  static const LatLng defaultUserLocation = LatLng(12.9719, 77.5937);

  // Map Settings
  static const double defaultZoom = 14.0;
  static const double maxZoom = 18.0;
  static const double minZoom = 5.0;
  static const double defaultRadius = 2.0; // in kilometers

  // Tile Layer URL (OpenStreetMap)
  static const String tileLayerUrl =
      'https://tile.openstreetmap.de/{z}/{x}/{y}.png';
  // static const String tileLayerUrl =
  //     'https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}';
  static const String userAgent = 'com.example.snapmap';

  // Animation
  static const String mapControlAnimationCurve = 'elasticOut';

  // Friend Marker Styles
  static const double friendMarkerAvatarSize = 32.0;
  static const double friendMarkerBorderWidth = 3.0;
  static const double friendMarkerPadding = 12.0;
  static const double friendMarkerBorderRadius = 20.0;

  // Radius Circle
  static const double radiusCircleOpacity = 0.1;
  static const double radiusBorderOpacity = 0.3;
  static const double radiusBorderStrokeWidth = 2.0;

  // User Location Marker
  static const double userMarkerRadius = 8.0;
  static const double userMarkerShadowBlur = 6.0;
  static const double userMarkerShadowSpread = 2.0;

  // Map Control Button
  static const double mapControlButtonSize = 44.0;
  static const double mapControlButtonShadowBlur = 4.0;

  // Zoom Level Changes
  static const double zoomIncrement = 1.0;
}
