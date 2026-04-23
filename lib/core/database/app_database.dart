import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'tables/index.dart';
import 'daos/index.dart';
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

  static const _name = 'gym_app';

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: _name,
      native: DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
        await seedDatabase(this);
      },
    );
  }
}
