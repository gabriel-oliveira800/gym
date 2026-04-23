import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym/features/tabs/components/tab_header.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../providers/exercise_provider.dart';
import '../../providers/workout_provider.dart';
import 'components/add_exercise_modal.dart';
import '../../shared/components/add_button.dart';
import '../../shared/components/app_header.dart';
import '../../shared/components/bg_container.dart';
import '../../shared/components/bg_loading.dart';
import 'components/exercise_list_item.dart';

class ExercisesScreen extends ConsumerWidget {
  const ExercisesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exercisesAsync = ref.watch(exercisesProvider);
    final workoutsAsync = ref.watch(workoutsProvider);

    final isLoading = exercisesAsync.isLoading || workoutsAsync.isLoading;
    if (isLoading) return const BgLoading();

    final exercises = exercisesAsync.valueOrNull ?? [];
    final workouts = workoutsAsync.valueOrNull ?? [];

    return Scaffold(
      body: BgContainer(
        child: Column(
          children: [
            AppHeader(
              title: 'EXERCÍCIOS',
              trailing: AddButton(
                icon: LucideIcons.plus,
                size: 48,
                iconSize: 24,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    useRootNavigator: true,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => AddExerciseModal(workouts: workouts),
                  );
                },
              ),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: ListView.separated(
                itemCount: exercises.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return ExerciseListItem(
                    exercise: exercises[index],
                    onDelete: (id) {
                      ref.read(exerciseDaoProvider).deleteExercise(id);
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
