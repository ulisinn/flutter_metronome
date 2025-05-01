import '../constants/constants.dart';
import 'cell_config.dart';

class MetronomeConfig {
  final double initialBpm;
  final List<CellConfig> initialSequence;
  final double strongBeatVolume;
  final double weakBeatVolume;

  MetronomeConfig({
    this.initialBpm = 120.0,
    List<CellConfig>? initialSequence,
    this.strongBeatVolume = MetronomeVolume.strongBeatVolume,
    this.weakBeatVolume = MetronomeVolume.weakBeatVolume,
  }) : initialSequence = initialSequence ?? [CellConfig(pulses: 4)];
}
