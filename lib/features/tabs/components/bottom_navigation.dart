import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../shared/constants/app_sizes.dart';
import '../../../shared/constants/app_strings.dart';
import '../../../shared/theme/app_colors.dart';

class BottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const BottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    const top = BorderSide(
      color: AppColors.surfaceLight,
      width: AppSizes.borderWidthThin,
    );

    return Container(
      decoration: const BoxDecoration(border: Border(top: top)),
      child: BottomNavigationBar(
        onTap: onItemSelected,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.tabBarBg,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.gray500,
        items: const [
          BottomNavigationBarItem(
            label: AppStrings.tabHome,
            icon: Icon(LucideIcons.home),
          ),
          BottomNavigationBarItem(
            label: AppStrings.tabExercises,
            icon: Icon(LucideIcons.dumbbell),
          ),
          BottomNavigationBarItem(
            label: AppStrings.tabSegments,
            icon: Icon(LucideIcons.layoutGrid),
          ),
          BottomNavigationBarItem(
            label: AppStrings.tabStats,
            icon: Icon(LucideIcons.barChart3),
          ),
        ],
      ),
    );
  }
}
