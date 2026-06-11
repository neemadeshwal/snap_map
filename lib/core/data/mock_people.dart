import 'package:snapmap/features/explore/domain/entities/person_entity.dart';

const List<PersonEntity> mockPeople = [
  PersonEntity(
    id: '1',
    name: 'Alex Rivera',
    username: 'alex_rivera',
    interests: ['Flutter', 'Mobile Dev', 'Hiking'],
    avatarUrl: 'https://i.pravatar.cc/150?img=11',
  ),
  PersonEntity(
    id: '2',
    name: 'Sam Chen',
    username: 'sam_chen_design',
    interests: ['UI/UX', 'Figma', 'Photography', 'Anime'],
    avatarUrl: 'https://i.pravatar.cc/150?img=12',
  ),
  PersonEntity(
    id: '3',
    name: 'Emma Watson',
    username: 'emma_w',
    interests: ['Product Strategy', 'Agile', 'Coffee'],
    avatarUrl: 'https://i.pravatar.cc/150?img=5',
  ),
  PersonEntity(
    id: '4',
    name: 'Marcus Vance',
    username: 'marcus_v',
    interests: ['Automation', 'Cybersecurity', 'Gaming'],
    avatarUrl: 'https://i.pravatar.cc/150?img=8',
  ),
];
