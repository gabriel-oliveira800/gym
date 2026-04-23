import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter/material.dart';

import '../../../shared/index.dart';
import '../../index.dart';

class DetailsHeader extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback confirmAndDelete;
  final TrainingDetailController controller;
  final ValueChanged<TrainingDetailData> joinExercise;
  final ValueChanged<TrainingDetailData> openEditModal;

  const DetailsHeader({
    super.key,
    required this.controller,
    required this.openEditModal,
    required this.confirmAndDelete,
    required this.joinExercise,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.white,
      elevation: 0,
      title: const Text(
        AppStrings.trainingDetailTitle,
        style: AppTextStyles.headerXl,
      ),
      leading: IconButton(
        icon: const Icon(LucideIcons.chevronLeft, color: AppColors.white),
        onPressed: () => AppNavigation.back(),
      ),
      actions: [
        ValueListenableBuilder<DefaultState<TrainingDetailData>>(
          valueListenable: controller,
          builder: (context, state, _) {
            final data = state.dataOrNull;
            return Row(
              children: [
                IconButton(
                  tooltip: AppStrings.trainingDetailEditTooltip,
                  onPressed: data == null ? null : () => joinExercise(data),
                  icon: const Icon(
                    LucideIcons.link,
                    color: AppColors.white,
                    size: AppSizes.iconMd,
                  ),
                ),
                IconButton(
                  tooltip: AppStrings.trainingDetailEditTooltip,
                  onPressed: data == null ? null : () => openEditModal(data),
                  icon: const Icon(
                    LucideIcons.pencil,
                    color: AppColors.white,
                    size: AppSizes.iconMd,
                  ),
                ),
                IconButton(
                  tooltip: AppStrings.trainingDetailDeleteTooltip,
                  onPressed: data == null ? null : confirmAndDelete,
                  icon: const Icon(
                    LucideIcons.trash2,
                    color: AppColors.primary,
                    size: AppSizes.iconMd,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
