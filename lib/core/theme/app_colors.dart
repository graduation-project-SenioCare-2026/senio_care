import 'package:flutter/material.dart';

abstract class AppColors {
  // ======================
  // Grays (shades 100–900)
  // ======================
  static const MaterialColor gray = MaterialColor(0xFFC9CDD3, <int, Color>{
    100: Color(0xFFF0F0F0),
    200: Color(0xFFE0E0E0),
    300: Color(0xFFD0D4D9),
    400: Color(0xFFBFC4C9),
    500: Color(0xFFC9CDD3), // Cancel button
    600: Color(0xFFA6A9AF),
    700: Color(0xFF5F6368), // Chat icon border
    800: Color(0xFF4B4F54),
    900: Color(0xFF2E3134),
  });

  // ======================
  // Blacks (shades 100–900)
  // ======================
  static const MaterialColor black = MaterialColor(0xFF000000, <int, Color>{
    100: Color(0xFF1A1A1A),
    200: Color(0xFF333333),
    300: Color(0xFF4D4D4D),
    400: Color(0xFF666666),
    500: Color(0xFF000000), // Base black
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  });

  // ======================
  // Whites (shades 100–900)
  // ======================
  static const MaterialColor white = MaterialColor(0xFFFFFFFF, <int, Color>{
    100: Color(0xFFFFFFFF), // Base white
    200: Color(0xFFF9F9F9),
    300: Color(0xFFF2F2F2),
    400: Color(0xFFECECEC),
    500: Color(0xFFE5E5E5),
    600: Color(0xFFDEDEDE),
    700: Color(0xFFD7D7D7),
    800: Color(0xFFD0D0D0),
    900: Color(0xFFC9C9C9),
  });

  // ======================
  // Greens (shades 100–900)
  // ======================
  static const MaterialColor green = MaterialColor(0xFF42E55B, <int, Color>{
    100: Color(0xFFBFFFEF),
    200: Color(0xFF8CFFBF),
    300: Color(0xFF7BE976), // Circle done medicine
    400: Color(0xFF42E55B), // Fill done medicine 12%
    500: Color(0xFF1D9421), // Border done medicine 77%
    600: Color(0xFF176B1A),
    700: Color(0xFF115012),
    800: Color(0xFF0B350B),
    900: Color(0xFF061805),
  });

  // ======================
  // Blues (shades 100–900)
  // ======================
  static const MaterialColor blue = MaterialColor(0xFF3B82F6, <int, Color>{
    100: Color(0xFFB3D4FF),
    200: Color(0xFF80BFFF),
    300: Color(0xFF3B82F6), // Button
    400: Color(0xFF2563EB), // Fill un-taken 8% & border taken 77%
    500: Color(0xFF1E4CCB),
    600: Color(0xFF17399B),
    700: Color(0xFF10266A),
    800: Color(0xFF091439),
    900: Color(0xFF040A1A),
  });

  // ======================
  // Single colors (no shades)
  // ======================
  static const Color red = Color(0xFFF60C0C);

  // Gradient colors
  static const Color gradientStart = Color(0xFF2DD4BF);
  static const Color gradientMiddle = Color(0xFF2ECFC2);
  static const Color gradientEnd = Color(0xFF3B82F6);

  // Gradient stops
  static const List<double> gradientStops = [0.0, 0.13, 1.0];
}
