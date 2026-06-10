import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryBlue = Color(0xFF0A6DD9);
  static const Color secondaryBlue = Color(0xFF4DB8FF);

  static const Color white = Colors.white;

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [primaryBlue, secondaryBlue],
  );
}
