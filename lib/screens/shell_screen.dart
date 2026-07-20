import 'package:flutter/material.dart';

import '../data/demo_store.dart';
import 'ai_coach_screen.dart';
import 'exercise_screen.dart';
import 'home_screen.dart';
import 'meal_screen.dart';
import 'weight_screen.dart';

class ShellScreen extends StatefulWidget {
  const ShellScreen({super.key, required this.store});
  final DemoStore store;

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(store: widget.store, onNavigate: (index) => setState(() => selected = index)),
      WeightScreen(store: widget.store),
      MealScreen(store: widget.store),
      ExerciseScreen(store: widget.store),
      AiCoachScreen(store: widget.store),
    ];
    return Scaffold(
      body: SafeArea(child: IndexedStack(index: selected, children: pages)),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selected,
        onDestinationSelected: (value) => setState(() => selected = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: '홈'),
          NavigationDestination(icon: Icon(Icons.monitor_weight_outlined), label: '체중'),
          NavigationDestination(icon: Icon(Icons.restaurant_outlined), label: '식단'),
          NavigationDestination(icon: Icon(Icons.directions_run_outlined), label: '운동'),
          NavigationDestination(icon: Icon(Icons.auto_awesome_outlined), label: 'AI'),
        ],
      ),
    );
  }
}
