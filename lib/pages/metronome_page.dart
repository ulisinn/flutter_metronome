import 'package:flutter/material.dart';

import '../models/cell_config.dart';
import '../core/metronome_engine.dart';
import '../models/metronome_config.dart';
import '../widgets/beat_visualizer.dart';
import '../widgets/bpm_control.dart';
import '../widgets/cell_selector.dart';
import '../widgets/playback_control.dart';
import '../widgets/sequence_list.dart';
import '../widgets/countdown_timer_widget.dart';


// Main metronome page
class MetronomePage extends StatefulWidget {
  const MetronomePage({super.key});

  @override
  _MetronomePageState createState() => _MetronomePageState();
}

class _MetronomePageState extends State<MetronomePage> {
  // Metronome engine instance
  late final MetronomeEngine _metronome;

  // UI state
  final List<CellConfig> _availableCells = [
    CellConfig(pulses: 2),
    CellConfig(pulses: 3),
    CellConfig(pulses: 4),
  ];

  bool _isPlaying = false;
  int _currentCell = 0;
  int _currentPulse = 0;
  // Add these state variables to _MetronomePageState
  bool _useCountdownTimer = false;
  int _countdownDuration = 300; // Default 5 minutes

  @override
  void initState() {
    super.initState();

  // Create a config object
  final config = MetronomeConfig(
    initialBpm: 120.0,  // Custom initial BPM
    initialSequence: [  // Custom initial sequence
      CellConfig(pulses: 4),
    ],
    strongBeatVolume: 1.0,
    weakBeatVolume: 0.7,
  );

  // TODO: make config object in constructor work.
  // Initialize metronome engine with config
  // _metronome = MetronomeEngine(config: config);
  _metronome = MetronomeEngine();

    // Set up listeners for metronome events
    _metronome.onBeatChanged = (cell, pulse) {
      setState(() {
        _currentCell = cell;
        _currentPulse = pulse;
      });
    };

    _metronome.onPlaybackStateChanged = (isPlaying) {
      setState(() {
        _isPlaying = isPlaying;
      });
    };
  }

  void _addCell(int pulses) {
    bool success = _metronome.addCell(pulses);
    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Maximum 7 cells allowed')),
      );
    } else {
      setState(() {});
    }
  }

  void _removeCell(int index) {
    bool success = _metronome.removeCell(index);
    if (success) {
      setState(() {});
    }
  }

  // Add this method to _MetronomePageState
  void _onCountdownTimerEnabledChanged(bool enabled) {
    setState(() {
      _useCountdownTimer = enabled;
      _metronome.setCountdownTimer(enabled, durationSeconds: _countdownDuration);
    });
  }

  void _onCountdownDurationChanged(int seconds) {
    setState(() {
      _countdownDuration = seconds;
      _metronome.setCountdownTimer(_useCountdownTimer, durationSeconds: seconds);
    });
  }

  void _onBpmChanged(double value) {
    _metronome.setBpm(value);
    setState(() {});
  }

  @override
  void dispose() {
    _metronome.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Metronome'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // BPM control
          BpmControlWidget(
            bpm: _metronome.bpm,
            onChanged: _onBpmChanged,
          ),

          // Available cell types
          CellSelectorWidget(
            availableCells: _availableCells,
            onCellSelected: _addCell,
          ),

          // Current sequence display
          Expanded(
            child: SequenceListWidget(
              sequence: _metronome.sequence,
              currentCell: _currentCell,
              isPlaying: _isPlaying,
              onRemoveCell: _removeCell,
            ),
          ),

          // Visualization of current beat
          if (_isPlaying && _metronome.sequence.isNotEmpty)
            BeatVisualizerWidget(
              currentCell: _metronome.sequence[_currentCell],
              currentPulse: _currentPulse,
            ),
          // Update the build method to include the countdown timer widget
          // Add this before the PlaybackControlWidget in the Column children
          CountdownTimerWidget(
            isEnabled: _useCountdownTimer,
            remainingSeconds: _metronome.remainingSeconds,
            totalDuration: _countdownDuration,
            onEnabledChanged: _onCountdownTimerEnabledChanged,
            onDurationChanged: _onCountdownDurationChanged,
          ),
          // Play/Stop button
          PlaybackControlWidget(
            isPlaying: _isPlaying,
            onToggle: () => _metronome.togglePlayback(),
          ),
        ],
      ),
    );
  }
}
