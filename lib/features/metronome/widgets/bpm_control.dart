
// Widget for BPM control
import 'package:flutter/material.dart';

class BpmControlWidget extends StatelessWidget {
  final double bpm;
  final Function(double) onChanged;

  const BpmControlWidget({super.key, required this.bpm, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Text('BPM:', style: TextStyle(fontSize: 18)),
          Expanded(
            child: Slider(
              value: bpm,
              min: 40,
              max: 240,
              divisions: 200,
              label: bpm.round().toString(),
              onChanged: onChanged,
            ),
          ),
          Text('${bpm.round()}', style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
