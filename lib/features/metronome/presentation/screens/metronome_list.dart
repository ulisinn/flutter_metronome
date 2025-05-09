import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/metronome_repository.dart';
import '../../../../constants/mock_metronomeSettingsList.dart';

import '../widgets/metronome_config_card.dart';

class MetronomeList extends StatelessWidget {
  const MetronomeList({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = MetronomeRepository(mockMetronomeSettingsList);
    final configs = repository.getAllMetronomeConfigs();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Metronome List'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'), // Navigate back to home
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: configs.length,
        itemBuilder: (context, index) {
          final config = configs[index];
          return MetronomeConfigCard(config: config);
        },
      ),
    );
  }
}
