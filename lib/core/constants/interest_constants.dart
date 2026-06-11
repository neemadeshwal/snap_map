// interest_constants.dart

import 'package:snapmap/features/onboarding/data/model/interests_model.dart';

class InterestConstants {
  // private constructor — nobody should instantiate this
  InterestConstants._();

  static const List<InterestModel> all = [
    InterestModel(id: 'music', label: 'Music', emoji: '🎸'),
    InterestModel(id: 'books', label: 'Books', emoji: '📚'),
    InterestModel(id: 'food', label: 'Food', emoji: '🍕'),
    InterestModel(id: 'sports', label: 'Sports', emoji: '⚽'),
    InterestModel(id: 'art', label: 'Art', emoji: '🎨'),
    InterestModel(id: 'travel', label: 'Travel', emoji: '✈️'),
    InterestModel(id: 'gaming', label: 'Gaming', emoji: '🎮'),
    InterestModel(id: 'fitness', label: 'Fitness', emoji: '💪'),
    InterestModel(id: 'film', label: 'Film', emoji: '🎬'),
    InterestModel(id: 'tech', label: 'Tech', emoji: '💻'),
    InterestModel(id: 'photography', label: 'Photography', emoji: '📷'),
    InterestModel(id: 'dance', label: 'Dance', emoji: '🕺'),
  ];
}
