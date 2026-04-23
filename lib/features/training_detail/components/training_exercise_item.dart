import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/index.dart';
import '../../../shared/index.dart';

class TrainingExerciseItem extends StatelessWidget {
  final Exercise exercise;
  final ResourceField? resource;

  const TrainingExerciseItem({
    super.key,
    required this.exercise,
    required this.resource,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.spacing12),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(AppSizes.radius16),
        border: Border.all(color: AppColors.gray700),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.radius12),
            child: Container(
              width: AppSizes.thumbnailSize,
              height: AppSizes.thumbnailSize,
              color: AppColors.surface,
              child: resource != null
                  ? Image.asset(
                      resource!.previewPath,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const _FallbackIcon(),
                    )
                  : const _FallbackIcon(),
            ),
          ),
          const SizedBox(width: AppSizes.spacing16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(exercise.name, style: AppTextStyles.exerciseItemName),
                const SizedBox(height: AppSizes.spacing4),
                Text(
                  exercise.workoutName.toUpperCase(),
                  style: AppTextStyles.segmentTag,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FallbackIcon extends StatelessWidget {
  const _FallbackIcon();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(
        LucideIcons.image,
        size: AppSizes.iconMd,
        color: AppColors.gray700,
      ),
    );
  }
}
