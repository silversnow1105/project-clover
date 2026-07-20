import 'package:flutter/foundation.dart';

import '../models/clover_models.dart';

class DemoStore extends ChangeNotifier {
  final List<WeightEntry> weights = [
    WeightEntry(DateTime.now().subtract(const Duration(days: 6)), 68.4),
    WeightEntry(DateTime.now().subtract(const Duration(days: 5)), 68.1),
    WeightEntry(DateTime.now().subtract(const Duration(days: 4)), 68.2),
    WeightEntry(DateTime.now().subtract(const Duration(days: 3)), 67.8),
    WeightEntry(DateTime.now().subtract(const Duration(days: 2)), 67.6),
    WeightEntry(DateTime.now().subtract(const Duration(days: 1)), 67.4),
    WeightEntry(DateTime.now(), 67.2),
  ];

  final List<MealEntry> meals = [
    MealEntry(type: '아침', name: '그릭요거트와 바나나', calories: 320),
    MealEntry(type: '점심', name: '닭가슴살 포케', calories: 540),
  ];

  final List<ExerciseEntry> exercises = [
    ExerciseEntry(name: '빠르게 걷기', minutes: 35, calories: 180),
  ];

  double get currentWeight => weights.last.kg;
  int get totalCalories => meals.fold(0, (sum, item) => sum + item.calories);
  int get exerciseMinutes => exercises.fold(0, (sum, item) => sum + item.minutes);
  int get burnedCalories => exercises.fold(0, (sum, item) => sum + item.calories);
  double get progress => ((meals.length / 3) + (exerciseMinutes > 0 ? 1 : 0) + 0.72) / 3;

  void addWeight(double kg) {
    weights.add(WeightEntry(DateTime.now(), kg));
    notifyListeners();
  }

  void addMeal(MealEntry meal) {
    meals.add(meal);
    notifyListeners();
  }

  void addExercise(ExerciseEntry exercise) {
    exercises.add(exercise);
    notifyListeners();
  }
}
