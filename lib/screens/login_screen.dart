import 'package:flutter/material.dart';

import '../data/demo_store.dart';
import 'shell_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key, required this.store});
  final DemoStore store;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(28),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(children: [
                  Container(
                    width: 108,
                    height: 108,
                    decoration: const BoxDecoration(color: Color(0xFFE2F2E5), shape: BoxShape.circle),
                    child: const Center(child: Text('🍀', style: TextStyle(fontSize: 58))),
                  ),
                  const SizedBox(height: 28),
                  Text('Project Clover', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900)),
                  const SizedBox(height: 10),
                  Text('하루의 작은 기록이\n나만의 정원으로 자라나요', textAlign: TextAlign.center, style: TextStyle(height: 1.5, color: Colors.grey.shade600, fontSize: 16)),
                  const SizedBox(height: 42),
                  TextField(decoration: const InputDecoration(labelText: '이메일', prefixIcon: Icon(Icons.mail_outline))),
                  const SizedBox(height: 14),
                  TextField(obscureText: true, decoration: const InputDecoration(labelText: '비밀번호', prefixIcon: Icon(Icons.lock_outline))),
                  const SizedBox(height: 22),
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: FilledButton(
                      onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ShellScreen(store: store))),
                      child: const Text('데모로 시작하기', style: TextStyle(fontWeight: FontWeight.w700)),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text('회원가입 없이 로컬 데모를 바로 체험할 수 있어요', style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
                ]),
              ),
            ),
          ),
        ),
      );
}
