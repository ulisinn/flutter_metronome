// lib/features/metronome/pages/metronome_page_simple.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../constants/metronome_settings.dart';
import '../../../../core/metronome_engine.dart';
import '../../../../routing/app_router.dart';
import '../../models/cell_config.dart';
import '../../models/metronome_config.dart';
import '../widgets/beat_visualizer.dart';
import '../widgets/playback_control.dart';
import '../widgets/save_metronome_dialog.dart';

class MetronomePageSimple extends StatefulWidget {
  final MetronomeConfig? config;

  const MetronomePageSimple({super.key, this.config});

  @override
  _MetronomePageSimpleState createState() => _MetronomePageSimpleState();
}

class _MetronomePageSimpleState extends State<MetronomePageSimple> {
  // Metronome engine instance
  late final MetronomeEngine _metronome;

  // UI state
  double _bpm = 120.0; // Default BPM
  bool _isPlaying = false;
  int _currentCell = 0;
  int _currentPulse = -1;

  // Current index in the MetronomeMarkings.mmList
  int _currentBpmIndex = MetronomeMarkings.mmList.indexOf(120.0);

  @override
  void initState() {
    super.initState();

    // Use the provided config if available, otherwise create a new one
    final _config = widget.config ?? MetronomeConfig(
      initialBpm: _bpm,
      cellSequence: [CellConfig(pulses: 4)], // Default 4/4 time signature
      markDownbeat: false, // Set to false for simple metronome
    );

    // If a config was provided, update the local BPM value
    if (widget.config != null) {
      _bpm = widget.config!.initialBpm;
      _currentBpmIndex = MetronomeMarkings.mmList.indexOf(_bpm) != -1
          ? MetronomeMarkings.mmList.indexOf(_bpm)
          : _currentBpmIndex;
    }

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

  void _onBpmSliderChanged(double value) {
    // Find the closest value in the mmList
    _currentBpmIndex = value.round();

    if (_currentBpmIndex >= 0 &&
        _currentBpmIndex < MetronomeMarkings.mmList.length) {
      setState(() {
        _bpm = MetronomeMarkings.mmList[_currentBpmIndex];

        // Create a new config with updated BPM
        final config = _createCurrentConfig();

        // Update the metronome with the new config
        _metronome.updateConfig(config);
      });
    }
  }

  // Create a config with the current BPM
  MetronomeConfig _createCurrentConfig() {
    return MetronomeConfig(
      initialBpm: _bpm,
      cellSequence: [CellConfig(pulses: 4)], // Always use 4/4 time signature
      markDownbeat: false, // Set to false for simple metronome
    );
  }

// Inside the _MetronomePageSimpleState class
void _showSaveDialog(BuildContext context) {
  showSaveMetronomeDialog(
    context: context,
    bpm: _bpm.round(),
    onSave: (title) {
      // Now you have access to the validated title
      // This would save the settings with the provided title
      print('Saving metronome settings with title: $title');
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
        title: const Text('Metronome Simple Settings'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          // TODO: FIX NAVIGATION
          onPressed: () => context.go('/'), // Navigate back to home
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // BPM display
          Text(
            '${_bpm.round()} BPM',
            style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),

          // Tempo name display
          Text(
            MetronomeMarkings.tempoName(_bpm.round()),
            style: const TextStyle(fontSize: 24, fontStyle: FontStyle.italic),
          ),

          const SizedBox(height: 40),

          // BPM slider using MetronomeMarkings.mmList
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                Slider(
                  value: _currentBpmIndex.toDouble(),
                  min: 0,
                  max: (MetronomeMarkings.mmList.length - 1).toDouble(),
                  divisions: MetronomeMarkings.mmList.length - 1,
                  label: _bpm.round().toString(),
                  onChanged: _onBpmSliderChanged,
                ),

                // Min and max BPM labels
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${MetronomeMarkings.lowerBorder.round()} BPM'),
                      Text('${MetronomeMarkings.upperBorder.round()} BPM'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // Visualization of current beat
          if (_isPlaying)
            BeatVisualizerWidget(
              currentCell: CellConfig(pulses: 4),
              currentPulse: _currentPulse,
            ),

          const SizedBox(height: 40),

          // Play/Stop button
          PlaybackControlWidget(
            isPlaying: _isPlaying,
            onToggle: () => _metronome.togglePlayback(),
          ),
          // Add spacing between the play button and the Expert Mode button
          const SizedBox(height: 20),

          // Expert Mode button
          ElevatedButton(
            onPressed: () {
              // Navigate to the expert mode page using GoRouter
              GoRouter.of(context).goNamed(AppRoute.metronomeExpert.name);
            },
            child: const Text('Expert Mode'),
          ),
          // In the build method, after the Expert Mode button (around line 179), add:
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
