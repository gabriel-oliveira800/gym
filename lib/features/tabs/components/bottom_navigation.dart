import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter/material.dart';

import '../../../shared/index.dart';

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
    final top = const BorderSide(color: AppColors.surfaceLight, width: 1);

    return Container(
      decoration: BoxDecoration(border: Border(top: top)),
      child: BottomNavigationBar(
        onTap: onItemSelected,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.tabBarBg,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.gray500,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(LucideIcons.home),
          ),
          BottomNavigationBarItem(
            label: 'Exercícios',
            icon: Icon(LucideIcons.dumbbell),
          ),
          BottomNavigationBarItem(
            label: 'Segmentos',
            icon: Icon(LucideIcons.layoutGrid),
          ),
          BottomNavigationBarItem(
            label: 'Estatísticas',
            icon: Icon(LucideIcons.barChart3),
          ),
        ],
      ),
    );
  }
}
