import 'package:flutter/material.dart';
import 'package:flutter_metronome/routing/app_router.dart';

void main() {
  runApp(const MetronomeApp());
}

class MetronomeApp extends StatelessWidget {
  const MetronomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Custom Metronome',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      routerConfig: goRouter,
    );
  }
}
