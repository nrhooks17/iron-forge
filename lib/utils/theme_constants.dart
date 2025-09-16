import 'package:flutter/material.dart';

class ThemeConstants {
  // Fiery orange
  static const Color primaryColor = Color(0xFFFF6B35);
  // Amber
  static const Color secondaryColor = Color(0xFFF7931E);
  // Crimson red
  static const Color tertiaryColor = Color(0xFFDC143C);
  // Dark charcoal
  static const Color surfaceColor = Color(0xFF1C1C1E);
  // Darker charcoal for cards
  static const Color cardColor = Color(0xFF2C2C2E);
  // Almost black for background
  static const Color backgroundColor = Color(0xFF000000);
  // Light gray for text
  static const Color onSurfaceColor = Color(0xFFE5E5E7);
  // White for primary text
  static const Color onPrimaryColor = Color(0xFFFFFFFF);

  static const List<Color> primaryGradient = [
    primaryColor,
    secondaryColor,
  ];

  static const List<Color> victoryGradient = [
    Color(0xFF28A745),
    Color(0xFF20C997),
  ];

  static const List<Color> defeatGradient = [
    Color(0xFFDC3545),
    Color(0xFFFF6B6B),
  ];

  static const List<Color> warningGradient = [
    Color(0xFFFFC107),
    Color(0xFFFF8F00),
  ];

  static const double borderRadius = 12.0;
  static const double cardBorderRadius = 16.0;
  static const double buttonBorderRadius = 24.0;

  static const EdgeInsets defaultPadding = EdgeInsets.all(16.0);
  static const EdgeInsets cardPadding = EdgeInsets.all(20.0);
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0);

  static const double defaultElevation = 4.0;
  static const double cardElevation = 8.0;
  static const double buttonElevation = 6.0;

  static BoxShadow defaultShadow(Color color) => BoxShadow(
    color: color.withValues(alpha: 0.3),
    blurRadius: 8,
    offset: const Offset(0, 2),
  );

  static BoxShadow primaryShadow = defaultShadow(primaryColor);
  static BoxShadow victoryShadow = defaultShadow(const Color(0xFF28A745));
  static BoxShadow defeatShadow = defaultShadow(const Color(0xFFDC3545));
}