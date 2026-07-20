import 'package:flutter/material.dart';

import 'data/demo_store.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const CloverApp());
}

class CloverApp extends StatefulWidget {
  const CloverApp({super.key});

  @override
  State<CloverApp> createState() => _CloverAppState();
}

class _CloverAppState extends State<CloverApp> {
  final store = DemoStore();

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFF4F9B69);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Project Clover',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.light,
          surface: const Color(0xFFF8FBF8),
        ),
        scaffoldBackgroundColor: const Color(0xFFF8FBF8),
        fontFamilyFallback: const ['Noto Sans KR', 'sans-serif'],
        cardTheme: const CardThemeData(
          elevation: 0,
          color: Colors.white,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFFF1F7F2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: LoginScreen(store: store),
    );
  }
}
