import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snapmap/features/onboarding/presentation/bloc/user_setup_bloc.dart';
import 'package:snapmap/features/onboarding/presentation/bloc/user_setup_event.dart';
import 'package:snapmap/features/onboarding/presentation/bloc/user_setup_state.dart';

class AvatarPicker extends StatelessWidget {
  final double size;
  final Color accentColor;

  const AvatarPicker({
    super.key,
    required this.size,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserSetupBloc, UserSetupState>(
      listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage,
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      buildWhen: (prev, curr) =>
          prev.avatar != curr.avatar ||
          prev.isAvatarLoading != curr.isAvatarLoading,
      builder: (context, state) {
        final isLoading = state.isAvatarLoading;
        final hasAvatar = state.hasAvatar;
        return GestureDetector(
          onTap: () => isLoading ? null : _showSourceSheet(context, hasAvatar),
          child: SizedBox(
            width: size,
            height: size,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: accentColor.withValues(alpha: 0.12),
                    border: hasAvatar
                        ? null
                        : Border.all(color: accentColor, width: 2),
                  ),
                  child: ClipOval(child: _buildContent(state)),
                ),
                if (isLoading)
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withValues(alpha: 0.35),
                      ),
                      child: const Center(
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: _Badge(hasAvatar: hasAvatar, accentColor: accentColor),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent(UserSetupState state) {
    if (state.hasAvatar && state.avatar?.imagePath != null) {
      return Image.file(
        File(state.avatar!.imagePath!),
        fit: BoxFit.cover,
        width: size,
        height: size,
        errorBuilder: (_, _, _) => _placeholder(),
      );
    }
    return _placeholder();
  }

  Widget _placeholder() => Center(
    child: Icon(
      Icons.person_outline_rounded,
      size: size * 0.42,
      color: accentColor,
    ),
  );

  void _showSourceSheet(BuildContext context, bool hasAvatar) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      builder: (_) => _SourceSheet(
        bloc: context.read<UserSetupBloc>(),
        hasAvatar: hasAvatar,
        accentColor: accentColor,
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final bool hasAvatar;
  final Color accentColor;

  const _Badge({required this.hasAvatar, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: accentColor,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Icon(
        hasAvatar ? Icons.edit_rounded : Icons.add_rounded,
        color: Colors.white,
        size: 14,
      ),
    );
  }
}

class _SourceSheet extends StatelessWidget {
  final UserSetupBloc bloc;
  final bool hasAvatar;
  final Color accentColor;

  const _SourceSheet({
    required this.bloc,
    required this.hasAvatar,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsetsGeometry.fromLTRB(16, 0, 16, 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: 12, bottom: 20),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Text(
              'Profile Photo',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _Option(
                  icon: Icons.photo_library_rounded,
                  label: 'Gallery',
                  color: accentColor,
                  onTap: () {
                    Navigator.pop(context);
                    bloc.add(AvatarPickFromGalleryRequested());
                  },
                ),
                _Option(
                  icon: Icons.camera_alt_rounded,
                  label: 'Camera',
                  color: accentColor,
                  onTap: () {
                    Navigator.pop(context);
                    bloc.add(AvatarPickFromCameraRequested());
                  },
                ),
                if (hasAvatar)
                  _Option(
                    icon: Icons.delete_outline_outlined,
                    label: 'Remove',
                    color: Colors.red,
                    onTap: () {
                      Navigator.pop(context);
                      bloc.add(AvatarRemoveRequested());
                    },
                  ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _Option extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _Option({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 48),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
