const List<String> defaultWorkouts = [
  'Antebraço',
  'Abdômen',
  'Aeróbico',
  'Bíceps',
  'Dorsal',
  'Deltoides',
  'Glúteo',
  'Panturrilha',
  'Peitoral',
  'Posterior de coxa',
  'Quadríceps',
  'Trapézio',
  'Tríceps',
];

/// Dias da semana alinhados com [DateTime.weekday]:
/// segunda=1, terça=2, quarta=3, quinta=4, sexta=5, sábado=6, domingo=7.
class DayOfWeek {
  final String label;
  final int value;
  const DayOfWeek(this.label, this.value);
}

const List<DayOfWeek> daysOfWeek = [
  DayOfWeek('Seg', 1),
  DayOfWeek('Ter', 2),
  DayOfWeek('Qua', 3),
  DayOfWeek('Qui', 4),
  DayOfWeek('Sex', 5),
  DayOfWeek('Sáb', 6),
  DayOfWeek('Dom', 7),
];

const List<String> weekdayFullNames = [
  'segunda-feira',
  'terça-feira',
  'quarta-feira',
  'quinta-feira',
  'sexta-feira',
  'sábado',
  'domingo',
];

String weekdayShortLabel(int weekday) {
  final match = daysOfWeek.where((d) => d.value == weekday);
  if (match.isEmpty) return '';
  return match.first.label;
}
