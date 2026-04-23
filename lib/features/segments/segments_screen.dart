import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter/material.dart';

import '../../core/entity/workout.dart';
import '../../shared/index.dart';

import 'components/workout_item.dart';
import 'segments_controller.dart';

class SegmentsScreen extends StatefulWidget {
  const SegmentsScreen({super.key});

  @override
  State<SegmentsScreen> createState() => _SegmentsScreenState();
}

class _SegmentsScreenState extends State<SegmentsScreen> {
  final SegmentsController _controller = Binds.get<SegmentsController>();
  final TextEditingController _input = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.start();
  }

  @override
  void dispose() {
    _input.dispose();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _addWorkout() async {
    final result = await _controller.createWorkout(_input.text);
    if (!mounted) return;
    result.fold(
      onSuccess: (_) => _input.clear(),
      onFailure: (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(failure.message)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StateBuilder<Workouts>(
      listenable: _controller,
      success: (context, workouts) => BgContainer(
        child: Column(
          children: [
            const AppHeader(
              title: AppStrings.segmentsTitle,
              icon: LucideIcons.layoutGrid,
            ),
            const SizedBox(height: AppSizes.spacing8),
            InputWithButton(
              placeholder: AppStrings.segmentsPlaceholder,
              controller: _input,
              onSend: _addWorkout,
            ),
            const SizedBox(height: AppSizes.spacing16),
            Expanded(
              child: Visibility(
                visible: workouts.isNotEmpty,
                replacement: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(LucideIcons.box, size: 64, color: AppColors.gray600),
                    const SizedBox(height: AppSizes.spacing16),
                    Text(AppStrings.noWorkouts, style: AppTextStyles.bodyLg),
                  ],
                ),
                child: GridView.builder(
                  itemCount: workouts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: AppSizes.segmentsGridColumns,
                    mainAxisSpacing: AppSizes.spacing12,
                    crossAxisSpacing: AppSizes.spacing12,
                    childAspectRatio: AppSizes.segmentsGridAspect,
                  ),
                  itemBuilder: (context, index) {
                    return WorkoutItem(
                      workout: workouts[index],
                      onRemove: (workout) => _controller.deleteWorkout(workout.id),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
