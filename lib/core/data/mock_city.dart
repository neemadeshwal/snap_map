import 'package:flutter/material.dart';
import 'package:snapmap/features/explore/domain/entities/city_entity.dart';

const List<CityEntity> mockCities = [
  CityEntity(
    id: 'c_ind_1',
    cityName: 'Mumbai',
    themeColor: Color(
      0xFF007AFF,
    ), // Marine Blue (representing the Arabian Sea & coastline)
    imageUrl:
        'https://images.unsplash.com/photo-1566552881560-0be862a7c445?w=500',
    activeEvents: [
      'Kala Ghoda Art Fest',
      'Marine Drive Sunset Jam',
      'Bollywood Tech Summit',
    ],
  ),
  CityEntity(
    id: 'c_ind_2',
    cityName: 'Jaipur',
    themeColor: Color(
      0xFFFF6B81,
    ), // Terracotta Pink (The historic Pink City theme)
    imageUrl:
        'https://images.unsplash.com/photo-1477587458883-471a5ed94245?w=500',
    activeEvents: [
      'Jaipur Literature Fest',
      'Palace Heritage Tour',
      'Bazaar Photo Walk',
    ],
  ),
  CityEntity(
    id: 'c_ind_3',
    cityName: 'Bengaluru',
    themeColor: Color(
      0xFF34C759,
    ), // Garden Green (The Garden City & Silicon Valley vibe)
    imageUrl:
        'https://images.unsplash.com/photo-1596176530529-78163a4f7af2?w=500',
    activeEvents: [
      'Cubbon Park Run',
      'Indiranagar Hackathon',
      'Filter Coffee Crawl',
    ],
  ),
  CityEntity(
    id: 'c_ind_4',
    cityName: 'Delhi',
    themeColor: Color(
      0xFFFF9500,
    ), // Saffron Spice (representing rich culinary & heritage spots)
    imageUrl:
        'https://images.unsplash.com/photo-1587474260584-136574528ed5?w=500',
    activeEvents: [
      'Delhi Food Carnival',
      'Red Fort Light Show',
      'Noida Auto Expo',
    ],
  ),
  CityEntity(
    id: 'c_ind_5',
    cityName: 'Kolkata',
    themeColor: Color(
      0xFFAF52DE,
    ), // Royal Violet (representing art, literature, and culture)
    imageUrl: 'https://images.unsplash.com/photo-1558431382-27e303142255?w=500',
    activeEvents: [
      'Durga Puja Preview',
      'College Street Book Fair',
      'Tram Photography Meet',
    ],
  ),
];
