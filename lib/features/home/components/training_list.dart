import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../shared/constants/app_sizes.dart';
import '../../../shared/constants/app_strings.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_text_styles.dart';

class TrainingList extends StatelessWidget {
  final List<String> training;

  const TrainingList({super.key, required this.training});

  @override
  Widget build(BuildContext context) {
    if (training.isEmpty) {
      return Container(
        height: MediaQuery.of(context).size.height *
            AppSizes.emptyListHeightRatio,
        margin: const EdgeInsets.only(top: AppSizes.spacing8),
        decoration: BoxDecoration(
          color:
              AppColors.surfaceLight.withValues(alpha: AppSizes.softTint),
          borderRadius: BorderRadius.circular(AppSizes.radius16),
          border: Border.all(
            color: AppColors.gray700,
            style: BorderStyle.solid,
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                LucideIcons.dumbbell,
                size: AppSizes.iconXl,
                color: AppColors.primary,
              ),
              SizedBox(height: AppSizes.spacing16),
              Text(
                AppStrings.homeEmptyTraining,
                style: AppTextStyles.emptyStateText,
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: training.map((item) {
        return Padding(
          padding: const EdgeInsets.only(top: AppSizes.spacing16),
          child: Material(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(AppSizes.radius12),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(AppSizes.radius12),
              child: Container(
                height: AppSizes.trainingItemHeight,
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.spacing16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.radius12),
                  border: const Border(
                    left: BorderSide(
                      color: AppColors.primary,
                      width: AppSizes.borderWidthAccent,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item, style: AppTextStyles.trainingItemTitle),
                        const SizedBox(height: AppSizes.spacing8),
                        Row(
                          children: AppSizes.defaultTrainingDays.map((day) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  right: AppSizes.spacing4),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSizes.spacing8,
                                  vertical: AppSizes.spacing2,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(
                                    alpha: AppSizes.softTintMin,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      AppSizes.radius100),
                                ),
                                child: Text(
                                  day.toUpperCase(),
                                  style: AppTextStyles.trainingDayTag,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    Container(
                      width: AppSizes.chevronCircle,
                      height: AppSizes.chevronCircle,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceLight.withValues(
                          alpha: AppSizes.softTint,
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.gray700,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          LucideIcons.chevronRight,
                          size: AppSizes.iconMd,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
