import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snapmap/core/theme/app_colors.dart';

class CommonBackButton extends StatelessWidget {
  const CommonBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        borderRadius: BorderRadius.circular(99),
        onTap: () => context.pop(),
        child: const Padding(
          padding: EdgeInsets.all(
            8.0,
          ), // Adjust this padding to control spacing around the icon
          child: Icon(
            Icons.chevron_left,
            color: AppColors.textPrimary, // Or your custom text color
          ),
        ),
      ),
    );
  }
}
