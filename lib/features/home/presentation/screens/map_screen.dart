// lib/presentation/pages/map_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:snapmap/core/constants/map_constants.dart';
import 'package:snapmap/core/theme/app_colors.dart';
import 'package:snapmap/features/home/presentation/bloc/map/map_bloc.dart';
import 'package:snapmap/features/home/presentation/bloc/map/map_event.dart';
import 'package:snapmap/features/home/presentation/bloc/map/map_state.dart';
import 'package:snapmap/features/home/domain/entities/friend_entity.dart';
import 'package:snapmap/features/home/presentation/widgets/maps/friend_marker.dart';
import 'package:snapmap/features/home/presentation/widgets/maps/map_controls_panel.dart';
import 'package:snapmap/generated/app_localizations.dart'; // <-- Added import

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MapBloc>().add(LoadFriendsEvent());
    });
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(
      context,
    )!; // <-- Grab localized instance

    return BlocListener<MapBloc, MapState>(
      listenWhen: (previous, current) {
        if (current is MapErrorState) return true;
        if (current is! MapLoadedState) return false;
        if (previous is! MapLoadedState) return true;
        return previous.currentZoom != current.currentZoom ||
            previous.userLocation != current.userLocation;
      },
      listener: (context, state) {
        if (state is MapErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              // If your API provides hardcoded strings, state.message works,
              // but if you have localized error templates, use localizations here.
              content: Text(state.message),
            ),
          );
          return;
        }
        if (state is MapLoadedState) {
          mapController.move(state.userLocation, state.currentZoom);
        }
      },
      child: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          return Stack(
            children: [
              // Map
              _buildMap(
                context,
                state,
                localizations,
              ), // <-- Passed down to map layer builder
              // Radius Label (Example if uncommented later)
              // Positioned(
              //   bottom: 100,
              //   left: 16,
              //   child: BlocBuilder<MapBloc, MapState>(
              //     builder: (context, state) {
              //       if (state is MapLoadedState) {
              //         return RadiusCircleLabel(
              //           radiusKm: state.radiusKm,
              //           localizations: localizations, // <-- Add this if label needs "km away"
              //         );
              //       }
              //       return const SizedBox.shrink();
              //     },
              //   ),
              // ),

              // Map Controls
              Positioned(
                right: 16,
                top: 100,
                child: MapControlsPanel(
                  onZoomIn: () => context.read<MapBloc>().add(ZoomInEvent()),
                  onZoomOut: () => context.read<MapBloc>().add(ZoomOutEvent()),
                  onCenterOnUser: () =>
                      context.read<MapBloc>().add(CenterOnUserEvent()),
                ),
              ),

              // Loading indicator
              if (state is MapLoadingState)
                const Center(child: CircularProgressIndicator()),
            ],
          );
        },
      ),
    );
  }

  /// Build FlutterMap with layers
  Widget _buildMap(
    BuildContext context,
    MapState state,
    AppLocalizations localizations,
  ) {
    final userLocation = state is MapLoadedState
        ? state.userLocation
        : MapConstants.defaultUserLocation;
    final radiusKm = state is MapLoadedState
        ? state.radiusKm
        : MapConstants.defaultRadius;
    final friends = state is MapLoadedState ? state.friends : const <Friend>[];
    const markerWidth = 180.0;
    const markerHeight = 48.0;

    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: userLocation,
        initialZoom: MapConstants.defaultZoom,
        maxZoom: MapConstants.maxZoom,
        minZoom: MapConstants.minZoom,
      ),
      children: [
        TileLayer(
          urlTemplate: MapConstants.tileLayerUrl,
          userAgentPackageName: 'com.example.snapmap',
          subdomains: const ['a', 'b', 'c'],
          maxZoom: 19,
        ),
        CircleLayer(
          circles: [
            CircleMarker(
              point: userLocation,
              color: AppColors.primary.withOpacity(
                MapConstants.radiusCircleOpacity,
              ),
              borderColor: AppColors.primary.withValues(
                alpha: MapConstants.radiusBorderOpacity,
              ),
              borderStrokeWidth: MapConstants.radiusBorderStrokeWidth,
              radius: radiusKm * 1000,
              useRadiusInMeter: true,
            ),
          ],
        ),
        MarkerLayer(
          markers: [
            ...friends.map((friend) {
              final showBadge =
                  friend.isHighlighted &&
                  friend.badgeColor != Colors.transparent;
              final baseSize = showBadge
                  ? 40.0
                  : MapConstants.friendMarkerAvatarSize;
              final borderThickness = showBadge ? 4.0 : 0.0;
              final emojiCenter = borderThickness + (baseSize / 2);
              final alignmentX = (2 * emojiCenter / markerWidth) - 1.0;

              return Marker(
                point: friend.location,
                width: markerWidth,
                height: markerHeight,
                alignment: Alignment(alignmentX, 0.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FriendMarker(
                    friend: friend,
                    localizations:
                        localizations, // <-- Pass down to custom friend pinpoint UI
                  ),
                ),
              );
            }),
            Marker(
              point: userLocation,
              width: MapConstants.userMarkerRadius * 2,
              height: MapConstants.userMarkerRadius * 2,
              child: Container(
                width: MapConstants.userMarkerRadius * 2,
                height: MapConstants.userMarkerRadius * 2,
                decoration: BoxDecoration(
                  color: Colors.teal[800],
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal.withOpacity(0.4),
                      blurRadius: MapConstants.userMarkerShadowBlur,
                      spreadRadius: MapConstants.userMarkerShadowSpread,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
