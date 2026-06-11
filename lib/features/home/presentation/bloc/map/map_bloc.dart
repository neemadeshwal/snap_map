import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snapmap/core/constants/map_constants.dart';
import 'package:snapmap/core/data/mock_friends.dart';
import 'package:snapmap/core/utils/map_utils.dart';
import 'package:snapmap/features/home/presentation/bloc/map/map_event.dart';
import 'package:snapmap/features/home/presentation/bloc/map/map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapInitialState()) {
    on<LoadFriendsEvent>(_onLoadFriends);
    on<ZoomInEvent>(_onZoomIn);
    on<ZoomOutEvent>(_onZoomOut);
    on<CenterOnUserEvent>(_onCenterOnUser);
    // on<PanToLocationEvent>(_onPanToLocation);
    // on<ToggleFriendHighlightEvent>(_onToggleFriendHighlight);
  }

  Future<void> _onLoadFriends(
    LoadFriendsEvent event,
    Emitter<MapState> emit,
  ) async {
    emit(MapLoadingState());

    final userLocation = MapConstants.defaultUserLocation;
    final friends = MapUtils.friendsWithinRadius(
      friends: mockFriends,
      userLocation: userLocation,
      radiusKm: MapConstants.defaultRadius,
    );

    emit(
      MapLoadedState(
        friends: friends,
        userLocation: userLocation,
        currentZoom: MapConstants.defaultZoom,
        radiusKm: MapConstants.defaultRadius,
      ),
    );
  }

  Future<void> _onZoomIn(ZoomInEvent event, Emitter<MapState> emit) async {
    if (state is MapLoadedState) {
      final currentState = state as MapLoadedState;

      final newZoom = (currentState.currentZoom + MapConstants.zoomIncrement)
          .clamp(MapConstants.minZoom, MapConstants.maxZoom);

      emit(currentState.copyWith(currentZoom: newZoom));
    }
  }

  Future<void> _onZoomOut(ZoomOutEvent event, Emitter<MapState> emit) async {
    if (state is MapLoadedState) {
      final currentState = state as MapLoadedState;

      final newZoom = (currentState.currentZoom - MapConstants.zoomIncrement)
          .clamp(MapConstants.minZoom, MapConstants.maxZoom);

      emit(currentState.copyWith(currentZoom: newZoom));
    }
  }

  Future<void> _onCenterOnUser(
    CenterOnUserEvent event,
    Emitter<MapState> emit,
  ) async {
    if (state is MapLoadedState) {
      final currentState = state as MapLoadedState;
      emit(
        currentState.copyWith(
          userLocation: MapConstants.defaultUserLocation,
          currentZoom: MapConstants.defaultZoom,
        ),
      );
    }
  }
}
