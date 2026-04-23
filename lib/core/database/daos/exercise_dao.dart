import 'package:drift/drift.dart';

import '../tables/exercises_table.dart';
import '../tables/workouts_table.dart';
import '../../../shared/index.dart';
import '../app_database.dart';

part 'exercise_dao.g.dart';

@DriftAccessor(tables: [ExercisesTable, WorkoutsTable])
class ExerciseDao extends DatabaseAccessor<AppDatabase> with _$ExerciseDaoMixin {
  ExerciseDao(super.db);

  Future<List<ExercisesTableData>> getAllExercises() {
    return (select(exercisesTable)..orderBy([(t) => OrderingTerm.asc(t.createdAt)])).get();
  }

  Stream<List<ExercisesTableData>> watchAllExercises() {
    return (select(exercisesTable)..orderBy([(t) => OrderingTerm.asc(t.createdAt)])).watch();
  }

  Future<ExercisesTableData> insertExercise({
    required String name,
    required String urlId,
    required String workoutId,
    required String workoutName,
  }) {
    final now = DateTime.now().toIso8601String();
    return into(exercisesTable).insertReturning(
      ExercisesTableCompanion.insert(
        name: name,
        urlId: urlId,
        createdAt: now,
        updatedAt: now,
        workoutId: workoutId,
        id: Helpers.generateId(),
        workoutName: workoutName,
      ),
    );
  }

  Future<int> deleteExercise(String id) {
    return (delete(exercisesTable)..where((t) => t.id.equals(id))).go();
  }
}
