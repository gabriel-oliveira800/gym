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
    _controller = Binds().get<HomeController>()..start();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StateBuilder<Workouts>(
      listenable: _controller,
      success: (context, workouts) => BgContainer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeHeader(),
              PlanningToday(onOpenModal: () {}),
              const SizedBox(height: AppSizes.spacing8),
              const TrainingList(
                training: ['Treino 1', 'Treino 2', 'Treino 3'],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
