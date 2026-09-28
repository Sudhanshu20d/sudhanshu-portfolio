import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  AppTypography._();

  // Role A: DISPLAY HEADING - Heavy, Bold Grotesk / Sans-serif
  static TextStyle displayHeading({
    double fontSize = 84,
    FontWeight fontWeight = FontWeight.w700,
    Color color = AppColors.textPrimary,
    double height = 0.96,
    double letterSpacing = -2.0,
  }) {
    return GoogleFonts.spaceGrotesk(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
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
    return displayHeading(fontSize: fontSize, letterSpacing: -1.2, height: 1.02);
  }

  static TextStyle cardTitle({double fontSize = 26, bool italic = false}) {
    if (italic) {
      return editorialItalic(fontSize: fontSize);
    }
    return displayHeading(fontSize: fontSize, letterSpacing: -0.6, height: 1.15);
  }

  // Role B: EDITORIAL ITALIC - High-contrast literary serif in italics
  static TextStyle editorialItalic({
    double fontSize = 28,
    Color color = AppColors.textPrimary,
    FontWeight fontWeight = FontWeight.w400,
    double height = 1.25,
  }) {
    return GoogleFonts.newsreader(
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: FontStyle.italic,
      color: color,
      height: height,
      letterSpacing: -0.3,
    );
  }

  static TextStyle editorialIndex({double fontSize = 56, bool italic = false}) {
    return editorialItalic(fontSize: fontSize, color: AppColors.accent);
  }

  // Role C: TECHNICAL LABELS - Monospace Uppercase
  static TextStyle monoLabel({
    double fontSize = 11,
    Color color = AppColors.textMuted,
    FontWeight fontWeight = FontWeight.w400,
    double letterSpacing = 1.6,
  }) {
    return GoogleFonts.ibmPlexMono(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: 1.2,
    );
  }

  static TextStyle monoNumber({
    double fontSize = 13,
    Color color = AppColors.accent,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return GoogleFonts.ibmPlexMono(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: 1.0,
      height: 1.0,
    );
  }

  // General Editorial Body Typography
  static TextStyle bodyLead({Color color = AppColors.textPrimary, double height = 1.55}) {
    return GoogleFonts.spaceGrotesk(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: color,
      height: height,
      letterSpacing: -0.2,
    );
  }

  static TextStyle bodyLarge({Color color = AppColors.textMuted, double height = 1.6}) {
    return GoogleFonts.spaceGrotesk(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: color,
      height: height,
      letterSpacing: -0.1,
    );
  }

  static TextStyle bodyMedium({
    Color color = AppColors.textMuted,
    double height = 1.55,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return GoogleFonts.spaceGrotesk(
      fontSize: 14.5,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: 0,
    );
  }

  static TextStyle bodySmall({Color color = AppColors.textMuted}) {
    return GoogleFonts.spaceGrotesk(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      color: color,
      letterSpacing: 0,
      height: 1.4,
    );
  }

  static TextStyle buttonText({Color color = AppColors.textPrimary}) {
    return GoogleFonts.spaceGrotesk(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: color,
      letterSpacing: 0.5,
    );
  }
}
