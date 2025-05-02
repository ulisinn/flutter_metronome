// lib/core/countdown_timer.dart
import 'dart:async';

class CountdownTimer {
  Timer? _timer;
  int _remainingSeconds;
  final int _initialDuration;
  bool _isActive = false;

  // Callback when timer completes
  final Function()? onComplete;

  // Callback for UI updates
  final Function(int)? onTick;

  CountdownTimer({
    required int durationSeconds,
    this.onComplete,
    this.onTick,
  }) : _remainingSeconds = durationSeconds,
        _initialDuration = durationSeconds;

  // Getters
  int get remainingSeconds => _remainingSeconds;
  bool get isActive => _isActive;
  int get initialDuration => _initialDuration;

  void start() {
    if (_isActive) return;

    _isActive = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _remainingSeconds--;

      // Notify UI about time change
      onTick?.call(_remainingSeconds);

      if (_remainingSeconds <= 0) {
        stop();
        onComplete?.call();
      }
    });
  }

  void stop() {
    _timer?.cancel();
    _isActive = false;
  }

  void reset() {
    stop();
    _remainingSeconds = _initialDuration;
    onTick?.call(_remainingSeconds);
  }

  void dispose() {
    _timer?.cancel();
  }
}
