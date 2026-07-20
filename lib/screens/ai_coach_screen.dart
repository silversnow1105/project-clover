import 'package:flutter/material.dart';

import '../data/demo_store.dart';
import '../widgets/clover_widgets.dart';

class AiCoachScreen extends StatelessWidget {
  const AiCoachScreen({super.key, required this.store});
  final DemoStore store;

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: store,
        builder: (context, _) {
          final lost = store.weights.first.kg - store.currentWeight;
          return ListView(padding: const EdgeInsets.all(20), children: [
            const ScreenHeading(title: 'AI Clover Coach', subtitle: '오늘의 기록을 함께 읽어드릴게요'),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF4F9B69), Color(0xFF79BB8D)]), borderRadius: BorderRadius.circular(28)),
              child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('🍀', style: TextStyle(fontSize: 36)),
                SizedBox(height: 14),
                Text('오늘도 잘하고 있어요', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900)),
                SizedBox(height: 8),
                Text('작은 기록들이 모여 건강한 리듬을 만들고 있어요.', style: TextStyle(color: Colors.white, height: 1.5)),
              ]),
            ),
            const SizedBox(height: 18),
            _Insight(icon: Icons.trending_down, title: '체중 흐름', body: '최근 7일 동안 ${lost.toStringAsFixed(1)}kg 감소했어요. 급격하지 않은 안정적인 변화예요.'),
            const SizedBox(height: 12),
            _Insight(icon: Icons.restaurant, title: '식단 밸런스', body: '현재 ${store.totalCalories}kcal를 섭취했어요. 저녁에는 두부, 달걀처럼 가벼운 단백질을 더해보세요.'),
            const SizedBox(height: 12),
            _Insight(icon: Icons.directions_run, title: '활동 리듬', body: '오늘 ${store.exerciseMinutes}분 움직였어요. 수면 회복을 위해 늦은 밤 고강도 운동은 피하는 게 좋아요.'),
            const SizedBox(height: 22),
            Text('오늘의 작은 미션', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 10),
            const CloverCard(child: Row(children: [
              CircleAvatar(backgroundColor: Color(0xFFDDF3F7), child: Icon(Icons.water_drop_outlined)),
              SizedBox(width: 14),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('물 600mL 더 마시기', style: TextStyle(fontWeight: FontWeight.w800)), SizedBox(height: 4), Text('완료하면 오늘의 클로버 잎을 얻어요!')])),
              Icon(Icons.radio_button_unchecked),
            ])),
            const SizedBox(height: 14),
            Text('※ 이 화면의 피드백은 데모용 로컬 규칙으로 생성되며 의료 조언이 아닙니다.', style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
          ]);
        },
      );
}

class _Insight extends StatelessWidget {
  const _Insight({required this.icon, required this.title, required this.body});
  final IconData icon;
  final String title;
  final String body;
  @override
  Widget build(BuildContext context) => CloverCard(child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CircleAvatar(backgroundColor: const Color(0xFFE2F2E5), child: Icon(icon)),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.w800)), const SizedBox(height: 6), Text(body, style: const TextStyle(height: 1.45))])),
      ]));
}
