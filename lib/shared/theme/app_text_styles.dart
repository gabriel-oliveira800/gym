import 'package:flutter/material.dart';
import 'app_colors.dart';
import '../constants/app_sizes.dart';

abstract class AppTextStyles {
  static const TextStyle headerXl = TextStyle(
    color: AppColors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle brandText = TextStyle(
    color: AppColors.white,
    fontSize: 20,
    fontWeight: FontWeight.w900,
    fontStyle: FontStyle.italic,
    letterSpacing: AppSizes.letterSpacingTight,
  );

  static const TextStyle brandAccent = TextStyle(
    color: AppColors.primary,
    fontSize: 20,
    fontWeight: FontWeight.w900,
    fontStyle: FontStyle.italic,
    letterSpacing: AppSizes.letterSpacingTight,
  );

  static const TextStyle sectionLabel = TextStyle(
    color: AppColors.primary,
    fontSize: 8,
    fontWeight: FontWeight.w900,
    letterSpacing: AppSizes.letterSpacingWide,
  );

  static const TextStyle segmentTag = TextStyle(
    color: AppColors.primary,
    fontSize: 10,
    fontWeight: FontWeight.w900,
    letterSpacing: AppSizes.letterSpacingLoose,
  );

  static const TextStyle sectionTitle = TextStyle(
    color: AppColors.primary,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );

  static const TextStyle heroTitle = TextStyle(
    color: AppColors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle heroSubtitle = TextStyle(
    color: Color(0xFFFB923C),
    fontSize: 14,
    fontWeight: FontWeight.w500,
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

  static const TextStyle modalTitle = TextStyle(
    color: AppColors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
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
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );

  static const TextStyle dayLabelActive = TextStyle(
    color: AppColors.white,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle dayLabelInactive = TextStyle(
    color: AppColors.gray500,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle chipActive = TextStyle(
    color: AppColors.primary,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );

  static const TextStyle chipInactive = TextStyle(
    color: AppColors.gray500,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );

  static const TextStyle trainingItemTitle = TextStyle(
    color: AppColors.white,
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );

  static const TextStyle trainingDayTag = TextStyle(
    color: AppColors.primary,
    fontSize: 8,
    fontWeight: FontWeight.w900,
  );

  static const TextStyle segmentItemName = TextStyle(
    color: AppColors.gray200,
    fontWeight: FontWeight.bold,
    fontSize: 14,
    letterSpacing: AppSizes.letterSpacingHalf,
  );

  static const TextStyle exerciseItemName = TextStyle(
    color: AppColors.white,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );

  static const TextStyle emptyStateText = TextStyle(
    color: AppColors.gray500,
    fontSize: 14,
  );

  static const TextStyle placeholderCenter = TextStyle(
    color: AppColors.gray600,
    fontSize: 14,
  );

  static const TextStyle smallLabel = TextStyle(
    color: AppColors.gray500,
    fontSize: 10,
    fontWeight: FontWeight.bold,
    letterSpacing: AppSizes.letterSpacingWide,
  );

  static var bodyLg = TextStyle(
    fontSize: 14,
    color: AppColors.gray500,
    fontWeight: FontWeight.w500,
  );
}
