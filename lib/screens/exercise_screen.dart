import 'package:flutter/material.dart';

import '../data/demo_store.dart';
import '../models/clover_models.dart';
import '../widgets/clover_widgets.dart';

class ExerciseScreen extends StatelessWidget {
  const ExerciseScreen({super.key, required this.store});
  final DemoStore store;

  Future<void> _add(BuildContext context) async {
    final name = await showTextInputDialog(context, title: '운동 기록', label: '운동 이름');
    if (name == null || name.isEmpty || !context.mounted) return;
    final minutes = await showTextInputDialog(context, title: '운동 시간', label: '몇 분 운동했나요?', keyboardType: TextInputType.number);
    final value = int.tryParse(minutes ?? '');
    if (value != null) store.addExercise(ExerciseEntry(name: name, minutes: value, calories: value * 5));
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: store,
        builder: (context, _) => ListView(padding: const EdgeInsets.all(20), children: [
          const ScreenHeading(title: '오늘의 운동', subtitle: '몸이 좋아하는 만큼 가볍게 움직여요'),
          Row(children: [
            Expanded(child: CloverCard(child: _Stat(icon: Icons.timer_outlined, value: '${store.exerciseMinutes}분', label: '운동 시간'))),
            const SizedBox(width: 12),
            Expanded(child: CloverCard(child: _Stat(icon: Icons.local_fire_department_outlined, value: '${store.burnedCalories}', label: '소모 kcal'))),
          ]),
          const SizedBox(height: 20),
          ...store.exercises.map((exercise) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: CloverCard(child: Row(children: [
                  const CircleAvatar(backgroundColor: Color(0xFFE5EBFA), child: Icon(Icons.directions_walk)),
                  const SizedBox(width: 14),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(exercise.name, style: const TextStyle(fontWeight: FontWeight.w800)), const SizedBox(height: 4), Text('${exercise.minutes}분 · ${exercise.calories} kcal', style: TextStyle(color: Colors.grey.shade600))])),
                  const Icon(Icons.check_circle, color: Color(0xFF4F9B69)),
                ])),
              )),
          FilledButton.icon(onPressed: () => _add(context), icon: const Icon(Icons.add), label: const Text('운동 기록하기')),
          const SizedBox(height: 16),
          const CloverCard(child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('🌿', style: TextStyle(fontSize: 28)),
            SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('오늘의 추천', style: TextStyle(fontWeight: FontWeight.w800)), SizedBox(height: 6), Text('저녁 식사 후 15분 산책으로 가볍게 하루를 마무리해 보세요.', style: TextStyle(height: 1.45))])),
          ])),
        ]),
      );
}

class _Stat extends StatelessWidget {
  const _Stat({required this.icon, required this.value, required this.label});
  final IconData icon;
  final String value;
  final String label;
  @override
  Widget build(BuildContext context) => Column(children: [Icon(icon, color: const Color(0xFF4F9B69)), const SizedBox(height: 8), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w900)), Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 12))]);
}
