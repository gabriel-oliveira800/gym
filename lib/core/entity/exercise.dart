typedef Exercises = List<Exercise>;

class Exercise {
  final String id;
  final String name;
  final String urlId;
  final String workoutId;
  final String workoutName;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Exercise({
    required this.id,
    required this.name,
    required this.urlId,
    required this.workoutId,
    required this.workoutName,
    required this.createdAt,
    required this.updatedAt,
  });
}
