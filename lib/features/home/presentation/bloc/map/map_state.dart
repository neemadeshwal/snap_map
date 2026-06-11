import 'package:latlong2/latlong.dart';
import 'package:snapmap/features/home/domain/entities/friend_entity.dart';

abstract class MapState {
  const MapState();
}

class MapInitialState extends MapState {}

class MapLoadingState extends MapState {}

class MapLoadedState extends MapState {
  final LatLng userLocation;
  final double currentZoom;
  final double radiusKm;
  final List<Friend> friends;

  const MapLoadedState({
    required this.currentZoom,
    required this.radiusKm,
    required this.friends,
    required this.userLocation,
  });
  MapLoadedState copyWith({
    List<Friend>? friends,
    LatLng? userLocation,
    double? currentZoom,
    double? radiusKm,
  }) {
    return MapLoadedState(
      friends: friends ?? this.friends,
      userLocation: userLocation ?? this.userLocation,
      currentZoom: currentZoom ?? this.currentZoom,
      radiusKm: radiusKm ?? this.radiusKm,
    );
  }
}

class MapErrorState extends MapState {
  final String message;

  const MapErrorState({required this.message});
}
