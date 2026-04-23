import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter/material.dart';

import '../../../core/index.dart';
import '../../../shared/index.dart';

class ExerciseListItem extends StatelessWidget {
  final Exercise exercise;
  final ValueChanged<String> onDelete;

  const ExerciseListItem({
    super.key,
    required this.exercise,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final resource = Binds().get<ResourceRepository>().findByIdOrNull(exercise.urlId);

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
                      resource.previewPath,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Center(
                        child: Icon(
                          LucideIcons.image,
                          size: AppSizes.iconMd,
                          color: AppColors.gray700,
                        ),
                      ),
                    )
                  : const Center(
                      child: Icon(
                        LucideIcons.image,
                        size: AppSizes.iconMd,
                        color: AppColors.gray700,
                      ),
                    ),
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
          GestureDetector(
            onTap: () => onDelete(exercise.id),
            child: const Padding(
              padding: EdgeInsets.all(AppSizes.spacing8),
              child: Icon(
                LucideIcons.trash2,
                size: AppSizes.iconMd,
                color: AppColors.gray600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
