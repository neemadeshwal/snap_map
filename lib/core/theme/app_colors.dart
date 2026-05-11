import 'dart:ui';
import 'package:flutter/painting.dart';

class AppColors {
  AppColors._();

  // ==================== PRIMARY COLORS ====================
  // Light Mode
  static const Color primary = Color(0XFF006175);
  static const Color primarySoft = Color(0XFF02809C);
  static const Color primaryLight = Color(0XFF41B3C7);
  // Dark Mode - Slightly desaturated and brighter for better dark mode contrast
  static const Color primaryDark = Color(0XFF68D1E6);
  static const Color primarySoftDark = Color(0XFF8CE2F4);
  static const Color primaryLightDark = Color(0XFFBCEEF7);
  static const Color primaryDarkest = Color(0XFF003743);

  // ==================== SECONDARY COLORS ====================
  // Light Mode (Complementary Amber/Orange Accent)
  static const Color secondary = Color(0XFFD97706);

  // Dark Mode
  static const Color secondaryDark = Color(0XFFF59E0B);

  // ==================== BACKGROUND & SURFACE ====================
  // Light Mode
  static const Color background = Color(0XFFF3F4F6);
  static const Color surface = Color(0XFFFFFFFF);
  static const Color surfaceVariant = Color(0XFFF9FAFB);

  // Dark Mode - Deep, rich dark colors
  static const Color backgroundDark = Color(0XFF0B0F19);
  static const Color surfaceDark = Color(0XFF171F33);
  static const Color surfaceVariantDark = Color(0XFF202B42);
  static const Color surfaceElevated = Color(0XFF2A364F);

  // ==================== TEXT COLORS ====================
  // Light Mode
  static const Color textPrimary = Color(0XFF1A202C);
  static const Color textSecondary = Color(0XFF4A5568);
  static const Color textTitle = Color(0XFF0F172A);
  static const Color textParagraph = Color(0XFF718096);
  static const Color textPlaceholder = Color(0XFFA0AEC0);
  static const Color textDisabled = Color(0XFFCBD5E0);
  static const Color textOnPrimary = Color(0XFFFFFFFF);
  static const Color textTitleColored = Color(0XFFE6FFFA);
  static const Color textSubTitleColored = Color(0XFFCCFBF1);

  // Dark Mode - High contrast for readability
  static const Color textPrimaryDark = Color(0XFFF7FAFC);
  static const Color textSecondaryDark = Color(0XFFCBD5E0);
  static const Color textTitleDark = Color(0XFFFFFFFF);
  static const Color textParagraphDark = Color(0XFFA0AEC0);
  static const Color textPlaceholderDark = Color(0XFF718096);
  static const Color textDisabledDark = Color(0XFF4A5568);
  static const Color textOnPrimaryDark = Color(0XFF0B0F19);

  // ==================== SIDEBAR COLORS ====================
  // Light Mode
  static const Color sidebarTitle = Color(0XFF2D3748);
  static const Color sidebarSubTitle = Color(0XFF718096);

  // Dark Mode
  static const Color sidebarTitleDark = Color(0XFFF7FAFC);
  static const Color sidebarSubTitleDark = Color(0XFFA0AEC0);

  // ==================== STATUS COLORS ====================
  // Light Mode
  static const Color error = Color(0XFFEF4444);
  static const Color success = Color(0XFF10B981);
  static const Color warning = Color(0XFFF59E0B);
  static const Color info = Color(0XFF3B82F6);

  // Dark Mode - Slightly brighter for better visibility on dark bg
  static const Color errorDark = Color(0XFFFF6B6B);
  static const Color successDark = Color(0XFF34D399);
  static const Color warningDark = Color(0XFFFBBF24);
  static const Color infoDark = Color(0XFF60A5FA);

  // ==================== UTILITY COLORS ====================
  // Light Mode
  static const Color border = Color(0XFFE2E8F0);
  static const Color divider = Color(0XFFEDF2F7);
  static const Color disabled = Color(0XFFCBD5E0);
  static const Color shadow = Color(0X0F000000);

  // Dark Mode
  static const Color borderDark = Color(0XFF202B42);
  static const Color dividerDark = Color(0XFF171F33);
  static const Color disabledDark = Color(0XFF3A4660);
  static const Color shadowDark = Color(0X26000000);

  // ==================== INPUT FIELD COLORS ====================
  // Light Mode
  static const Color inputBorder = Color(0XFFE2E8F0);
  static const Color inputFocused = Color(0XFF006175);
  static const Color inputBackground = Color(0XFFF2F2F2);

  // Dark Mode
  static const Color inputBackgroundDark = Color(0XFF131B2E);
  static const Color inputBorderDark = Color(0XFF202B42);
  static const Color inputFocusedDark = Color(0XFF68D1E6);

  // ==================== SPECIAL COLORS ====================
  // Light Mode
  static const Color overlay = Color(0X80000000);
  static const Color shimmer = Color(0XFFE2E8F0);

  // Dark Mode
  static const Color overlayDark = Color(0XB3000000);
  static const Color shimmerDark = Color(0XFF202B42);
  static const Color shimmerHighlight = Color(0XFF303E5C);

  // ==================== GRADIENT COLORS ====================
  // Light Mode Gradients
  static const Color gradientStart = Color(0XFF006175);
  static const Color gradientEnd = Color(0XFF02809C);

  // Dark Mode Gradients
  static const Color gradientStartDark = Color(0XFF003743);
  static const Color gradientEndDark = Color(0XFF2D899B);

  // Background Gradients
  static const BoxDecoration backgroundGradient = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xFF023E4A), // Very dark teal
        Color(0xFF007E96), // Bright teal
      ],
    ),
  );
}
