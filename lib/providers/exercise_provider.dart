import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/database/app_database.dart';
import '../data/database/daos/exercise_dao.dart';
import 'database_provider.dart';

final exerciseDaoProvider = Provider<ExerciseDao>((ref) {
  final db = ref.watch(databaseProvider);
  return db.exerciseDao;
});

final exercisesProvider =
    StreamProvider<List<ExercisesTableData>>((ref) {
  final dao = ref.watch(exerciseDaoProvider);
  return dao.watchAllExercises();
});
