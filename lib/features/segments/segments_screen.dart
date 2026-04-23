import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter/material.dart';

import '../../providers/workout_provider.dart';

import '../../shared/index.dart';

import 'components/workout_item.dart';

class SegmentsScreen extends ConsumerStatefulWidget {
  const SegmentsScreen({super.key});

  @override
  ConsumerState<SegmentsScreen> createState() => _SegmentsScreenState();
}

class _SegmentsScreenState extends ConsumerState<SegmentsScreen> {
  final _controller = TextEditingController();

  Future<void> _addWorkout() async {
    final name = _controller.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('O nome do segmento não pode ser vazio'),
        ),
      );
      return;
    }
    await ref.read(workoutDaoProvider).insertWorkout(name);
    _controller.clear();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final workoutsAsync = ref.watch(workoutsProvider);

    return workoutsAsync.when(
      loading: () => const BgLoading(),
      error: (err, _) => BgContainer(
        child: Center(
          child: Text('Erro: $err', style: const TextStyle(color: Colors.white)),
        ),
      ),
      data: (workouts) => BgContainer(
        child: Column(
          children: [
            AppHeader(
              title: 'Segmentos',
              icon: LucideIcons.layoutGrid,
            ),
            const SizedBox(height: 8),
            InputWithButton(
              placeholder: 'Nome do segmento',
              controller: _controller,
              onSend: _addWorkout,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 130 / 60,
                ),
                itemCount: workouts.length,
                itemBuilder: (context, index) {
                  return WorkoutItem(
                    workout: workouts[index],
                    onRemove: (workout) {
                      ref.read(workoutDaoProvider).deleteWorkout(workout.id);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
