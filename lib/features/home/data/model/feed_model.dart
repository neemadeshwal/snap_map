import 'package:snapmap/features/home/domain/entities/feed_entity.dart';

class FeedModel extends FeedEntity {
  const FeedModel({
    required super.username,
    required super.posted,
    required super.tag,
    required super.distance,
    required super.going,
    required super.interested,
    required super.timeLeft,
    required super.title,
    required super.category,
  });

  factory FeedModel.fromJson(Map<String, dynamic> json) {
    return FeedModel(
      username: json['username'],
      posted: json['posted'],
      tag: json['tag'],
      timeLeft: json['timeLeft'],
      title: json['title'],
      going: json['going'],
      interested: json['interested'],
      distance: json['distance'],
      category: json['category'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'posted': posted,
      'tag': tag,
      'timeLeft': timeLeft,
      'title': title,
      'going': going,
      'interested': interested,
      'distance': distance,
      'category': category,
    };
  }

  FeedEntity toEntity() {
    return FeedEntity(
      username: username,
      posted: posted,
      tag: tag,
      timeLeft: timeLeft,
      title: title,
      going: going,
      distance: distance,
      interested: interested,
      category: category,
    );
  }
}
