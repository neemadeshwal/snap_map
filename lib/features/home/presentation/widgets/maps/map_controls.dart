import 'package:flutter/material.dart';
import 'package:snapmap/core/constants/map_constants.dart';

class MapControls extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String? tooltip;
  final Color? backgroundColor;
  final Color? iconColor;

  const MapControls({
    super.key,
    required this.onPressed,
    this.tooltip,
    this.backgroundColor,
    required this.icon,
    this.iconColor,
  });

  @override
  State<MapControls> createState() => _MapControls();
}

class _MapControls extends State<MapControls> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
          widget.onPressed();
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: Tooltip(
        message: widget.tooltip ?? '',
        child: Container(
          width: MapConstants.mapControlButtonSize,
          height: MapConstants.mapControlButtonSize,
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(_isPressed ? 0.2 : 0.12),
                blurRadius: _isPressed
                    ? 8
                    : MapConstants.mapControlButtonShadowBlur,
                offset: Offset(0, _isPressed ? 3 : 1),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              widget.icon,
              color: widget.iconColor ?? Colors.grey[700],
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
