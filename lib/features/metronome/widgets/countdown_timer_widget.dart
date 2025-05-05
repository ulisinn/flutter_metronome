// lib/widgets/countdown_timer_widget.dart
import 'package:flutter/material.dart';

import '../../../constants/metronome_settings.dart';

class CountdownTimerWidget extends StatefulWidget {
  final bool isEnabled;
  final int remainingSeconds;
  final int totalDuration;
  final Function(bool) onEnabledChanged;
  final Function(int) onDurationChanged;

  const CountdownTimerWidget({
    super.key,
    required this.isEnabled,
    required this.remainingSeconds,
    required this.totalDuration,
    required this.onEnabledChanged,
    required this.onDurationChanged,
  });

  @override
  State<CountdownTimerWidget> createState() => _CountdownTimerWidgetState();
}

class _CountdownTimerWidgetState extends State<CountdownTimerWidget> {
  late int _minutes;
  late int _seconds;

  @override
  void initState() {
    super.initState();
    _updateTimeValues();
  }

  @override
  void didUpdateWidget(CountdownTimerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.totalDuration != widget.totalDuration) {
      _updateTimeValues();
    }
  }

  void _updateTimeValues() {
    _minutes = widget.totalDuration ~/ 60;
    _seconds = widget.totalDuration % 60;
  }

  void _updateTotalDuration() {
    final newDuration = _minutes * 60 + _seconds;
    widget.onDurationChanged(newDuration);
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Checkbox(
                  value: widget.isEnabled,
                  onChanged: (value) => widget.onEnabledChanged(value ?? false),
                ),
                const Text(
                  'Auto-stop timer',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                if (widget.isEnabled)
                  Text(
                    _formatTime(widget.remainingSeconds),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
            if (widget.isEnabled) ...[
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Duration: '),
                  // Minutes input
                  SizedBox(
                    width: 60,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Min',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                      ),
                      controller: TextEditingController(
                        text: _minutes.toString(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _minutes = int.tryParse(value) ?? 0;
                          _updateTotalDuration();
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(':'),
                  const SizedBox(width: 8),
                  // Seconds input
                  SizedBox(
                    width: 60,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Sec',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                      ),
                      controller: TextEditingController(
                        text: _seconds.toString(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _seconds = int.tryParse(value) ?? 0;
                          if (_seconds >= 60) {
                            _minutes += _seconds ~/ 60;
                            _seconds = _seconds % 60;
                          }
                          _updateTotalDuration();
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Slider(
                value: widget.totalDuration.toDouble(),
                min: MetronomeDuration.min,
                // Minimum 30 seconds
                max: MetronomeDuration.max,
                // Maximum 30 minutes
                divisions: (MetronomeDuration.max ~/ MetronomeDuration.min) - 1,
                // Allow increments of 30 seconds
                label: _formatTime(widget.totalDuration),
                onChanged: (value) {
                  final newDuration = value.toInt();
                  widget.onDurationChanged(newDuration);
                  setState(() {
                    _minutes = newDuration ~/ 60;
                    _seconds = newDuration % 60;
                  });
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
