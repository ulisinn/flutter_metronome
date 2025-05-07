import 'package:flutter/material.dart';
import '../../models/metronome_config.dart';

class MetronomeConfigCard extends StatelessWidget {
  final MetronomeConfig config;

  const MetronomeConfigCard({
    super.key,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate total beats in the cell sequence
    int totalBeats = config.cellSequence.fold(
      0,
      (sum, cell) => sum + cell.pulses
    );

    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                config.title ?? 'Untitled',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 8.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Chip(
                    label: Text('${config.initialBpm.toInt()} BPM'),
                    backgroundColor: Colors.blue.shade100,
                  ),
                  const SizedBox(width: 8.0),
                  Chip(
                    label: Text('$totalBeats beats'),
                    backgroundColor: Colors.green.shade100,
                  ),
                  if (config.markDownbeat)
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Chip(
                        label: Text('Downbeat'),
                        backgroundColor: Colors.orange,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                'Cell Sequence: ${config.cellSequence.map((cell) => cell.pulses).join(' + ')}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            if (config.useCountdownTimer) ...[
              const SizedBox(height: 8.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  'Timer: ${_formatDuration(config.countdownDurationSeconds)}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
            const SizedBox(height: 8.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Text(
                    'Volume: ',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    'Strong ${(config.strongBeatVolume * 100).toInt()}%',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(' / '),
                  Text(
                    'Weak ${(config.weakBeatVolume * 100).toInt()}%',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
