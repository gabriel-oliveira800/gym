import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../shared/index.dart';

class HomeHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final ResourceField resource;

  const HomeHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.resource,
  });

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
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        child: SizedBox(
                          width: double.infinity,
                          child: Image.asset(
                            resource.gifPath,
                            fit: BoxFit.cover,
                            key: ValueKey(resource.id),
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
                    ),
                  ),
                  Positioned(
                    bottom: AppSizes.spacing16,
                    left: AppSizes.spacing16,
                    right: AppSizes.spacing16,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          key: ValueKey('${resource.id}-$title-$subtitle'),
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: AppTextStyles.heroTitle,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              subtitle,
                              style: AppTextStyles.heroSubtitle,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
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
