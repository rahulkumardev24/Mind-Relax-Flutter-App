import 'package:flutter/material.dart';

class AppColors {
  // 🌊 Calming Blue Shades (Most relaxing color scientifically)
  static const Color primary = Color(0xff7f9fbd);

  // 🌿 Nature Green Shades (Connection with nature)
  static const Color secondary = Color(0xffF5F5DC);

  static const Color green = Color(0xff2ce5b7);



  // 🪷 Soft Purple Shades (Spiritual & calm)
  static const Color accent = Color(0xFF967BB6);

  // 🏔️ Deep Background (For contrast & focus)
  static const Color background = Color(0xFF0A1929);

  // 🪨 Card Surface (Soothing contrast)
  static const Color cardColor = Color(0xFF1E2A3A);

  // ☁️ Text Colors (Soft & readable)
  static const Color textPrimary = Color(0xFFE8F4F8);
  static const Color textSecondary = Color(0xFFB0BEC5);
}

class AppGradients {
  // 🌊 Ocean Calm Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF4A6572), Color(0xFF336B87)], // Serene Blue to Deep Teal
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // 🌿 Forest Peace Gradient
  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [
      Color(0xFF2D5A3D),
      Color(0xFF87A96B),
    ], // Forest Green to Sage Green
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class AppTextStyles {
  static TextStyle headlineLarge = const TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w300,
    color: AppColors.textPrimary,
    letterSpacing: 0.5,
  );

  static TextStyle headlineMedium = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    letterSpacing: 0.3,
  );

  static TextStyle bodyLarge = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    letterSpacing: 0.2,
  );

  static TextStyle bodyMedium = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w300, // Lighter weight for relaxation
    color: AppColors.textSecondary,
    letterSpacing: 0.1,
  );
}
