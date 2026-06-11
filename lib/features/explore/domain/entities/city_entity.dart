// city_entity.dart
import 'package:flutter/material.dart';

class CityEntity {
  final String id;
  final String cityName;
  final List<String> activeEvents;
  final Color themeColor; // Custom color unique to each city context
  final String imageUrl;

  const CityEntity({
    required this.id,
    required this.cityName,
    required this.activeEvents,
    required this.themeColor,
    required this.imageUrl,
  });
}
