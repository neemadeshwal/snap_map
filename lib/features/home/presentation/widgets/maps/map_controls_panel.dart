import 'package:flutter/material.dart';
import 'package:snapmap/features/home/presentation/widgets/maps/map_controls.dart';

class MapControlsPanel extends StatelessWidget {
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;
  final VoidCallback onCenterOnUser;

  const MapControlsPanel({
    super.key,
    required this.onZoomIn,
    required this.onZoomOut,
    required this.onCenterOnUser,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MapControls(onPressed: onZoomIn, tooltip: 'Zoom in', icon: Icons.add),
        SizedBox(height: 8),
        MapControls(
          onPressed: onZoomOut,
          tooltip: 'Zoom out',
          icon: Icons.remove,
        ),
        SizedBox(height: 8),

        MapControls(
          onPressed: onCenterOnUser,
          tooltip: 'Center on location ',
          icon: Icons.gps_fixed,
        ),
      ],
    );
  }
}
