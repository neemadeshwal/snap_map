import 'dart:ui';

import 'package:latlong2/latlong.dart';
import 'package:snapmap/features/home/domain/entities/friend_entity.dart';

class FriendModel extends Friend {
  const FriendModel({
    required super.id,
    required super.name,
    required super.badgeColor,
    required super.emoji,
    required super.location,
    required super.isHighlighted,
  });

  // convert json to friend model

  factory FriendModel.fromJson(Map<String, dynamic> json) {
    return FriendModel(
      id: json['id'],
      name: json['name'],
      badgeColor: Color(json['badgeColor'] as int? ?? 0xFF000000),
      emoji: json['emoji'],
      location: LatLng(json['latitude'] as double, json['longitude'] as double),
      isHighlighted: json['isHighlighted'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'badgeColor': badgeColor,
      'emoji': emoji,
      'latitude': location.latitude,
      'longitude': location.longitude,
      'isHighlighted': isHighlighted,
    };
  }

  Friend toEntity() {
    return Friend(
      id: id,
      name: name,
      badgeColor: badgeColor,
      emoji: emoji,
      location: location,
      isHighlighted: isHighlighted,
    );
  }
}
