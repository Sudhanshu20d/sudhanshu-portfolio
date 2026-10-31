import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  AppTypography._();

  // Role A: DISPLAY HEADING - Heavy, Bold Grotesk / Sans-serif
  static TextStyle displayHeading({
    double fontSize = 84,
    FontWeight fontWeight = FontWeight.w700,
    Color? color,
    double height = 0.96,
    double? letterSpacing,
  }) {
    return GoogleFonts.spaceGrotesk(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? AppColors.textPrimary,
      letterSpacing: letterSpacing ?? -fontSize * 0.05,
      height: height,
    ).copyWith(fontFamilyFallback: const ['Arial', 'sans-serif']);
  }

  // Alias for hero title
  static TextStyle heroTitle({double fontSize = 88, bool italic = false}) {
    if (italic) {
      return editorialItalic(fontSize: fontSize, color: AppColors.accent);
    }
    return displayHeading(fontSize: fontSize);
  }

  static TextStyle sectionTitle({double fontSize = 48, bool italic = false}) {
    if (italic) {
      return editorialItalic(fontSize: fontSize);
    }
    return displayHeading(
      fontSize: fontSize,
      letterSpacing: -fontSize * 0.05,
      height: 1.02,
    );
  }

  static TextStyle cardTitle({double fontSize = 26, bool italic = false}) {
    if (italic) {
      return editorialItalic(fontSize: fontSize);
    }
    return displayHeading(
      fontSize: fontSize,
      letterSpacing: -fontSize * 0.05,
      height: 1.15,
    );
  }

  // Role B: EDITORIAL ITALIC - High-contrast literary serif in italics
  static TextStyle editorialItalic({
    double fontSize = 28,
    Color? color,
    FontWeight fontWeight = FontWeight.w400,
    double height = 1.25,
  }) {
    return GoogleFonts.spaceGrotesk(
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: FontStyle.normal,
      color: color ?? AppColors.textPrimary,
      height: height,
      letterSpacing: -0.3,
    ).copyWith(fontFamilyFallback: const ['Arial', 'sans-serif']);
  }

  static TextStyle editorialIndex({double fontSize = 56, bool italic = false}) {
    return editorialItalic(fontSize: fontSize, color: AppColors.accent);
  }

  // Role C: TECHNICAL LABELS - Monospace Uppercase
  static TextStyle monoLabel({
    double fontSize = 11,
    Color? color,
    FontWeight fontWeight = FontWeight.w400,
    double letterSpacing = 1.6,
  }) {
    return GoogleFonts.jetBrainsMono(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? AppColors.textPrimary,
      letterSpacing: letterSpacing,
      height: 1.2,
    ).copyWith(fontFamilyFallback: const ['Courier New', 'monospace']);
  }

  static TextStyle monoNumber({
    double fontSize = 13,
    Color? color,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return GoogleFonts.jetBrainsMono(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? AppColors.textPrimary,
      letterSpacing: 1.0,
      height: 1.0,
    ).copyWith(fontFamilyFallback: const ['Courier New', 'monospace']);
  }

  // General Editorial Body Typography
  static TextStyle bodyLead({Color? color, double height = 1.55}) {
    return GoogleFonts.spaceGrotesk(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: color ?? AppColors.textPrimary,
      height: height,
      letterSpacing: -0.2,
    ).copyWith(fontFamilyFallback: const ['Arial', 'sans-serif']);
  }

  static TextStyle bodyLarge({Color? color, double height = 1.6}) {
    return GoogleFonts.spaceGrotesk(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: color ?? AppColors.textMuted,
      height: height,
      letterSpacing: -0.1,
    ).copyWith(fontFamilyFallback: const ['Arial', 'sans-serif']);
  }

  static TextStyle bodyMedium({
    Color? color,
    double height = 1.55,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return GoogleFonts.spaceGrotesk(
      fontSize: 14.5,
      fontWeight: fontWeight,
      color: color ?? AppColors.textPrimary,
      height: height,
      letterSpacing: 0,
    ).copyWith(fontFamilyFallback: const ['Arial', 'sans-serif']);
  }

  static TextStyle bodySmall({Color? color}) {
    return GoogleFonts.spaceGrotesk(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      color: color ?? AppColors.textMuted,
      letterSpacing: 0,
      height: 1.4,
    ).copyWith(fontFamilyFallback: const ['Arial', 'sans-serif']);
  }

  static TextStyle buttonText({Color? color}) {
    return GoogleFonts.spaceGrotesk(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: color ?? AppColors.textPrimary,
      letterSpacing: 0.5,
    ).copyWith(fontFamilyFallback: const ['Arial', 'sans-serif']);
  }
}
