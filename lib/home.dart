import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'routing/app_router.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Metronome'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.goNamed(AppRoute.playground.name),
              child: const Text('Playground'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.goNamed(AppRoute.metronomeSimple.name),
              child: const Text('Metronome Simple'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.goNamed(AppRoute.metronomeExpert.name),
              child: const Text('Metronome Expert'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.goNamed(AppRoute.metronomeList.name),
              child: const Text('Metronome List'),
            ),
          ],
        ),
      ),
    );
  }
}
