class PersonEntity {
  final String id;
  final String name;
  final String username;
  final List<String> interests;
  final String avatarUrl;

  const PersonEntity({
    required this.id,
    required this.name,
    required this.username,
    required this.interests,
    required this.avatarUrl,
  });
}
