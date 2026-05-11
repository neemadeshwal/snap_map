import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapmap/core/theme/app_colors.dart';
import 'package:snapmap/core/theme/app_dimensions.dart';
import 'package:snapmap/core/theme/app_text_styles.dart';

enum ButtonSize { extrasmall, small, medium, large, extralarge }

class CustomButton extends StatelessWidget {
  final String? text;
  final Widget? iconLeft;
  final Widget? iconRight;
  final VoidCallback? onPressed;

  final double? width;
  final double? height;

  final ButtonSize size;
  final bool isFullWidth;

  final bool isLoading;
  final EdgeInsets? padding;

  final Color? bgColor;
  final Color? textColor;
  final Color? borderColor;
  final Gradient? bgGradient;
  final double? borderRadius;
  final double? borderWidth;

  const CustomButton({
    super.key,
    required this.text,
    this.iconLeft,
    this.iconRight,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.isFullWidth = false,
    this.isLoading = false,
    this.bgColor,
    this.bgGradient,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
    this.padding,
    this.textColor,
    this.width,
    this.height,
  });

  // =============== Factory constructors ================

  // Primary button (filled background)
  factory CustomButton.primary({
    required String text,
    required VoidCallback? onPressed,
    ButtonSize size = ButtonSize.medium,
    bool isFullWidth = false,
    bool isLoading = false,
    Widget? iconLeft,
    Widget? iconRight,
    Color? bgColor,
    Color? textColor,
    Gradient? bgGradient,
    EdgeInsets? padding,
  }) {
    return CustomButton(
      onPressed: onPressed,
      isFullWidth: isFullWidth,
      size: size,
      text: text,
      iconLeft: iconLeft,
      iconRight: iconRight,
      bgColor: bgColor,
      textColor: textColor,
      bgGradient: bgGradient,
      padding: padding,
      isLoading: isLoading,
    );
  }

  // Text button (no background or border)
  factory CustomButton.text({
    required String text,
    required VoidCallback? onPressed,
    double width = 40,
    ButtonSize size = ButtonSize.medium,
    bool isFullWidth = false,
    bool isLoading = false,
    Color? bgColor,
    Color? textColor,
  }) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      isFullWidth: isFullWidth,
      width: width,
      isLoading: isLoading,
      bgColor: bgColor ?? Colors.transparent,
      textColor: textColor,
    );
  }

  // Outlined button (border only)
  factory CustomButton.outlined({
    required String text,
    required VoidCallback? onPressed,
    ButtonSize size = ButtonSize.medium,
    bool isFullWidth = false,
    bool isLoading = false,
    Color? bgColor,
    double? height,
    Color? textColor,
    EdgeInsets? padding,
    double? borderWidth,
    Color? borderColor,
    Widget? iconLeft,
  }) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      isFullWidth: isFullWidth,
      isLoading: isLoading,
      bgColor: bgColor ?? Colors.transparent,
      textColor: textColor,
      padding: padding,
      borderWidth: borderWidth,
      borderColor: borderColor ?? AppColors.primary,
      height: height,
      iconLeft: iconLeft,
    );
  }

  // Icon button
  factory CustomButton.icon({
    required Widget icon,
    required VoidCallback? onPressed,
    ButtonSize size = ButtonSize.small,
    Color? bgColor,
    Color? textColor,
    double? borderRadius,
    EdgeInsets? padding,
    Color? borderColor,
    double? borderWidth,
  }) {
    return CustomButton(
      text: null,
      iconLeft: icon,
      onPressed: onPressed,
      size: size,
      bgColor: bgColor,
      textColor: textColor,
      borderRadius: borderRadius,
      padding: padding,
      borderColor: borderColor,
      borderWidth: borderWidth,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null || isLoading;

    // Remove the default width and height constraints if text is null
    final double? buttonWidth = isFullWidth
        ? double.infinity
        : (width ??
              (text == null || text!.isEmpty
                  ? null
                  : AppDimensions.buttonWidthMD));

    final double? buttonHeight =
        height ?? (text == null || text!.isEmpty ? null : _getHeight());

    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isDisabled ? null : onPressed,
          child: Ink(
            padding: padding ?? (text == null ? const EdgeInsets.all(8) : null),
            decoration: BoxDecoration(
              color: bgGradient == null
                  ? isDisabled
                        ? AppColors.disabled
                        : bgColor ?? AppColors.primary
                  : null,
              gradient: isDisabled ? null : bgGradient,
              border: borderColor != null
                  ? Border.all(color: borderColor!, width: borderWidth ?? 1)
                  : null,
              borderRadius: BorderRadius.circular(borderRadius ?? 99),
            ),
            child: Center(child: isLoading ? _buildLoading() : _buildContent()),
          ),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return SizedBox(
      width: 20.w,
      height: 20.h,
      child: CircularProgressIndicator(
        color: textColor ?? AppColors.primary,
        strokeWidth: 2,
      ),
    );
  }

  Widget _buildContent() {
    final bool isDisabled = onPressed == null || isLoading;

    if (text == null || text!.isEmpty) {
      return iconLeft ?? const SizedBox.shrink();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (iconLeft != null) ...[iconLeft!, SizedBox(width: 8.w)],
        SizedBox(width: 8),
        Text(
          text!,
          style: AppTextStyles.buttonLarge.copyWith(
            color: isDisabled
                ? AppColors.textDisabled
                : (textColor ?? AppColors.textOnPrimary),
          ),
        ),
        if (iconRight != null) ...[SizedBox(width: 8.w), iconRight!],
      ],
    );
  }

  double _getHeight() {
    switch (size) {
      case ButtonSize.extrasmall:
        return AppDimensions.buttonHeightXS;
      case ButtonSize.small:
        return AppDimensions.buttonHeightSM;
      case ButtonSize.medium:
        return AppDimensions.buttonHeightMD;
      case ButtonSize.large:
        return AppDimensions.buttonHeightLG;
      case ButtonSize.extralarge:
        return AppDimensions.buttonHeightXL;
    }
  }
}
