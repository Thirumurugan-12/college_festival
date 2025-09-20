import 'package:flutter/material.dart';

class AppColors {
  // Music Festival Theme Colors
  static const Color primaryBg = Color(0xFF10002B);
  static const Color secondaryBg = Color(0xFF240046);
  static const Color accentPink = Color(0xFFFF00A6);
  static const Color accentCyan = Color(0xFF00F5FF);
  static const Color accentPurple = Color(0xFF7B2CBF);
  static const Color accentOrange = Color(0xFFFF8C1A);
  static const Color accentYellow = Color(0xFFFFC107);
  static const Color accentGold = Color(0xFFFFD700);
  static const Color white = Color(0xFFFFFFFF);
  static const Color transparent = Color(0x00000000);

  // Gradients
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [primaryBg, secondaryBg],
  );
}
