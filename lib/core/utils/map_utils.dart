import 'package:latlong2/latlong.dart';
import 'package:snapmap/features/home/domain/entities/friend_entity.dart';

class MapUtils {
  MapUtils._();

  static const Distance _distance = Distance();

  static List<Friend> friendsWithinRadius({
    required List<Friend> friends,
    required LatLng userLocation,
    required double radiusKm,
  }) {
    return friends.where((friend) {
      final km = _distance.as(
        LengthUnit.Kilometer,
        userLocation,
        friend.location,
      );
      return km <= radiusKm;
    }).toList();
  }
}
