import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MetronomeApp());
}

class MetronomeApp extends StatelessWidget {
  const MetronomeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Metronome',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: const MetronomePage(),
    );
  }
}

class MetronomePage extends StatefulWidget {
  const MetronomePage({super.key});

  @override
  _MetronomePageState createState() => _MetronomePageState();
}

class CellConfig {
  final int pulses;
  bool isActive;

  CellConfig({required this.pulses, this.isActive = true});
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
  final AudioPlayer _strongBeatPlayer = AudioPlayer()
  ..setReleaseMode(ReleaseMode.stop);
  final AudioPlayer _weakBeatPlayer = AudioPlayer()
  ..setReleaseMode(ReleaseMode.stop);

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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Maximum 7 cells allowed')),
      );
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
      appBar: AppBar(
        title: const Text('Custom Metronome'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // BPM control
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Text('BPM:', style: TextStyle(fontSize: 18)),
                Expanded(
                  child: Slider(
                    value: _bpm,
                    min: 40,
                    max: 240,
                    divisions: 200,
                    label: _bpm.round().toString(),
                    onChanged: (value) {
                      setState(() {
                        _bpm = value;
                      });

                      // Restart metronome if playing to apply new BPM
                      if (_isPlaying) {
                        _stopMetronome();
                        _startMetronome();
                      }
                    },
                  ),
                ),
                Text('${_bpm.round()}', style: const TextStyle(fontSize: 18)),
              ],
            ),
          ),

          // Available cell types
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Add Cell:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var cell in _availableCells)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                    onPressed: () => _addCell(cell.pulses),
                    child: Text('${cell.pulses} Pulses'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                ),
            ],
          ),

          // Current sequence display
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sequence (${_sequence.length}/7 cells):',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListView.builder(
                        itemCount: _sequence.length,
                        itemBuilder: (context, index) {
                          final isCurrentCell = _isPlaying && index == _currentCell;
                          return ListTile(
                            title: Text(
                              'Cell ${index + 1}: ${_sequence[index].pulses} pulses',
                              style: TextStyle(
                                fontWeight: isCurrentCell ? FontWeight.bold : FontWeight.normal,
                                color: isCurrentCell ? Theme.of(context).colorScheme.primary : null,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _removeCell(index),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Visualization of current beat
          if (_isPlaying)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _sequence[_currentCell].pulses,
                      (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index == _currentPulse
                          ? (index == 0 ? Colors.red : Colors.green)
                          : (index == 0 ? Colors.red.withOpacity(0.3) : Colors.green.withOpacity(0.3)),
                    ),
                  ),
                ),
              ),
            ),

          // Play/Stop button
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: ElevatedButton(
              onPressed: _togglePlayback,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                backgroundColor: _isPlaying ? Colors.red : Colors.green,
              ),
              child: Text(
                _isPlaying ? 'Stop' : 'Play',
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
