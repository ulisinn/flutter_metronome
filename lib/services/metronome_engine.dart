// Metronome Engine class to encapsulate metronome functionality
import 'dart:async';

import 'package:audioplayers/audioplayers.dart';

import '../models/cell_config.dart';

class MetronomeEngine {
  // Audio players
  final AudioPlayer _strongBeatPlayer =
  AudioPlayer()..setReleaseMode(ReleaseMode.stop);
  final AudioPlayer _weakBeatPlayer =
  AudioPlayer()..setReleaseMode(ReleaseMode.stop);

  // Timing controls
  Timer? _timer;
  bool _isPlaying = false;
  double _bpm = 120.0;

  // Current state
  int _currentCell = 0;
  int _currentPulse = 0;
  int _totalPulses = 0;

  // Sequence of cells
  final List<CellConfig> _sequence = [];

  // Callback for UI updates
  Function(int currentCell, int currentPulse)? onBeatChanged;
  Function(bool isPlaying)? onPlaybackStateChanged;

  // Constructor
  MetronomeEngine() {
    _init();
  }

  // Initialize the metronome
  Future<void> _init() async {
    await _prepareAudioPlayers();
    // Add a default cell to start
    _sequence.add(CellConfig(pulses: 4));
    _updateTotalPulses();
  }

  // Getters
  bool get isPlaying => _isPlaying;
  double get bpm => _bpm;
  int get currentCell => _currentCell;
  int get currentPulse => _currentPulse;
  List<CellConfig> get sequence => List.unmodifiable(_sequence);
  int get totalPulses => _totalPulses;

  // Prepare audio players
  Future<void> _prepareAudioPlayers() async {
    await _strongBeatPlayer.setSource(AssetSource('sounds/strong_beat.wav'));
    await _weakBeatPlayer.setSource(AssetSource('sounds/weak_beat.wav'));
    // Set volume
    await _strongBeatPlayer.setVolume(1.0);
    await _weakBeatPlayer.setVolume(0.7);
  }

  // Update BPM
  void setBpm(double value) {
    _bpm = value;

    // Restart metronome if playing to apply new BPM
    if (_isPlaying) {
      stop();
      start();
    }
  }

  // Add a cell to the sequence
  bool addCell(int pulses) {
    if (_sequence.length < 7) {
      _sequence.add(CellConfig(pulses: pulses));
      _updateTotalPulses();
      return true;
    }
    return false;
  }

  // Remove a cell from the sequence
  bool removeCell(int index) {
    if (_sequence.length > 1) {
      _sequence.removeAt(index);
      _updateTotalPulses();

      // Adjust currentCell if needed
      if (_currentCell >= _sequence.length) {
        _currentCell = _sequence.length - 1;
      }

      return true;
    }
    return false;
  }

  // Update total pulses count
  void _updateTotalPulses() {
    _totalPulses = _sequence.fold(0, (sum, cell) => sum + cell.pulses);
  }

  // Toggle playback
  void togglePlayback() {
    if (_isPlaying) {
      stop();
    } else {
      start();
    }
  }

  // Start the metronome
  void start() {
    if (_sequence.isEmpty) return;

    _isPlaying = true;
    _currentCell = 0;
    _currentPulse = 0;

    // Notify listeners about playback state change
    onPlaybackStateChanged?.call(_isPlaying);

    // Calculate interval in milliseconds from BPM
    double interval = 60000 / _bpm;

    _timer = Timer.periodic(Duration(milliseconds: interval.round()), (timer) {
      if (_sequence.isEmpty) {
        stop();
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

      // Move to next pulse
      _currentPulse++;

      // If we've completed all pulses in current cell, move to next cell
      if (_currentPulse >= _sequence[_currentCell].pulses) {
        _currentPulse = 0;
        _currentCell = (_currentCell + 1) % _sequence.length;
      }

      // Notify listeners about beat change
      onBeatChanged?.call(_currentCell, _currentPulse);
    });
  }

  // Stop the metronome
  void stop() {
    _timer?.cancel();
    _isPlaying = false;
    _currentCell = 0;
    _currentPulse = 0;

    // Notify listeners about playback state change
    onPlaybackStateChanged?.call(_isPlaying);
    // Notify listeners about beat change
    onBeatChanged?.call(_currentCell, _currentPulse);
  }

  // Clean up resources
  void dispose() {
    _timer?.cancel();
    _strongBeatPlayer.dispose();
    _weakBeatPlayer.dispose();
  }
}
