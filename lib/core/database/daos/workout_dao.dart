import 'package:drift/drift.dart';
import '../tables/workouts_table.dart';
import '../app_database.dart';

import '../../../shared/index.dart';

part 'workout_dao.g.dart';

@DriftAccessor(tables: [WorkoutsTable])
class WorkoutDao extends DatabaseAccessor<AppDatabase> with _$WorkoutDaoMixin {
  WorkoutDao(super.db);

  Future<List<WorkoutsTableData>> getAllWorkouts() {
    return (select(workoutsTable)..orderBy([(t) => OrderingTerm.asc(t.name)])).get();
  }

  Stream<List<WorkoutsTableData>> watchAllWorkouts() {
    return (select(workoutsTable)..orderBy([(t) => OrderingTerm.asc(t.name)])).watch();
  }

  Future<WorkoutsTableData> insertWorkout(String name) {
    final now = DateTime.now().toIso8601String();
    return into(workoutsTable).insertReturning(
      WorkoutsTableCompanion.insert(
        name: name,
        createdAt: now,
        updatedAt: now,
        id: Helpers.generateId(),
      ),
    );
  }

  Future<int> deleteWorkout(String id) {
    return (delete(workoutsTable)..where((t) => t.id.equals(id))).go();
  }

  Future<bool> workoutExists(String name) async {
    final result = await (select(workoutsTable)..where((t) => t.name.equals(name))).get();
    return result.isNotEmpty;
  }
}
