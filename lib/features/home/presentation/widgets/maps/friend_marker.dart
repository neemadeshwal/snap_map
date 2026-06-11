import 'package:flutter/material.dart';
import 'package:snapmap/core/constants/map_constants.dart';
import 'package:snapmap/features/home/domain/entities/friend_entity.dart';
import 'package:snapmap/generated/app_localizations.dart'; // <-- Added import

class FriendMarker extends StatefulWidget {
  final Friend friend;
  final AppLocalizations localizations; // <-- Added localizations parameter
  final ValueChanged<Size>? onSizeChanged;

  const FriendMarker({
    super.key,
    required this.friend,
    required this.localizations, // <-- Required in constructor
    this.onSizeChanged,
  });

  @override
  State<FriendMarker> createState() => _FriendMarkerState();
}

class _FriendMarkerState extends State<FriendMarker>
    with SingleTickerProviderStateMixin {
  bool _showDetail = false;
  late AnimationController _animationController;
  late Animation<double> _widthAnimation;
  final GlobalKey _containerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _widthAnimation = Tween<double>(begin: 0, end: 120).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.addListener(_updateSize);
  }

  void _updateSize() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox? renderBox =
          _containerKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null && renderBox.hasSize) {
        widget.onSizeChanged?.call(renderBox.size);
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleDetail() {
    if (_showDetail) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
    setState(() {
      _showDetail = !_showDetail;
    });
  }

  @override
  Widget build(BuildContext context) {
    final showBadge =
        widget.friend.isHighlighted &&
        widget.friend.badgeColor != Colors.transparent;
    final baseSize = showBadge
        ? 40.0
        : MapConstants.friendMarkerAvatarSize + 20;
    final borderThickness = showBadge ? 3.0 : 0.0;

    return GestureDetector(
      onTap: _toggleDetail,
      child: AnimatedBuilder(
        animation: _widthAnimation,
        builder: (context, child) {
          return Container(
            key: _containerKey,
            width: baseSize + _widthAnimation.value + (borderThickness * 2),
            height: baseSize + (borderThickness * 2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.lerp(
                BorderRadius.circular((baseSize + borderThickness * 2) / 2),
                BorderRadius.circular(16),
                _animationController.value,
              ),
              border: showBadge
                  ? Border.all(
                      color: widget.friend.badgeColor,
                      width: borderThickness,
                    )
                  : null,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: baseSize,
                  height: baseSize,
                  child: Center(
                    child: Text(
                      widget.friend.emoji,
                      style: TextStyle(fontSize: showBadge ? 24 : 20),
                    ),
                  ),
                ),
                Opacity(
                  opacity: _animationController.value,
                  child: ClipRect(
                    child: SizedBox(
                      width: _widthAnimation.value,
                      height: baseSize,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 6, right: 12),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget
                                .friend
                                .name, // Displaying structural entity name
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
