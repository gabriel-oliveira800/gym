import 'dart:math';
import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/exercises_table.dart';
import '../tables/workouts_table.dart';

part 'exercise_dao.g.dart';

@DriftAccessor(tables: [ExercisesTable, WorkoutsTable])
class ExerciseDao extends DatabaseAccessor<AppDatabase>
    with _$ExerciseDaoMixin {
  ExerciseDao(super.db);

  String _generateId() {
    const chars = '0123456789abcdefghijklmnopqrst';
    final random = Random();
    return List.generate(16, (_) => chars[random.nextInt(chars.length)]).join();
  }

  Future<List<ExercisesTableData>> getAllExercises() {
    return (select(exercisesTable)
          ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
        .get();
  }

  Stream<List<ExercisesTableData>> watchAllExercises() {
    return (select(exercisesTable)
          ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
        .watch();
  }

  Future<ExercisesTableData> insertExercise({
    required String name,
    required String urlId,
    required String workoutId,
    required String workoutName,
  }) {
    final now = DateTime.now().toIso8601String();
    final id = _generateId();
    return into(exercisesTable)
        .insertReturning(ExercisesTableCompanion.insert(
      id: id,
      name: name,
      urlId: urlId,
      workoutId: workoutId,
      workoutName: workoutName,
      createdAt: now,
      updatedAt: now,
    ));
  }

  Future<int> deleteExercise(String id) {
    return (delete(exercisesTable)..where((t) => t.id.equals(id))).go();
  }
}
