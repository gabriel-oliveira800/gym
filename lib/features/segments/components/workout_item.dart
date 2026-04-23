import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../data/database/app_database.dart';

class WorkoutItem extends StatelessWidget {
  final WorkoutsTableData workout;
  final ValueChanged<WorkoutsTableData> onRemove;

  const WorkoutItem({
    super.key,
    required this.workout,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gray700),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              workout.name,
              style: const TextStyle(
                color: AppColors.gray200,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                letterSpacing: 0.5,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          GestureDetector(
            onTap: () => onRemove(workout),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Icon(LucideIcons.trash2, size: 16, color: AppColors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
