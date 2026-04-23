import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter/material.dart';

import '../../../shared/index.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  String _getDayName() {
    final now = DateTime.now();
    return weekdayFullNames[now.weekday - 1].split('-')[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.spacing24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: AppSizes.spacing16),
            child: Row(
              children: [
                const Icon(
                  LucideIcons.clock,
                  size: AppSizes.iconSm,
                  color: AppColors.primary,
                ),
                const SizedBox(width: AppSizes.spacing8),
                Text(
                  '${AppStrings.homeSectionTrainingOfDayPrefix}${_getDayName()}',
                  style: AppTextStyles.sectionTitle,
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.radius16),
            child: Container(
              height: AppSizes.heroHeight,
              width: double.infinity,
              color: AppColors.surfaceLight,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(color: AppColors.surfaceLight),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(
                            alpha: AppSizes.backgroundDim,
                          ),
                        ],
                      ),
                    ),
                    child: Opacity(
                      opacity: .8,
                      child: Image.asset(
                        fit: BoxFit.cover,
                        resources.first.gifPath,
                        errorBuilder: (_, __, ___) => Container(
                          color: AppColors.surface,
                          child: const Icon(
                            Icons.image,
                            color: AppColors.gray700,
                            size: AppSizes.iconMd,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const Positioned(
                    bottom: AppSizes.spacing16,
                    left: AppSizes.spacing16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.homeHeroTitle,
                          style: AppTextStyles.heroTitle,
                        ),
                        Text(
                          AppStrings.homeHeroSubtitle,
                          style: AppTextStyles.heroSubtitle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
