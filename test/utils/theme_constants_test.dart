import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latent_power/utils/theme_constants.dart';

void main() {
  group('ThemeConstants', () {
    group('Colors', () {
      test('should have correct primary colors', () {
        expect(ThemeConstants.primaryColor, const Color(0xFFFF6B35));
        expect(ThemeConstants.secondaryColor, const Color(0xFFF7931E));
        expect(ThemeConstants.tertiaryColor, const Color(0xFFDC143C));
      });

      test('should have correct surface colors', () {
        expect(ThemeConstants.surfaceColor, const Color(0xFF1C1C1E));
        expect(ThemeConstants.cardColor, const Color(0xFF2C2C2E));
        expect(ThemeConstants.backgroundColor, const Color(0xFF000000));
      });

      test('should have correct text colors', () {
        expect(ThemeConstants.onSurfaceColor, const Color(0xFFE5E5E7));
        expect(ThemeConstants.onPrimaryColor, const Color(0xFFFFFFFF));
      });
    });

    group('Gradients', () {
      test('should have correct primary gradient', () {
        expect(ThemeConstants.primaryGradient, [
          ThemeConstants.primaryColor,
          ThemeConstants.secondaryColor,
        ]);
      });

      test('should have victory gradient', () {
        expect(ThemeConstants.victoryGradient, const [
          Color(0xFF28A745),
          Color(0xFF20C997),
        ]);
      });

      test('should have defeat gradient', () {
        expect(ThemeConstants.defeatGradient, const [
          Color(0xFFDC3545),
          Color(0xFFFF6B6B),
        ]);
      });

      test('should have warning gradient', () {
        expect(ThemeConstants.warningGradient, const [
          Color(0xFFFFC107),
          Color(0xFFFF8F00),
        ]);
      });
    });

    group('Border Radius', () {
      test('should have correct border radius values', () {
        expect(ThemeConstants.borderRadius, 12.0);
        expect(ThemeConstants.cardBorderRadius, 16.0);
        expect(ThemeConstants.buttonBorderRadius, 24.0);
      });
    });

    group('Padding', () {
      test('should have correct padding values', () {
        expect(ThemeConstants.defaultPadding, const EdgeInsets.all(16.0));
        expect(ThemeConstants.cardPadding, const EdgeInsets.all(20.0));
        expect(ThemeConstants.buttonPadding, const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0));
      });
    });

    group('Elevation', () {
      test('should have correct elevation values', () {
        expect(ThemeConstants.defaultElevation, 4.0);
        expect(ThemeConstants.cardElevation, 8.0);
        expect(ThemeConstants.buttonElevation, 6.0);
      });
    });

    group('Shadows', () {
      test('should create shadows with correct properties', () {
        final shadow = ThemeConstants.defaultShadow(Colors.red);
        
        expect(shadow.color, Colors.red.withValues(alpha: 0.3));
        expect(shadow.blurRadius, 8.0);
        expect(shadow.offset, const Offset(0, 2));
      });

      test('should have predefined shadows', () {
        expect(ThemeConstants.primaryShadow.color, ThemeConstants.primaryColor.withValues(alpha: 0.3));
        expect(ThemeConstants.victoryShadow.color, const Color(0xFF28A745).withValues(alpha: 0.3));
        expect(ThemeConstants.defeatShadow.color, const Color(0xFFDC3545).withValues(alpha: 0.3));
      });
    });

    group('Color Consistency', () {
      test('should maintain color consistency in gradients', () {
        expect(ThemeConstants.primaryGradient.first, ThemeConstants.primaryColor);
        expect(ThemeConstants.primaryGradient.last, ThemeConstants.secondaryColor);
      });

      test('should have consistent shadow colors', () {
        final primaryShadow = ThemeConstants.primaryShadow;
        expect(primaryShadow.color.red, ThemeConstants.primaryColor.red);
        expect(primaryShadow.color.green, ThemeConstants.primaryColor.green);
        expect(primaryShadow.color.blue, ThemeConstants.primaryColor.blue);
      });
    });
  });
}