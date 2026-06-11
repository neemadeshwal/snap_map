// interest_model.dart

import 'package:equatable/equatable.dart';

class InterestModel extends Equatable {
  final String id; // stored in Firestore — never changes
  final String label; // shown in UI — can change anytime
  final String emoji; // visual only

  const InterestModel({
    required this.id,
    required this.label,
    required this.emoji,
  });

  @override
  List<Object?> get props => [id, label, emoji];
}
