import 'package:flutter/material.dart';

import '../data/demo_store.dart';
import '../models/clover_models.dart';
import '../widgets/clover_widgets.dart';

class MealScreen extends StatelessWidget {
  const MealScreen({super.key, required this.store});
  final DemoStore store;

  Future<void> _add(BuildContext context) async {
    final name = await showTextInputDialog(context, title: '식단 기록', label: '먹은 음식');
    if (name == null || name.isEmpty || !context.mounted) return;
    final calories = await showTextInputDialog(context, title: '칼로리', label: '예상 kcal', keyboardType: TextInputType.number);
    final value = int.tryParse(calories ?? '');
    if (value != null) store.addMeal(MealEntry(type: '간식', name: name, calories: value));
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: store,
        builder: (context, _) => ListView(padding: const EdgeInsets.all(20), children: [
          const ScreenHeading(title: '오늘의 식단', subtitle: '완벽함보다 균형 있게 채워가요'),
          CloverCard(child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('섭취 칼로리', style: TextStyle(fontWeight: FontWeight.w700)), Text('${store.totalCalories} / 1,800 kcal', style: const TextStyle(fontWeight: FontWeight.w800))]),
            const SizedBox(height: 14),
            LinearProgressIndicator(value: (store.totalCalories / 1800).clamp(0, 1), minHeight: 10, borderRadius: BorderRadius.circular(8), backgroundColor: const Color(0xFFE6EFE7)),
            const SizedBox(height: 18),
            const Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [_Nutrient('탄수화물', '96g', Color(0xFFFFC66D)), _Nutrient('단백질', '58g', Color(0xFF7DBB8C)), _Nutrient('지방', '31g', Color(0xFF9EA9DD))]),
          ])),
          const SizedBox(height: 20),
          ...store.meals.map((meal) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: CloverCard(child: Row(children: [
                  const CircleAvatar(backgroundColor: Color(0xFFFFEEDB), child: Icon(Icons.restaurant)),
                  const SizedBox(width: 14),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(meal.type, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)), const SizedBox(height: 3), Text(meal.name, style: const TextStyle(fontWeight: FontWeight.w700))])),
                  Text('${meal.calories} kcal', style: const TextStyle(fontWeight: FontWeight.w700)),
                ])),
              )),
          OutlinedButton.icon(onPressed: () => _add(context), icon: const Icon(Icons.add), label: const Text('식단 추가하기')),
        ]),
      );
}

class _Nutrient extends StatelessWidget {
  const _Nutrient(this.label, this.value, this.color);
  final String label;
  final String value;
  final Color color;
  @override
  Widget build(BuildContext context) => Column(children: [Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)), const SizedBox(height: 6), Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)), Text(value, style: const TextStyle(fontWeight: FontWeight.w800))]);
}
