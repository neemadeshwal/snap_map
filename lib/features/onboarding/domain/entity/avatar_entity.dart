enum AvatarSourceType { gallery, camera, asset }

class AvatarEntity {
  final String? imagePath;
  final AvatarSourceType? source;
  final bool isEmpty;

  const AvatarEntity({
    required this.imagePath,
    required this.source,
    required this.isEmpty,
  });

  const AvatarEntity.empty() : imagePath = null, source = null, isEmpty = true;

  AvatarEntity copyWith({
    String? imagePath,
    AvatarSourceType? source,
    bool? isEmpty,
  }) {
    return AvatarEntity(
      imagePath: imagePath ?? this.imagePath,
      source: source ?? this.source,
      isEmpty: isEmpty ?? this.isEmpty,
    );
  }
}
