import 'package:equatable/equatable.dart';

class FeedEntity extends Equatable {
  final String username;
  final String posted;
  final String tag;
  final String timeLeft;
  final String title;
  final int going;
  final int interested;
  final String distance;
  final String category;

  const FeedEntity({
    required this.username,
    required this.posted,
    required this.tag,
    required this.timeLeft,
    required this.title,
    required this.going,
    required this.distance,
    required this.interested,
    required this.category,
  });

  @override
  List<Object?> get props => [
    username,
    posted,
    tag,
    timeLeft,
    title,
    going,
    distance,
    interested,
    category,
  ];
}
