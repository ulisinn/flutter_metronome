import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/metronome_engine.dart';
import '../../models/cell_config.dart';
import '../../models/metronome_config.dart';
import '../widgets/beat_visualizer.dart';
import '../widgets/bpm_control.dart';
import '../widgets/cell_selector.dart';
import '../widgets/playback_control.dart';
import '../widgets/sequence_list.dart';
import '../widgets/countdown_timer_widget.dart';

// Main metronome page
class MetronomePageExpert extends StatefulWidget {
  const MetronomePageExpert({super.key});

  @override
  _MetronomePageExpertState createState() => _MetronomePageExpertState();
}

class _MetronomePageExpertState extends State<MetronomePageExpert> {
  // Metronome engine instance
  late final MetronomeEngine _metronome;
  List<CellConfig> _sequence = [];

  // UI state
  final List<CellConfig> _availableCells = [
    CellConfig(pulses: 2),
    CellConfig(pulses: 3),
    CellConfig(pulses: 4),
  ];
  double _bpm = 120.0;
  bool _isPlaying = false;
  int _currentCell = 0;
  int _currentPulse = -1;

  // Add these state variables to _MetronomePageState
  bool _useCountdownTimer = true;
  int _countdownDuration = 300; // Default 5 minutes

  @override
  void initState() {
    super.initState();

    // Create a config object
    final _config = MetronomeConfig(
      initialBpm: _bpm, // Custom initial BPM
      cellSequence: [
        // Custom initial sequence
        CellConfig(pulses: 4),
      ],
      useCountdownTimer: _useCountdownTimer,
    );

    // TODO: make config object in constructor work.
    // Initialize metronome engine with config
    // _metronome = MetronomeEngine(config: config);
    _sequence = List.from(_config.cellSequence);
    _metronome = MetronomeEngine(config: _config);

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
    // Check if we can add more cells (max 7)
    if (_sequence.length >= 7) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Maximum 7 cells allowed')));
      return;
    }

    setState(() {
      // Update local sequence state
      _sequence.add(CellConfig(pulses: pulses));

      // Create a new config with the updated sequence
      final config = _createCurrentConfig();

      // Update the metronome with the new config
      _metronome.updateConfig(config);
    });
  }

  void _removeCell(int index) {
    // Check if we can remove cells (min 1)
    if (_sequence.length <= 1) {
      return;
    }

    setState(() {
      // Update local sequence state
      _sequence.removeAt(index);

      // Create a new config with the updated sequence
      final config = _createCurrentConfig();

      // Update the metronome with the new config
      _metronome.updateConfig(config);
    });
  }

  // Add this method to _MetronomePageState
  void _onCountdownTimerEnabledChanged(bool enabled) {
    setState(() {
      _useCountdownTimer = enabled;

      // Create a new config with updated countdown timer settings
      final config = _createCurrentConfig();

      // Update the metronome with the new config
      _metronome.updateConfig(config);
    });
  }

  void _onCountdownDurationChanged(int seconds) {
    setState(() {
      _countdownDuration = seconds;

      // Create a new config with updated countdown duration
      final config = _createCurrentConfig();

      // Update the metronome with the new config
      _metronome.updateConfig(config);
    });
  }

  void _onBpmChanged(double value) {
    setState(() {
      _bpm = value;

      // Create a new config with updated BPM
      final config = _createCurrentConfig();

      // Update the metronome with the new config
      _metronome.updateConfig(config);
    });
  }

  // Add this method to _MetronomePageState
  MetronomeConfig _createCurrentConfig() {
    return MetronomeConfig(
      initialBpm: _bpm,
      cellSequence: List.from(_sequence),
      // Use local sequence instead of _metronome.sequence
      useCountdownTimer: _useCountdownTimer,
      countdownDurationSeconds: _countdownDuration,
    );
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
        title: const Text('Metronome Expert Settings'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          // TODO: FIX NAVIGATION
          onPressed: () => context.go('/'),  // Navigate back to home
        ),
      ),
      body: Column(
        children: [
          // BPM control
          BpmControlWidget(bpm: _bpm, onChanged: _onBpmChanged),

          // Available cell types
          CellSelectorWidget(
            availableCells: _availableCells,
            onCellSelected: _addCell,
          ),

          // Current sequence display
          Expanded(
            child: SequenceListWidget(
              sequence: _sequence,
              // Use local sequence instead of _metronome.sequence
              currentCell: _currentCell,
              isPlaying: _isPlaying,
              onRemoveCell: _removeCell,
            ),
          ),

          // Visualization of current beat
          if (_isPlaying && _sequence.isNotEmpty) // Use local sequence
            BeatVisualizerWidget(
              currentCell: _sequence[_currentCell], // Use local sequence
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
