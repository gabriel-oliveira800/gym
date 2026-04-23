import 'dart:math';
import 'app_database.dart';
import '../../shared/constants/values.dart';

Future<void> seedDatabase(AppDatabase db) async {
  const chars = '0123456789abcdefghijklmnopqrst';
  final random = Random();

  String generateId() {
    return List.generate(16, (_) => chars[random.nextInt(chars.length)]).join();
  }

  final now = DateTime.now().toIso8601String();

  for (final name in defaultWorkouts) {
    await db.into(db.workoutsTable).insert(
          WorkoutsTableCompanion.insert(
            id: generateId(),
            name: name,
            createdAt: now,
            updatedAt: now,
          ),
        );
  }
}
