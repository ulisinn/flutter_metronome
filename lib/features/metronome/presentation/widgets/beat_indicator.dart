// Widget for individual beat indicators
import 'package:flutter/material.dart';

class BeatIndicator extends StatelessWidget {
  final bool isActive;
  final bool isStrong;

  const BeatIndicator({
    super.key,
    required this.isActive,
    required this.isStrong,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            isActive
                ? (isStrong ? Colors.red : Colors.green)
                : (isStrong
                    ? Colors.red.withValues(alpha: 0.3)
                    : Colors.green.withValues(alpha: 0.3)),
      ),
    );
  }
}
