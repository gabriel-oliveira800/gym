import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter/material.dart';

import '../../shared/index.dart';

import 'exercises_controller.dart';
import 'components/index.dart';

class ExercisesScreen extends StatefulWidget {
  const ExercisesScreen({super.key});

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  late final ExercisesController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Binds.get<ExercisesController>()..start();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openAddModal(BuildContext context, ExercisesData data) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddExerciseModal(
        workouts: data.workouts,
        controller: _controller,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StateBuilder<ExercisesData>(
      listenable: _controller,
      success: (context, data) => Scaffold(
        body: BgContainer(
          child: Column(
            children: [
              AppHeader(
                title: AppStrings.exercisesTitle,
                trailing: AddButton(
                  icon: LucideIcons.plus,
                  size: AppSizes.buttonSizeSmall,
                  iconSize: AppSizes.iconLg,
                  onPressed: () => _openAddModal(context, data),
                ),
              ),
              const SizedBox(height: AppSizes.spacing32),
              Expanded(
                child: Visibility(
                  visible: data.exercises.isNotEmpty,
                  replacement: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(LucideIcons.box, size: 64, color: AppColors.gray600),
                      const SizedBox(height: AppSizes.spacing16),
                      Text(AppStrings.noExercises, style: AppTextStyles.bodyLg),
                    ],
                  ),
                  child: ListView.separated(
                    itemCount: data.exercises.length,
                    separatorBuilder: (_, __) => const SizedBox(height: AppSizes.spacing12),
                    itemBuilder: (context, index) {
                      return ExerciseListItem(
                        exercise: data.exercises[index],
                        onDelete: (id) => _controller.deleteExercise(id),
                      );
                    },
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
