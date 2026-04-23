import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/database/app_database.dart';
import '../data/database/daos/workout_dao.dart';
import 'database_provider.dart';

final workoutDaoProvider = Provider<WorkoutDao>((ref) {
  final db = ref.watch(databaseProvider);
  return db.workoutDao;
});

final workoutsProvider = StreamProvider<List<WorkoutsTableData>>((ref) {
  final dao = ref.watch(workoutDaoProvider);
  return dao.watchAllWorkouts();
});
