import 'package:flutter/material.dart';

import '../data/demo_store.dart';
import '../widgets/clover_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.store, required this.onNavigate});
  final DemoStore store;
  final ValueChanged<int> onNavigate;

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: store,
        builder: (context, _) => ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('좋은 아침이에요 👋', style: TextStyle(color: Colors.grey.shade600)),
                const SizedBox(height: 4),
                Text('오늘도 천천히 자라볼까요?', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
              ]),
              const CircleAvatar(backgroundColor: Color(0xFFE2F2E5), child: Text('🌱')),
            ]),
            const SizedBox(height: 24),
            CloverCard(
              child: Row(children: [
                SizedBox(width: 76, height: 76, child: Stack(fit: StackFit.expand, children: [
                  CircularProgressIndicator(value: store.progress, strokeWidth: 8, backgroundColor: const Color(0xFFE5EFE7)),
                  Center(child: Text('${(store.progress * 100).round()}%', style: const TextStyle(fontWeight: FontWeight.w800))),
                ])),
                const SizedBox(width: 18),
                const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('오늘의 성장', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
                  SizedBox(height: 6),
                  Text('아주 좋아요! 운동까지 완료해서\n클로버 잎이 하나 더 자랐어요 🍀', style: TextStyle(height: 1.45)),
                ])),
              ]),
            ),
            const SizedBox(height: 14),
            InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () => onNavigate(4),
              child: const CloverCard(child: Row(children: [
                CircleAvatar(backgroundColor: Color(0xFFE2F2E5), child: Icon(Icons.auto_awesome)),
                SizedBox(width: 14),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('AI 오늘의 한마디', style: TextStyle(fontWeight: FontWeight.w800)),
                  SizedBox(height: 5),
                  Text('체중 흐름이 안정적이에요. 오늘은 단백질을 조금 더 챙겨보세요.'),
                ])),
                Icon(Icons.chevron_right),
              ])),
            ),
            const SizedBox(height: 24),
            Text('오늘 한눈에 보기', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.18,
              children: [
                _Summary(icon: Icons.monitor_weight_outlined, label: '체중', value: '${store.currentWeight.toStringAsFixed(1)} kg', color: const Color(0xFFDFF1E4), onTap: () => onNavigate(1)),
                _Summary(icon: Icons.restaurant_outlined, label: '식단', value: '${store.totalCalories} kcal', color: const Color(0xFFFFEEDB), onTap: () => onNavigate(2)),
                _Summary(icon: Icons.directions_run_outlined, label: '운동', value: '${store.exerciseMinutes}분', color: const Color(0xFFE5EBFA), onTap: () => onNavigate(3)),
                const _Summary(icon: Icons.water_drop_outlined, label: '물', value: '1.4 / 2.0 L', color: Color(0xFFDDF3F7)),
              ],
            ),
          ],
        ),
      );
}

class _Summary extends StatelessWidget {
  const _Summary({required this.icon, required this.label, required this.value, required this.color, this.onTap});
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: CloverCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CircleAvatar(backgroundColor: color, child: Icon(icon, size: 21)),
          const Spacer(),
          Text(label, style: TextStyle(color: Colors.grey.shade600)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
        ])),
      );
}
