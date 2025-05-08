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
import '../widgets/save_metronome_dialog.dart';

// Main metronome page
class MetronomePageExpert extends StatefulWidget {
  final MetronomeConfig? config;

  const MetronomePageExpert({super.key, this.config});

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

    // Use the provided config if available, otherwise create a new one
    final _config = widget.config ?? MetronomeConfig(
      initialBpm: _bpm, // Custom initial BPM
      cellSequence: [
        // Custom initial sequence
        CellConfig(pulses: 4),
      ],
      useCountdownTimer: _useCountdownTimer,
    );

    // If a config was provided, update the local state variables
    if (widget.config != null) {
      _bpm = widget.config!.initialBpm;
      _useCountdownTimer = widget.config!.useCountdownTimer;
      if (widget.config!.countdownDurationSeconds > 0) {
        _countdownDuration = widget.config!.countdownDurationSeconds;
      }
    }

    // Initialize sequence from config
    _sequence = List.from(_config.cellSequence);

    // Initialize metronome engine with config
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

  // Show save dialog method
  void _showSaveDialog(BuildContext context) {
    // Calculate time signature based on the first cell in the sequence
    String timeSignature = _sequence.isNotEmpty
        ? '${_sequence[0].pulses}/4'
        : '4/4'; // Default to 4/4 if sequence is empty

    showSaveMetronomeDialog(
      context: context,
      bpm: _bpm.round(),
      timeSignature: timeSignature,
      onSave: (title) {
        // Now you have access to the validated title
        // This would save the settings with the provided title
        print('Saving expert metronome settings with title: $title');
      },
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

          // Add spacing between the play button and the Save button
          const SizedBox(height: 20),

          // Save button
          ElevatedButton(
            onPressed: () => _showSaveDialog(context),
            child: const Text('Save Current Settings'),
          ),
        ],
      ),
    );
  }
}
