import 'package:flutter/material.dart';
import 'package:snapmap/core/theme/app_colors.dart';
import 'package:snapmap/core/theme/app_text_styles.dart';
import 'package:snapmap/features/onboarding/data/model/interests_model.dart';

class InterestChip extends StatefulWidget {
  final InterestModel interest;
  final bool isSelected;
  final ValueChanged<String> onTap;

  const InterestChip({
    super.key,
    required this.interest,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<InterestChip> createState() => _InterestChipState();
}

class _InterestChipState extends State<InterestChip>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(microseconds: 120),
      lowerBound: 0.0,
      upperBound: 1.0,
    );

    _scaleAnim = Tween<double>(
      begin: 1.0,
      end: 0.93,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleTap() async {
    await _controller.forward();
    await _controller.reverse();
    widget.onTap(widget.interest.id);
  }

  @override
  Widget build(BuildContext context) {
    final bool selected = widget.isSelected;

    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedBuilder(
        animation: _scaleAnim,
        builder: (context, child) =>
            Transform.scale(scale: _scaleAnim.value, child: child),

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : AppColors.inputBackground,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.border,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.interest.emoji, style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 6),
              AnimatedDefaultTextStyle(
                style: AppTextStyles.buttonLarge,
                duration: const Duration(milliseconds: 200),
                child: Text(
                  widget.interest.label,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: selected
                        ? AppColors.textOnPrimary
                        : AppColors.textOnPrimaryDark,
                  ),
                ),
              ),
              // checkmark appears when selected
              AnimatedSize(
                duration: const Duration(milliseconds: 120),
                curve: Curves.easeInOut,
                child: selected
                    ? const Padding(
                        padding: EdgeInsets.only(left: 6),
                        child: Icon(
                          Icons.check_rounded,
                          size: 14,
                          color: Colors.white,
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
