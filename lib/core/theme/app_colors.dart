import 'package:flutter/material.dart';

/// Flutter equivalents of the web shell's CSS custom properties.
class AppColors {
  AppColors._();
  static bool get isLight =>
      WidgetsBinding.instance.platformDispatcher.platformBrightness ==
      Brightness.light;
  static Color get background =>
      isLight ? const Color(0xFFEFEFEC) : const Color(0xFF0B0B0C);
  static Color get surface =>
      isLight ? const Color(0xFFE8E8E5) : const Color(0xFF111113);
  static Color get surfaceElevated =>
      isLight ? const Color(0xFFDFDFDC) : const Color(0xFF171719);
  static Color get surfaceGlass => background.withValues(alpha: 0.96);
  static Color get textPrimary =>
      isLight ? const Color(0xFF0B0B0C) : const Color(0xFFEDEDED);
  static const Color textMuted = Color(0xFF7D7D83);
  static Color get textDim =>
      isLight ? const Color(0xFF65656B) : const Color(0xFF95959B);
  static const Color accent = Color(0xFFFF4B1F);
  static const Color accentSubtle = Color(0x1FFF4B1F);
  static Color get border =>
      isLight ? const Color(0xFFD0D0CD) : const Color(0xFF222225);
  static Color get borderLight =>
      isLight ? const Color(0xFFBDBDBA) : const Color(0xFF38383D);
  static const Color borderAccent = Color(0x66FF4B1F);
  static Color get hairline => border;
  static const Color liveGreen = accent;
  static const Color privateAmber = accent;
}
