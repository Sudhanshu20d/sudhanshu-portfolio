import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Backgrounds - Near-black editorial canvas
  static const Color background = Color(0xFF09090A);
  static const Color surface = Color(0xFF111113);
  static const Color surfaceElevated = Color(0xFF161618);
  static const Color surfaceGlass = Color(0xF209090A);

  // Editorial Typography
  static const Color textPrimary = Color(0xFFF3F1EB); // Warm ivory / cream
  static const Color textMuted = Color(0xFF8E8C85);   // Muted editorial warm grey
  static const Color textDim = Color(0xFF56544E);     // Subtle technical graphite

  // Single Controlled Accent - Acid / Lime Green
  static const Color accent = Color(0xFFD2F832);      // Acid/lime green
  static const Color accentSubtle = Color(0x1FD2F832);

  // Hairline Rules & Editorial Dividers
  static const Color border = Color(0x1AFFFFFF);       // Subtle dark grey hairline
  static const Color borderLight = Color(0x2EFFFFFF);
  static const Color borderAccent = Color(0x40D2F832);
  static const Color hairline = Color(0x14FFFFFF);

  // Subtle Status Accents
  static const Color liveGreen = Color(0xFFD2F832);
  static const Color privateAmber = Color(0xFFE5A93C);
}
