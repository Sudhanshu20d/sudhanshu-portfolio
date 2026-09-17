import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  AppTypography._();

  // Display - Fraunces
  static TextStyle heroTitle({double fontSize = 92, bool italic = false}) {
    return GoogleFonts.fraunces(
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      fontStyle: italic ? FontStyle.italic : FontStyle.normal,
      color: AppColors.textPrimary,
      letterSpacing: -1.8,
      height: 0.95,
    );
  }

  static TextStyle sectionTitle({double fontSize = 48, bool italic = false}) {
    return GoogleFonts.fraunces(
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      fontStyle: italic ? FontStyle.italic : FontStyle.normal,
      color: AppColors.textPrimary,
      letterSpacing: -1.2,
      height: 1.1,
    );
  }

  static TextStyle cardTitle({double fontSize = 28, bool italic = false}) {
    return GoogleFonts.fraunces(
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      fontStyle: italic ? FontStyle.italic : FontStyle.normal,
      color: AppColors.textPrimary,
      letterSpacing: -0.6,
      height: 1.15,
    );
  }

  // Body - Space Grotesk
  static TextStyle bodyLarge({Color color = AppColors.textMuted, double height = 1.6}) {
    return GoogleFonts.spaceGrotesk(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: color,
      height: height,
      letterSpacing: -0.2,
    );
  }

  static TextStyle bodyMedium({Color color = AppColors.textMuted, double height = 1.5, FontWeight fontWeight = FontWeight.w400}) {
    return GoogleFonts.spaceGrotesk(
      fontSize: 15,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: -0.1,
    );
  }

  static TextStyle bodySmall({Color color = AppColors.textMuted}) {
    return GoogleFonts.spaceGrotesk(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      color: color,
      letterSpacing: 0,
    );
  }

  // Mono - IBM Plex Mono (Numbers, indices, tech badges)
  static TextStyle monoNumber({double fontSize = 14, Color color = AppColors.accent, FontWeight fontWeight = FontWeight.w500}) {
    return GoogleFonts.ibmPlexMono(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: 1.0,
      height: 1.0,
    );
  }

  static TextStyle monoLabel({double fontSize = 12, Color color = AppColors.textMuted}) {
    return GoogleFonts.ibmPlexMono(
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      color: color,
      letterSpacing: 1.2,
    );
  }

  static TextStyle buttonText({Color color = AppColors.textPrimary}) {
    return GoogleFonts.spaceGrotesk(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: color,
      letterSpacing: 0.5,
    );
  }
}
