// Metronome Engine class to encapsulate metronome functionality
import 'dart:async';

import 'package:audioplayers/audioplayers.dart';

import '../constants/metronome_settings.dart';
import '../features/metronome/models/cell_config.dart';
import '../features/metronome/models/metronome_config.dart';
import 'countdown_timer.dart';

class MetronomeEngine {
  // Audio players
  final AudioPlayer _strongBeatPlayer =
      AudioPlayer()..setReleaseMode(ReleaseMode.stop);
  final AudioPlayer _weakBeatPlayer =
      AudioPlayer()..setReleaseMode(ReleaseMode.stop);

  // Add these properties to the class
  CountdownTimer? _countdownTimer;
  bool _markDownbeat;
  bool _useCountdownTimer = false;
  int _countdownDurationSeconds = 300; // Default 5 minutes

  // Timing controls
  Timer? _timer;
  bool _isPlaying = false;
  double _bpm;

  // Current state
  int _currentCell = 0;
  int _currentPulse = 0;
  int _totalPulses = 0;

  // Sequence of cells
  final List<CellConfig> _sequence = [];

  // Audio settings
  final double _strongBeatVolume;
  final double _weakBeatVolume;

  // Callback for UI updates
  Function(int currentCell, int currentPulse)? onBeatChanged;
  Function(bool isPlaying)? onPlaybackStateChanged;

  // Constructor with config parameter
  MetronomeEngine({MetronomeConfig? config})
    : _bpm = config?.initialBpm ?? 120.0,
      _strongBeatVolume =
          config?.strongBeatVolume ?? MetronomeVolume.strongBeatVolume,
      _weakBeatVolume =
          config?.weakBeatVolume ?? MetronomeVolume.weakBeatVolume,
      _useCountdownTimer = config?.useCountdownTimer ?? false,
      _countdownDurationSeconds = config?.countdownDurationSeconds ?? 300,
      _markDownbeat = config?.markDownbeat ?? true {
    _init(config);
  }

  // Initialize the metronome
  Future<void> _init(MetronomeConfig? config) async {
    await _prepareAudioPlayers();

    // Add cells from config or default
    if (config != null && config.cellSequence.isNotEmpty) {
      _sequence.addAll(config.cellSequence);
    } else {
      // Add a default cell to start
      _sequence.add(CellConfig(pulses: 4));
    }

    _updateTotalPulses();
  }

  // Add this method to the MetronomeEngine class
  void updateConfig(MetronomeConfig config) {
    // Update BPM
    _bpm = config.initialBpm;

    // Update volume settings
    _strongBeatPlayer.setVolume(config.strongBeatVolume);
    _weakBeatPlayer.setVolume(config.weakBeatVolume);

    // Update countdown timer settings
    _useCountdownTimer = config.useCountdownTimer;
    _countdownDurationSeconds = config.countdownDurationSeconds;

    // Update markDownbeat setting
    _markDownbeat = config.markDownbeat;
    // Recreate the countdown timer if needed
    if (_useCountdownTimer) {
      _countdownTimer?.dispose();
      _countdownTimer = CountdownTimer(
        durationSeconds: _countdownDurationSeconds,
        onComplete: () {
          stop();
        },
        onTick: (seconds) {
          // This can be used to update UI if needed
        },
      );
    }

    // Update sequence
    _sequence.clear();
    _sequence.addAll(config.cellSequence);
    _updateTotalPulses();

    // Reset current position
    _currentCell = 0;
    _currentPulse = 0;

    // Restart metronome if playing to apply new settings
    if (_isPlaying) {
      stop();
      start();
    }
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
    await _strongBeatPlayer.setVolume(_strongBeatVolume);
    await _weakBeatPlayer.setVolume(_weakBeatVolume);
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

    // Start countdown timer if enabled
    if (_useCountdownTimer && _countdownTimer != null) {
      _countdownTimer!.reset();
      _countdownTimer!.start();
    }

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
      if (_currentPulse == 0 && _markDownbeat) {
        // First beat is strong (only if markDownbeat is true)
        _strongBeatPlayer.stop();
        _strongBeatPlayer.resume();
      } else {
        // Other beats are weak (or all beats if markDownbeat is false)
        _weakBeatPlayer.stop();
        _weakBeatPlayer.resume();
      }

      // Notify listeners about beat change BEFORE incrementing
      onBeatChanged?.call(_currentCell, _currentPulse);
      // Move to next pulse
      _currentPulse++;

      // If we've completed all pulses in current cell, move to next cell
      if (_currentPulse >= _sequence[_currentCell].pulses) {
        _currentPulse = 0;
        _currentCell = (_currentCell + 1) % _sequence.length;
      }
    });
  }

  // Stop the metronome
  void stop() {
    _timer?.cancel();
    _isPlaying = false;
    _currentCell = 0;
    _currentPulse = 0;

    // Stop countdown timer if active
    _countdownTimer?.stop();

    // Notify listeners about playback state change
    onPlaybackStateChanged?.call(_isPlaying);
    // Notify listeners about beat change
    onBeatChanged?.call(_currentCell, _currentPulse);
  }

  // Clean up resources
  void dispose() {
    _timer?.cancel();
    _countdownTimer?.dispose();
    _strongBeatPlayer.dispose();
    _weakBeatPlayer.dispose();
  }

  // Add these getters
  bool get useCountdownTimer => _useCountdownTimer;

  int get countdownDurationSeconds => _countdownDurationSeconds;

  int get remainingSeconds =>
      _countdownTimer?.remainingSeconds ?? _countdownDurationSeconds;
}
