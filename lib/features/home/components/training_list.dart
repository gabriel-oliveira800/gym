import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/index.dart';
import '../../../shared/index.dart';

class TrainingList extends StatelessWidget {
  final Trainings trainings;
  final ValueChanged<Training> onTap;

  const TrainingList({
    super.key,
    required this.trainings,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: trainings.map((training) {
        return Padding(
          padding: const EdgeInsets.only(top: AppSizes.spacing16),
          child: Material(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(AppSizes.radius12),
            child: InkWell(
              onTap: () => onTap(training),
              borderRadius: BorderRadius.circular(AppSizes.radius12),
              child: Container(
                height: AppSizes.trainingItemHeight,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.spacing16,
                ),
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
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            training.name,
                            style: AppTextStyles.trainingItemTitle,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: AppSizes.spacing8),
                          Row(
                            children: _sortedLabels(training.weekdays)
                                .map(_buildDayTag)
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: AppSizes.chevronCircle,
                      height: AppSizes.chevronCircle,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceLight.withValues(
                          alpha: AppSizes.softTint,
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.gray700),
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

  List<String> _sortedLabels(List<int> weekdays) {
    final sorted = [...weekdays]..sort();
    return sorted.map(weekdayShortLabel).where((s) => s.isNotEmpty).toList();
  }

  Widget _buildDayTag(String label) {
    return Padding(
      padding: const EdgeInsets.only(right: AppSizes.spacing4),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.spacing8,
          vertical: AppSizes.spacing2,
        ),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: AppSizes.softTintMin),
          borderRadius: BorderRadius.circular(AppSizes.radius100),
        ),
        child: Text(
          label.toUpperCase(),
          style: AppTextStyles.trainingDayTag,
        ),
      ),
    );
  }
}
