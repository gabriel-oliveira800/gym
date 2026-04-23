import 'package:auto_injector/auto_injector.dart';

import '../../features/index.dart';
import '../core/index.dart';

class Binds {
  final AutoInjector _injector;
  Binds._(this._injector);

  factory Binds() => _instance;
  static final Binds _instance = Binds._(AutoInjector());

  bool _committed = false;

  void setup() {
    if (_committed) return;

    _injector.addSingleton<AppDatabase>(AppDatabase.new);

    _injector.addSingleton<WorkoutDao>(() => get<AppDatabase>().workoutDao);
    _injector.addSingleton<ExerciseDao>(() => get<AppDatabase>().exerciseDao);

    _injector.addSingleton<WorkoutRepository>(WorkoutRepository.new);
    _injector.addSingleton<ExerciseRepository>(ExerciseRepository.new);
    _injector.addSingleton<ResourceRepository>(ResourceRepository.new);

    _injector.add<HomeController>(HomeController.new);
    _injector.add<ExercisesController>(ExercisesController.new);
    _injector.add<SegmentsController>(SegmentsController.new);
    _injector.add<StatsController>(StatsController.new);
    _injector.add<TabsController>(TabsController.new);

    _injector.commit();
    _committed = true;
  }

  T get<T extends Object>() => _injector.get<T>();
}
