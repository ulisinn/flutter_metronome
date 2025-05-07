
// Widget for visualizing the current beat
import 'package:flutter/material.dart';

import '../../models/cell_config.dart';
import '../widgets/beat_indicator.dart';

class BeatVisualizerWidget extends StatelessWidget {
  final CellConfig currentCell;
  final int currentPulse;

  const BeatVisualizerWidget({
    super.key,
    required this.currentCell,
    required this.currentPulse,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          currentCell.pulses,
              (index) => BeatIndicator(
            isActive: index == currentPulse && currentPulse >= 0,
            isStrong: index == 0,
          ),
        ),
      ),
    );
  }
}
