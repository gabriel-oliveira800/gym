import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../shared/index.dart';

class EmptyHome extends StatelessWidget {
  final VoidCallback onCreate;

  const EmptyHome({super.key, required this.onCreate});

  @override
  Widget build(BuildContext context) {
    return Container(
      height:
          MediaQuery.of(context).size.height * AppSizes.emptyListHeightRatio,
      margin: const EdgeInsets.only(top: AppSizes.spacing8),
      padding: const EdgeInsets.all(AppSizes.spacing16),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight.withValues(alpha: AppSizes.softTint),
        borderRadius: BorderRadius.circular(AppSizes.radius16),
        border: Border.all(color: AppColors.gray700),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            LucideIcons.dumbbell,
            size: AppSizes.iconXl,
            color: AppColors.primary,
          ),
          const SizedBox(height: AppSizes.spacing16),
          const Text(
            AppStrings.emptyHomeTitle,
            style: AppTextStyles.exerciseItemName,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSizes.spacing8),
          const Text(
            AppStrings.emptyHomeSubtitle,
            style: AppTextStyles.emptyStateText,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSizes.spacing20),
          SizedBox(
            height: AppSizes.buttonHeight,
            child: ElevatedButton.icon(
              onPressed: onCreate,
              icon: const Icon(
                LucideIcons.plus,
                size: AppSizes.iconMd,
                color: AppColors.white,
              ),
              label: const Text(
                AppStrings.emptyHomeCtaButton,
                style: AppTextStyles.buttonText,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radius8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.spacing20,
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
