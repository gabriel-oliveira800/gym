import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter/material.dart';

import '../../core/index.dart';
import '../index.dart';

class ExerciseSelector extends StatelessWidget {
  final Exercises exercises;
  final Set<String> selectedIds;
  final ValueChanged<String> onToggle;

  const ExerciseSelector({
    super.key,
    required this.exercises,
    required this.onToggle,
    required this.selectedIds,
  });

  @override
  Widget build(BuildContext context) {
    if (exercises.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(AppSizes.spacing16),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight.withValues(alpha: AppSizes.softTint),
          borderRadius: BorderRadius.circular(AppSizes.radius12),
          border: Border.all(color: AppColors.gray700),
        ),
        child: const Text(
          AppStrings.trainingExercisesEmpty,
          style: AppTextStyles.placeholderCenter,
          textAlign: TextAlign.center,
        ),
      );
    }

    return Column(
      children: exercises.map((ex) {
        final isSelected = selectedIds.contains(ex.id);
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSizes.spacing8),
          child: GestureDetector(
            onTap: () => onToggle(ex.id),
            child: Container(
              padding: const EdgeInsets.all(AppSizes.spacing12),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryMuted : AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(AppSizes.radius12),
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.gray700,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    isSelected ? LucideIcons.checkCircle2 : LucideIcons.circle,
                    color: isSelected ? AppColors.primary : AppColors.gray500,
                    size: AppSizes.iconMd,
                  ),
                  const SizedBox(width: AppSizes.spacing12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ex.name,
                          style: AppTextStyles.exerciseItemName,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: AppSizes.spacing4),
                        Text(
                          ex.workoutName.toUpperCase(),
                          style: AppTextStyles.segmentTag,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
