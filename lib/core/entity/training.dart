typedef Trainings = List<Training>;

class Training {
  final String id;
  final String name;
  final List<int> weekdays;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Training({
    required this.id,
    required this.name,
    required this.weekdays,
    required this.createdAt,
    required this.updatedAt,
  });

  bool isOnWeekday(int weekday) => weekdays.contains(weekday);
}
