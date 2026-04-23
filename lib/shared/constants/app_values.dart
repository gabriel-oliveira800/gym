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

class DayOfWeek {
  final String label;
  final String value;
  const DayOfWeek(this.label, this.value);
}

const List<DayOfWeek> daysOfWeek = [
  DayOfWeek('Dom', 'dom'),
  DayOfWeek('Seg', 'seg'),
  DayOfWeek('Ter', 'ter'),
  DayOfWeek('Qua', 'qua'),
  DayOfWeek('Qui', 'qui'),
  DayOfWeek('Sex', 'sex'),
  DayOfWeek('Sáb', 'sab'),
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
