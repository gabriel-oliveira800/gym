import 'package:flutter/material.dart';
import '../../shared/theme/app_colors.dart';
import '../../shared/components/bg_container.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BgContainer(
      child: const Center(
        child: Text(
          'Statistics',
          style: TextStyle(color: AppColors.white, fontSize: 16),
        ),
      ),
    );
  }
}
