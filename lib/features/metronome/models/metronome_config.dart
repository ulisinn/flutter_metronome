// lib/models/metronome_config.dart
import 'package:uuid/uuid.dart';

import '../../../constants/metronome_settings.dart';
import 'cell_config.dart';

class MetronomeConfig {
  final String id;
  final String? title;
  final double initialBpm;
  final List<CellConfig> cellSequence;
  final double strongBeatVolume;
  final double weakBeatVolume;
  final bool useCountdownTimer;
  final int countdownDurationSeconds;
  final bool markDownbeat; // Add this new property

  MetronomeConfig({
    String? id,
    this.title,
    this.initialBpm = 120.0,
    List<CellConfig>? cellSequence,
    this.strongBeatVolume = MetronomeVolume.strongBeatVolume,
    this.weakBeatVolume = MetronomeVolume.weakBeatVolume,
    this.useCountdownTimer = false,
    this.countdownDurationSeconds = 300, // Default 5 minutes
    this.markDownbeat = true, // Default value is true
  }) :
    id = id ?? const Uuid().v4(),
    cellSequence = cellSequence ?? [CellConfig(pulses: 4)];
}
