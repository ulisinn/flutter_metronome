import 'dart:math';
import 'package:uuid/uuid.dart';

import '../constants/metronome_settings.dart';
import '../features/metronome/models/cell_config.dart';
import '../features/metronome/models/metronome_config.dart';

// Assuming these classes are defined as shown in the files
class MetronomeVolume {
  static const double strongBeatVolume = 1.0;
  static const double weakBeatVolume = 0.6;
}

void main() {
  final random = Random();

  List<MetronomeConfig> metronomeConfigs = List.generate(25, (index) {
    // Generate random title
    String title = 'Config ${index + 1}';

    // Generate random BPM from the tempo list
    double bpm =
        MetronomeMarkings.mmList[random.nextInt(
          MetronomeMarkings.mmList.length,
        )];

    // Generate random cell sequence with 1-5 cells
    int cellCount = random.nextInt(5) + 1;
    List<CellConfig> cells = List.generate(cellCount, (_) {
      // Generate random pulses between 2 and 9
      int pulses = random.nextInt(8) + 2;
      // Random active state
      bool isActive = random.nextBool();

      return CellConfig(pulses: pulses, isActive: isActive);
    });

    // Random boolean values
    bool useTimer = random.nextBool();
    bool markDownbeat = random.nextBool();

    // Random countdown duration between 30 and 600 seconds
    int countdownDuration = random.nextInt(571) + 30; // 30 to 600

    return MetronomeConfig(
      id: Uuid().v4(),
      title: title,
      initialBpm: bpm,
      cellSequence: cells,
      useCountdownTimer: useTimer,
      countdownDurationSeconds: countdownDuration,
      markDownbeat: markDownbeat,
    );
  });

  print(metronomeConfigs);
  // Print the list of MetronomeConfig objects
  /*  for (int i = 0; i < metronomeConfigs.length; i++) {
    print('Metronome Config #${i + 1}:');
    print(metronomeConfigs[i]);
    print('-----------------------------------');
  }*/
}
