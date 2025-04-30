
// Main metronome page
import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../models/cell_config.dart';
import '../widgets/beat_visualizer.dart';
import '../widgets/bpm_control.dart';
import '../widgets/cell_selector.dart';
import '../widgets/playback_control.dart';
import '../widgets/sequence_list.dart';

class MetronomePage extends StatefulWidget {
  const MetronomePage({Key? key}) : super(key: key);

  @override
  _MetronomePageState createState() => _MetronomePageState();
}

class _MetronomePageState extends State<MetronomePage> {
  final List<CellConfig> _availableCells = [
    CellConfig(pulses: 2),
    CellConfig(pulses: 3),
    CellConfig(pulses: 4),
  ];

  final List<CellConfig> _sequence = [];

  // Timing controls
  double _bpm = 120.0;
  Timer? _timer;
  bool _isPlaying = false;
  int _currentCell = 0;
  int _currentPulse = 0;
  int _totalPulses = 0;

  // Audio players
  final AudioPlayer _strongBeatPlayer =
  AudioPlayer()..setReleaseMode(ReleaseMode.stop);
  final AudioPlayer _weakBeatPlayer =
  AudioPlayer()..setReleaseMode(ReleaseMode.stop);

  @override
  void initState() {
    super.initState();
    // Add a default cell to start
    _sequence.add(CellConfig(pulses: 4));
    _prepareAudioPlayers();
  }

  Future<void> _prepareAudioPlayers() async {
    await _strongBeatPlayer.setSource(AssetSource('sounds/strong_beat.wav'));
    await _weakBeatPlayer.setSource(AssetSource('sounds/weak_beat.wav'));
    // Set volume
    await _strongBeatPlayer.setVolume(1.0);
    await _weakBeatPlayer.setVolume(0.7);
  }

  void _addCell(int pulses) {
    if (_sequence.length < 7) {
      setState(() {
        _sequence.add(CellConfig(pulses: pulses));
        _updateTotalPulses();
      });
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Maximum 7 cells allowed')));
    }
  }

  void _removeCell(int index) {
    if (_sequence.length > 1) {
      setState(() {
        _sequence.removeAt(index);
        _updateTotalPulses();
      });
    }
  }

  void _updateTotalPulses() {
    _totalPulses = _sequence.fold(0, (sum, cell) => sum + cell.pulses);
  }

  void _togglePlayback() {
    if (_isPlaying) {
      _stopMetronome();
    } else {
      _startMetronome();
    }
  }

  void _startMetronome() {
    if (_sequence.isEmpty) return;

    setState(() {
      _isPlaying = true;
      _currentCell = 0;
      _currentPulse = 0;
    });

    // Calculate interval in milliseconds from BPM
    double interval = 60000 / _bpm;

    _timer = Timer.periodic(Duration(milliseconds: interval.round()), (timer) {
      if (_sequence.isEmpty) {
        _stopMetronome();
        return;
      }

      // Play the appropriate sound
      if (_currentPulse == 0) {
        // First beat is strong
        _strongBeatPlayer.stop();
        _strongBeatPlayer.resume();
      } else {
        // Other beats are weak
        _weakBeatPlayer.stop();
        _weakBeatPlayer.resume();
      }

      setState(() {
        // Move to next pulse
        _currentPulse++;

        // If we've completed all pulses in current cell, move to next cell
        if (_currentPulse >= _sequence[_currentCell].pulses) {
          _currentPulse = 0;
          _currentCell = (_currentCell + 1) % _sequence.length;
        }
      });
    });
  }

  void _stopMetronome() {
    _timer?.cancel();
    setState(() {
      _isPlaying = false;
      _currentCell = 0;
      _currentPulse = 0;
    });
  }

  void _onBpmChanged(double value) {
    setState(() {
      _bpm = value;
    });

    // Restart metronome if playing to apply new BPM
    if (_isPlaying) {
      _stopMetronome();
      _startMetronome();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _strongBeatPlayer.dispose();
    _weakBeatPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Metronome'), centerTitle: true),
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
              currentCell: _currentCell,
              isPlaying: _isPlaying,
              onRemoveCell: _removeCell,
            ),
          ),

          // Visualization of current beat
          if (_isPlaying)
            BeatVisualizerWidget(
              currentCell: _sequence[_currentCell],
              currentPulse: _currentPulse,
            ),

          // Play/Stop button
          PlaybackControlWidget(
            isPlaying: _isPlaying,
            onToggle: _togglePlayback,
          ),
        ],
      ),
    );
  }
}
