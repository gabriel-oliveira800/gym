import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'tables/workouts_table.dart';
import 'tables/exercises_table.dart';
import 'daos/workout_dao.dart';
import 'daos/exercise_dao.dart';
import 'seed.dart';

part 'app_database.g.dart';

@DriftDatabase(
  daos: [WorkoutDao, ExerciseDao],
  tables: [WorkoutsTable, ExercisesTable], 
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'gym_app',
      native: DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await seedDatabase(this);
        },
      );
}
