import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract class AppTextStyles {
  static const TextStyle headerXl = TextStyle(
    color: AppColors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle sectionLabel = TextStyle(
    color: AppColors.primary,
    fontSize: 8,
    fontWeight: FontWeight.w900,
    letterSpacing: 1.5,
  );

  static const TextStyle segmentTag = TextStyle(
    color: AppColors.primary,
    fontSize: 10,
    fontWeight: FontWeight.w900,
    letterSpacing: 1.2,
  );

  static const TextStyle bodyWhite = TextStyle(
    color: AppColors.white,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle bodyGray = TextStyle(
    color: AppColors.gray500,
    fontSize: 14,
  );

  static const TextStyle inputText = TextStyle(
    color: AppColors.white,
    fontSize: 16,
  );

  static const TextStyle inputHint = TextStyle(
    color: AppColors.gray500,
    fontSize: 16,
  );

  static const TextStyle buttonText = TextStyle(
    color: AppColors.white,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle smallLabel = TextStyle(
    color: AppColors.gray500,
    fontSize: 10,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.5,
  );
}
