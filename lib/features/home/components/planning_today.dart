import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../shared/components/add_button.dart';
import '../../../shared/constants/app_sizes.dart';
import '../../../shared/constants/app_strings.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_text_styles.dart';

class PlanningToday extends StatelessWidget {
  final VoidCallback onOpenModal;

  const PlanningToday({super.key, required this.onOpenModal});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSizes.spacing16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              Icon(
                LucideIcons.calendar,
                size: AppSizes.iconSm,
                color: AppColors.primary,
              ),
              SizedBox(width: AppSizes.spacing8),
              Text(
                AppStrings.homeSectionPlan,
                style: AppTextStyles.sectionTitle,
              ),
            ],
          ),
          AddButton(
            icon: LucideIcons.plus,
            onPressed: onOpenModal,
            size: AppSizes.buttonSizeSmall,
            iconSize: AppSizes.iconMd,
          ),
        ],
      ),
    );
  }
}
