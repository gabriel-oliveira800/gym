import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../shared/constants/app_sizes.dart';
import '../../../shared/constants/app_strings.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_text_styles.dart';

class TabHeader extends StatelessWidget implements PreferredSizeWidget {
  const TabHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(AppSizes.tabHeaderHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: SafeArea(
        bottom: false,
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppColors.surfaceLight,
                width: AppSizes.borderWidthThin,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.pageHorizontal,
            vertical: AppSizes.spacing16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSizes.spacing8 - 2),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(AppSizes.radius8),
                    ),
                    child: const Icon(
                      LucideIcons.dumbbell,
                      size: AppSizes.iconLg,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(width: AppSizes.spacing8),
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: AppStrings.brandPrefix,
                          style: AppTextStyles.brandText,
                        ),
                        TextSpan(
                          text: AppStrings.brandSuffix,
                          style: AppTextStyles.brandAccent,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.radius20),
                child: Container(
                  width: AppSizes.avatarSize,
                  height: AppSizes.avatarSize,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    border: Border.all(
                      color: AppColors.primary.withValues(
                        alpha: AppSizes.softTint,
                      ),
                      width: AppSizes.borderWidthMedium,
                    ),
                    borderRadius: BorderRadius.circular(AppSizes.radius20),
                  ),
                  child: Image.network(
                    AppStrings.profileImageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.person,
                      color: AppColors.gray500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
