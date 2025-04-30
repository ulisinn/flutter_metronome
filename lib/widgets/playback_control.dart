// Widget for play/stop control
import 'package:flutter/material.dart';

class PlaybackControlWidget extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onToggle;

  const PlaybackControlWidget({
    super.key,
    required this.isPlaying,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: ElevatedButton(
        onPressed: onToggle,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
          backgroundColor: isPlaying ? Colors.red : Colors.green,
        ),
        child: Text(
          isPlaying ? 'Stop' : 'Play',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
