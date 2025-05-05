// lib/models/metronome_config.dart
import '../../../constants/constants.dart';
import 'cell_config.dart';

class MetronomeConfig {
  final double initialBpm;
  final List<CellConfig> initialSequence;
  final double strongBeatVolume;
  final double weakBeatVolume;
  final bool useCountdownTimer;
  final int countdownDurationSeconds;

  MetronomeConfig({
    this.initialBpm = 120.0,
    List<CellConfig>? initialSequence,
    this.strongBeatVolume = MetronomeVolume.strongBeatVolume,
    this.weakBeatVolume = MetronomeVolume.weakBeatVolume,
    this.useCountdownTimer = false,
    this.countdownDurationSeconds = 300, // Default 5 minutes
  }) : initialSequence = initialSequence ?? [CellConfig(pulses: 4)];
}
