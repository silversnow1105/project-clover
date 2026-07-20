class WeightEntry {
  WeightEntry(this.date, this.kg);
  final DateTime date;
  final double kg;
}

class MealEntry {
  MealEntry({required this.type, required this.name, required this.calories});
  final String type;
  final String name;
  final int calories;
}

class ExerciseEntry {
  ExerciseEntry({required this.name, required this.minutes, required this.calories});
  final String name;
  final int minutes;
  final int calories;
}
