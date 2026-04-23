import 'package:flutter/material.dart';

import '../../shared/index.dart';
import 'stats_controller.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  // ignore: unused_field
  final StatsController _controller = Binds().get<StatsController>();

  @override
  Widget build(BuildContext context) {
    return const BgContainer(
      child: Center(
        child: Text(
          AppStrings.statsPlaceholder,
          style: TextStyle(color: AppColors.white, fontSize: 16),
        ),
      ),
    );
  }
}
