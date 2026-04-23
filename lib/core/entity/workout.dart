typedef Workouts = List<Workout>;

class Workout {
  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Workout({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });
}
