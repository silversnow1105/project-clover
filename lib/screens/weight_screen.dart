import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../data/demo_store.dart';
import '../widgets/clover_widgets.dart';

class WeightScreen extends StatelessWidget {
  const WeightScreen({super.key, required this.store});
  final DemoStore store;

  Future<void> _add(BuildContext context) async {
    final value = await showTextInputDialog(context, title: '오늘 체중 기록', label: '체중 (kg)', keyboardType: const TextInputType.numberWithOptions(decimal: true));
    final kg = double.tryParse(value ?? '');
    if (kg != null && kg > 20 && kg < 300) store.addWeight(kg);
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: store,
        builder: (context, _) => ListView(padding: const EdgeInsets.all(20), children: [
          const ScreenHeading(title: '체중 기록', subtitle: '숫자보다 꾸준한 흐름을 바라봐요'),
          CloverCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('현재 체중', style: TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text(store.currentWeight.toStringAsFixed(1), style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w900)),
              const Padding(padding: EdgeInsets.only(bottom: 7, left: 5), child: Text('kg')),
              const Spacer(),
              const Chip(label: Text('이번 주 -1.2kg'), avatar: Icon(Icons.south_east, size: 16)),
            ]),
            const SizedBox(height: 24),
            SizedBox(height: 180, width: double.infinity, child: CustomPaint(painter: _WeightChart(store.weights.map((e) => e.kg).toList()))),
            const SizedBox(height: 8),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('6일 전'), Text('오늘')]),
          ])),
          const SizedBox(height: 14),
          Row(children: const [
            Expanded(child: CloverCard(child: _Metric(label: '목표 체중', value: '65.0 kg'))),
            SizedBox(width: 12),
            Expanded(child: CloverCard(child: _Metric(label: '목표까지', value: '2.2 kg'))),
          ]),
          const SizedBox(height: 20),
          FilledButton.icon(onPressed: () => _add(context), icon: const Icon(Icons.add), label: const Text('오늘 체중 기록하기')),
        ]),
      );
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: TextStyle(color: Colors.grey.shade600)), const SizedBox(height: 8), Text(value, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18))]);
}

class _WeightChart extends CustomPainter {
  _WeightChart(this.values);
  final List<double> values;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.length < 2) return;
    final minValue = values.reduce(math.min) - .3;
    final maxValue = values.reduce(math.max) + .3;
    final path = Path();
    for (var i = 0; i < values.length; i++) {
      final x = i * size.width / (values.length - 1);
      final y = size.height - ((values[i] - minValue) / (maxValue - minValue) * size.height);
      i == 0 ? path.moveTo(x, y) : path.lineTo(x, y);
    }
    canvas.drawPath(path, Paint()..color = const Color(0xFF4F9B69)..strokeWidth = 4..style = PaintingStyle.stroke..strokeCap = StrokeCap.round..strokeJoin = StrokeJoin.round);
    for (var i = 0; i < values.length; i++) {
      final x = i * size.width / (values.length - 1);
      final y = size.height - ((values[i] - minValue) / (maxValue - minValue) * size.height);
      canvas.drawCircle(Offset(x, y), 5, Paint()..color = Colors.white);
      canvas.drawCircle(Offset(x, y), 4, Paint()..color = const Color(0xFF4F9B69));
    }
  }

  @override
  bool shouldRepaint(covariant _WeightChart oldDelegate) => oldDelegate.values != values;
}
