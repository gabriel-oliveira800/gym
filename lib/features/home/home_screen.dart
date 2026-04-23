import 'package:flutter/material.dart';

import '../../core/index.dart';
import '../../shared/index.dart';
import 'components/index.dart';
import 'home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Binds.get<HomeController>()..start();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openAddTrainingModal(Exercises exercises) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddTrainingModal(
        exercises: exercises,
        onSave: _controller.createTraining,
      ),
    );
  }

  void _onTrainingTap(Training training) {
    AppNavigation.toTrainingDetail(training.id);
  }

  void _handleRefresh() {
    // final refresh = GoRouterState.of(context).uri.queryParameters['refresh'];
    // if (refresh ?? false) _controller.load();
  }

  @override
  Widget build(BuildContext context) {
    _handleRefresh();

    return StateBuilder<HomeData>(
      listenable: _controller,
      success: (context, data) {
        return BgContainer(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TrainingExerciseCarousel(
                  exercises: data.todayExercises,
                  builder: (context, resource, title, subtitle) => HomeHeader(
                    resource: resource,
                    title: title,
                    subtitle: subtitle,
                  ),
                ),
                PlanningToday(
                  hasTraining: data.trainings.isNotEmpty,
                  onOpenModal: () => _openAddTrainingModal(data.allExercises),
                ),
                const SizedBox(height: AppSizes.spacing8),
                if (data.trainings.isEmpty)
                  EmptyHome(
                    onCreate: () => _openAddTrainingModal(data.allExercises),
                  )
                else
                  TrainingList(
                    trainings: data.trainings,
                    onTap: _onTrainingTap,
                  ),
                const SizedBox(height: AppSizes.spacing24),
              ],
            ),
          ),
        );
      },
    );
  }
}
