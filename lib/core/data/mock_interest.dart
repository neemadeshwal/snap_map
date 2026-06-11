import 'package:flutter/material.dart';
import 'package:snapmap/features/explore/domain/entities/interest_enitity.dart';

final List<Interest> mockInterest = [
  Interest(
    id: '1',
    name: "music",
    moments: 123,
    emoji: "🎵",
    color: const Color.fromARGB(255, 151, 201, 242),
  ),
  Interest(
    id: '2',
    name: "gaming",
    moments: 456,
    emoji: "🎮",
    color: const Color.fromARGB(255, 187, 151, 242),
  ),
  Interest(
    id: '3',
    name: "travel",
    moments: 89,
    emoji: "✈️",
    color: const Color.fromARGB(255, 151, 242, 201),
  ),
  Interest(
    id: '4',
    name: "cooking",
    moments: 231,
    emoji: "🍳",
    color: const Color.fromARGB(255, 242, 197, 151),
  ),
  Interest(
    id: '5',
    name: "fitness",
    moments: 512,
    emoji: "💪",
    color: const Color.fromARGB(255, 242, 151, 151),
  ),
  Interest(
    id: '6',
    name: "photography",
    moments: 74,
    emoji: "📷",
    color: const Color.fromARGB(255, 200, 200, 200),
  ),
  Interest(
    id: '7',
    name: "art",
    moments: 165,
    emoji: "🎨",
    color: const Color.fromARGB(255, 242, 151, 218),
  ),
  Interest(
    id: '8',
    name: "movies",
    moments: 310,
    emoji: "🍿",
    color: const Color.fromARGB(255, 242, 235, 151),
  ),
  Interest(
    id: '9',
    name: "reading",
    moments: 95,
    emoji: "📚",
    color: const Color.fromARGB(255, 166, 242, 151),
  ),
  Interest(
    id: '10',
    name: "coding",
    moments: 1024,
    emoji: "💻",
    color: const Color.fromARGB(255, 151, 237, 242),
  ),
];
