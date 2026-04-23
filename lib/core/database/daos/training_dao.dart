import 'package:drift/drift.dart';

import '../../../shared/index.dart';
import '../app_database.dart';
import '../tables/exercises_table.dart';
import '../tables/training_exercises_table.dart';
import '../tables/trainings_table.dart';

part 'training_dao.g.dart';

@DriftAccessor(
  tables: [TrainingsTable, TrainingExercisesTable, ExercisesTable],
)
class TrainingDao extends DatabaseAccessor<AppDatabase> with _$TrainingDaoMixin {
  TrainingDao(super.db);

  Future<List<TrainingsTableData>> getAllTrainings() {
    return (select(trainingsTable)..orderBy([(t) => OrderingTerm.asc(t.createdAt)])).get();
  }

  Future<TrainingsTableData?> getTrainingById(String id) {
    return (select(trainingsTable)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<TrainingsTableData> insertTraining({
    required String name,
    required List<int> weekdays,
    required List<String> exerciseIds,
  }) async {
    final now = DateTime.now().toIso8601String();
    final id = Helpers.generateId();

    final row = await into(trainingsTable).insertReturning(
      TrainingsTableCompanion.insert(
        id: id,
        name: name,
        weekdays: weekdays.join(','),
        createdAt: now,
        updatedAt: now,
      ),
    );

    for (final exId in exerciseIds) {
      await into(trainingExercisesTable).insert(
        TrainingExercisesTableCompanion.insert(
          trainingId: id,
          exerciseId: exId,
          createdAt: now,
        ),
      );
    }

    return row;
  }

  Future<TrainingsTableData> updateTraining({
    required String id,
    required String name,
    required List<int> weekdays,
    required List<String> exerciseIds,
  }) async {
    final now = DateTime.now().toIso8601String();

    await (update(trainingsTable)..where((t) => t.id.equals(id))).write(
      TrainingsTableCompanion(
        name: Value(name),
        weekdays: Value(weekdays.join(',')),
        updatedAt: Value(now),
      ),
    );

    // Recria os vínculos M:N (mais simples e consistente).
    await (delete(trainingExercisesTable)
          ..where((te) => te.trainingId.equals(id)))
        .go();

    for (final exId in exerciseIds) {
      await into(trainingExercisesTable).insert(
        TrainingExercisesTableCompanion.insert(
          trainingId: id,
          exerciseId: exId,
          createdAt: now,
        ),
      );
    }

    return (select(trainingsTable)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<int> deleteTraining(String id) {
    return (delete(trainingsTable)..where((t) => t.id.equals(id))).go();
  }

  Future<List<ExercisesTableData>> getExercisesForTraining(
    String trainingId,
  ) async {
    final links = await (select(trainingExercisesTable)..where((te) => te.trainingId.equals(trainingId))).get();

    final exerciseIds = links.map((l) => l.exerciseId).toSet().toList();
    if (exerciseIds.isEmpty) return const [];

    return (select(exercisesTable)..where((e) => e.id.isIn(exerciseIds))).get();
  }

  Future<List<ExercisesTableData>> getExercisesForWeekday(int weekday) async {
    final allTrainings = await (select(trainingsTable)).get();

    final todayTrainingIds = allTrainings
        .where((t) {
          if (t.weekdays.isEmpty) return false;
          return t.weekdays.toWeekdayList().contains(weekday);
        })
        .map((t) => t.id)
        .toList();

    if (todayTrainingIds.isEmpty) return const [];

    final links = await (select(trainingExercisesTable)..where((te) => te.trainingId.isIn(todayTrainingIds))).get();

    final exerciseIds = links.map((l) => l.exerciseId).toSet().toList();
    if (exerciseIds.isEmpty) return const [];

    return (select(exercisesTable)..where((e) => e.id.isIn(exerciseIds))).get();
  }
}
