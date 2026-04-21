import 'package:flutter/material.dart';

abstract final class AppColors {
  // Primary
  static const Color primary = Color(0xFF3BA147);
  static const Color primaryLight = Color(0xFFE6F1E7);
  static const Color primaryFaded = Color(0x333BA147); // 20% opacity

  // Surface
  static const Color surface = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFFFFFFF);
  static const Color scaffoldBackground = Color(0xFFF5F7F5);

  // Text
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF939393);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textLink = Color(0xFF3BA147);

  // Status
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color success = Color(0xFF3BA147);
  static const Color severityLow = Color(0xFF3BA147);
  static const Color severityMedium = Color(0xFFF59E0B);
  static const Color severityHigh = Color(0xFFEF4444);

  // UI
  static const Color divider = Color(0xFFE5E7EB);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color grabber = Color(0xFFCCCCCC);
  static const Color navBar = Color(0xFFFFFFFF);
  static const Color inputBackground = Color(0x333BA147);
}
