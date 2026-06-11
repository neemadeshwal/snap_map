abstract class MapEvent {
  const MapEvent();
}

class LoadFriendsEvent extends MapEvent {}

class ZoomInEvent extends MapEvent {}

class ZoomOutEvent extends MapEvent {}

class CenterOnUserEvent extends MapEvent {}

class PanToLocationEvent extends MapEvent {}

class ToggleFriendHighlightEvent extends MapEvent {
  final String friendId;

  const ToggleFriendHighlightEvent({required this.friendId});
}
