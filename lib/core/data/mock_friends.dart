import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:snapmap/features/home/domain/entities/friend_entity.dart';

// Locations are within ~2 km of MapConstants.defaultUserLocation (MG Road, Bangalore).
final List<Friend> mockFriends = [
  Friend(
    id: '1',
    name: 'Raj',
    emoji: '🎵',
    location: const LatLng(12.9791, 77.5937), // ~0.8 km N
    badgeColor: Colors.transparent,
  ),
  Friend(
    id: '2',
    name: 'Aryan',
    emoji: '😋',
    location: const LatLng(12.9665, 77.6029), // ~1.1 km SE
    badgeColor: Colors.transparent,
  ),
  Friend(
    id: '3',
    name: 'Priya',
    emoji: '🔥',
    location: const LatLng(12.9719, 77.6029), // ~1.0 km E
    badgeColor: Colors.red,
    isHighlighted: true,
  ),
  Friend(
    id: '4',
    name: 'Meera',
    emoji: '🍱',
    location: const LatLng(12.9719, 77.5845), // ~1.0 km W
    badgeColor: Colors.orange,
    isHighlighted: true,
  ),
];
