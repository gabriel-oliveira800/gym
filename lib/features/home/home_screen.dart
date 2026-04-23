import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../providers/workout_provider.dart';
import '../../shared/components/bg_container.dart';
import '../../shared/components/bg_loading.dart';

import 'components/home_header.dart';
import 'components/planning_today.dart';
import 'components/training_list.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workoutsAsync = ref.watch(workoutsProvider);

    return workoutsAsync.when(
      loading: () => const BgLoading(),
      error: (err, _) => BgContainer(
        child: Center(
          child: Text('Erro: $err', style: const TextStyle(color: Colors.white)),
        ),
      ),
      data: (workouts) => BgContainer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeHeader(),
              PlanningToday(onOpenModal: () {}),
              const SizedBox(height: 8),
              TrainingList(training: const ['Treino 1', 'Treino 2', 'Treino 3']),
            ],
          ),
        ),
      ),
    );
  }
}
