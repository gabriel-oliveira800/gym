import '../../shared/index.dart';
import 'app_database.dart';

Future<void> seedDatabase(AppDatabase db) async {
  final now = DateTime.now().toIso8601String();

  for (final name in defaultWorkouts) {
    final dto = WorkoutsTableCompanion.insert(
      name: name,
      createdAt: now,
      updatedAt: now,
      id: Helpers.generateId(),
    );
    await db.into(db.workoutsTable).insert(dto);
  }
}
