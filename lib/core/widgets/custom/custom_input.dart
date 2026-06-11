import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snapmap/core/theme/app_colors.dart';
import 'package:snapmap/core/theme/app_dimensions.dart';
import 'package:snapmap/core/utils/extensions.dart';

class CustomInput extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String hint;
  final String? errorText;
  final String? helperText;
  final Widget? iconLeft;
  final Widget? iconRight;
  final String? prefixText;

  // sizing
  final double? width;
  final double? height;
  final EdgeInsets? contentPadding;

  final double? borderRadius;
  final double? borderWidth;

  // styling
  final Color? bgColor;
  final Color? textColor;
  final Color? hintColor;
  final Color? labelColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;

  // state
  final FocusNode? focusNode;
  final bool autoFocus;

  // callbacks
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  final Function(String)? onSubmitted;
  final String? Function(String?)? validator;

  // input behavior
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final int maxLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;

  const CustomInput({
    super.key,
    required this.label,
    required this.hint,
    this.iconLeft,
    this.iconRight,
    this.width,
    this.height,
    this.borderRadius,
    this.borderWidth,
    this.bgColor,
    this.textColor,
    this.hintColor,
    this.borderColor,
    this.autoFocus = false,
    this.contentPadding,
    required this.controller,
    this.enabled = true,
    this.errorBorderColor,
    this.errorText,
    this.focusNode,
    this.focusedBorderColor,
    this.helperText,
    this.inputFormatters,
    this.keyboardType = TextInputType.text,
    this.labelColor,
    this.maxLength,
    this.maxLines = 1,
    this.obscureText = false,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.readOnly = false,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.prefixText,
  });

  @override
  State<CustomInput> createState() => _CustomInput();
}

class _CustomInput extends State<CustomInput> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 1. Detect if system/app is currently in dark mode
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // 2. Dynamic Colors based on theme mode
    final defaultBgColor = isDarkMode
        ? Colors.grey[900]! // Dark theme background fill
        : AppColors.inputBackground; // Light theme background fill

    final defaultFocusedBgColor = isDarkMode ? Colors.black : Colors.white;

    final defaultTextColor = isDarkMode ? Colors.white : Colors.black87;

    final defaultHintColor = isDarkMode
        ? Colors.grey[500]! // Clearer placeholder for dark mode
        : AppColors.textPlaceholder;

    final defaultLabelColor = isDarkMode
        ? Colors.grey[300]!
        : AppColors.textSecondary;

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Prevents layout issues when wrapped
        children: [
          Text(
            widget.label.capitalize(),
            style: TextStyle(
              color: widget.labelColor ?? defaultLabelColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: AppDimensions.height12),
          TextFormField(
            controller: widget.controller,
            focusNode: _focusNode,
            enabled: widget.enabled,
            readOnly: widget.readOnly,
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            inputFormatters: widget.inputFormatters,
            textCapitalization: widget.textCapitalization,
            autofocus: widget.autoFocus,
            onChanged: widget.onChanged,
            onTap: widget.onTap,
            onFieldSubmitted: widget.onSubmitted,
            validator: widget.validator,
            // Dynamic text styling inside input field
            style: TextStyle(color: widget.textColor ?? defaultTextColor),
            decoration: InputDecoration(
              prefixText: widget.prefixText,
              prefixStyle: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
              filled: true,
              prefixIconConstraints: const BoxConstraints(
                minWidth: 40,
                maxHeight: 40,
              ),
              suffixIconConstraints: const BoxConstraints(
                minWidth: 40,
                maxHeight: 40,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              // Adapts background color based on focus state and theme mode
              fillColor: _isFocused
                  ? (widget.bgColor ?? defaultFocusedBgColor)
                  : (widget.bgColor ?? defaultBgColor),
              hintStyle: TextStyle(color: widget.hintColor ?? defaultHintColor),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  widget.borderRadius ?? AppDimensions.radiusLG,
                ),
                borderSide: BorderSide(
                  color:
                      widget.borderColor ??
                      (isDarkMode ? Colors.grey[800]! : Colors.transparent),
                  width: widget.borderWidth ?? 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  widget.borderRadius ?? AppDimensions.radiusLG,
                ),
                borderSide: BorderSide(
                  color: widget.focusedBorderColor ?? AppColors.primary,
                  width: widget.borderWidth ?? 2.0,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  widget.borderRadius ?? AppDimensions.radiusLG,
                ),
                borderSide: BorderSide(
                  color: widget.errorBorderColor ?? AppColors.error,
                  width: widget.borderWidth ?? 1.0,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  widget.borderRadius ?? AppDimensions.radiusLG,
                ),
                borderSide: BorderSide(
                  color: widget.errorBorderColor ?? AppColors.error,
                  width: widget.borderWidth ?? 2.0,
                ),
              ),
              contentPadding:
                  widget.contentPadding ??
                  EdgeInsets.symmetric(horizontal: 20, vertical: 22),
              labelText: '',
              hintText: widget.hint,
              errorText: widget.errorText,
              helperText: widget.helperText,
              prefixIcon: widget.iconLeft,
              suffixIcon: widget.iconRight,
            ),
          ),
        ],
      ),
    );
  }
}
