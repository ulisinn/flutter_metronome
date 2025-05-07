import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../constants/mock_metronomeSettingsList.dart';
import '../widgets/metronome_config_card.dart';

class MetronomeList extends StatelessWidget {
  const MetronomeList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Metronome List'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),  // Navigate back to home
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: mockMetronomeSettingsList.length,
        itemBuilder: (context, index) {
          final config = mockMetronomeSettingsList[index];
          return MetronomeConfigCard(config: config);
        },
      ),
    );
  }
}
