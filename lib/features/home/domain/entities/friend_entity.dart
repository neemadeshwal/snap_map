import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

class Friend extends Equatable {
  final String id;
  final String name;
  final String emoji;
  final LatLng location;
  final Color badgeColor;
  final bool isHighlighted;

  const Friend({
    required this.id,
    required this.name,
    required this.emoji,
    required this.location,
    required this.badgeColor,
    this.isHighlighted = false,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    emoji,
    location,
    badgeColor,
    isHighlighted,
  ];

  Friend copyWith({
    String? id,
    String? name,
    String? emoji,
    LatLng? location,
    Color? badgeColor,
    bool? isHighlighted,
  }) {
    return Friend(
      id: id ?? this.id,
      name: name ?? this.name,
      emoji: emoji ?? this.emoji,
      location: location ?? this.location,
      badgeColor: badgeColor ?? this.badgeColor,
      isHighlighted: isHighlighted ?? this.isHighlighted,
    );
  }
}
