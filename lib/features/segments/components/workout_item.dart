import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter/material.dart';

import '../../../core/entity/workout.dart';
import '../../../shared/index.dart';

class WorkoutItem extends StatelessWidget {
  final Workout workout;
  final ValueChanged<Workout> onRemove;

  const WorkoutItem({
    super.key,
    required this.workout,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.spacing16),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(AppSizes.radius16),
        border: Border.all(color: AppColors.gray700),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              workout.name,
              style: AppTextStyles.segmentItemName,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          GestureDetector(
            onTap: () => onRemove(workout),
            child: Container(
              width: AppSizes.iconButtonSize,
              height: AppSizes.iconButtonSize,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(AppSizes.radius8),
              ),
              child: const Center(
                child: Icon(
                  LucideIcons.trash2,
                  size: AppSizes.iconXs,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
