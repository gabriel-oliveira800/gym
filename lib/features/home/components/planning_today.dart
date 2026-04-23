import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/components/add_button.dart';

class PlanningToday extends StatelessWidget {
  final VoidCallback onOpenModal;

  const PlanningToday({super.key, required this.onOpenModal});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              Icon(LucideIcons.calendar, size: 18, color: AppColors.primary),
              SizedBox(width: 8),
              Text(
                'PLANO PARA PRÓXIMOS DIAS',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          AddButton(
            icon: LucideIcons.plus,
            onPressed: onOpenModal,
            size: 48,
            iconSize: 20,
          ),
        ],
      ),
    );
  }
}
