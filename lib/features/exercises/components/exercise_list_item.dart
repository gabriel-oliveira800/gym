import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/resources/resources.generated.dart';
import '../../../data/database/app_database.dart';

class ExerciseListItem extends StatelessWidget {
  final ExercisesTableData exercise;
  final ValueChanged<String> onDelete;

  const ExerciseListItem({
    super.key,
    required this.exercise,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final resource = findResourceById(exercise.urlId);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gray700),
      ),
      child: Row(
        children: [
          // Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 64,
              height: 64,
              color: AppColors.surface,
              child: resource != null
                  ? Image.asset(
                      resource.previewPath,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Center(
                        child: Icon(LucideIcons.image,
                            size: 20, color: AppColors.gray700),
                      ),
                    )
                  : const Center(
                      child: Icon(LucideIcons.image,
                          size: 20, color: AppColors.gray700),
                    ),
            ),
          ),
          const SizedBox(width: 16),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.name,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  exercise.workoutName.toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
          // Delete
          GestureDetector(
            onTap: () => onDelete(exercise.id),
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Icon(LucideIcons.trash2, size: 20, color: AppColors.gray600),
            ),
          ),
        ],
      ),
    );
  }
}
