import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/metronome_engine.dart';
import '../../models/metronome_config.dart';

class MetronomeConfigCard extends StatefulWidget {
  final MetronomeConfig config;

  const MetronomeConfigCard({super.key, required this.config});

  @override
  State<MetronomeConfigCard> createState() => _MetronomeConfigCardState();
}

class _MetronomeConfigCardState extends State<MetronomeConfigCard> {
  late final MetronomeEngine _metronome;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _metronome = MetronomeEngine(config: widget.config);

    _metronome.onPlaybackStateChanged = (isPlaying) {
      setState(() {
        _isPlaying = isPlaying;
      });
    };
  }

  @override
  void dispose() {
    _metronome.dispose();
    super.dispose();
  }

  // TODO: allow exactly one metronome at a time in the app
  void _togglePlayback() {
    if (_isPlaying) {
      // _metronome.stop();
    } else {
      // _metronome.start();
    }

    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 4.0,
      child: Stack(
        children: [
          // Main content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    widget.config.title ?? 'Untitled',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const SizedBox(height: 8.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Chip(
                        label: Text('${widget.config.initialBpm.toInt()} BPM'),
                        backgroundColor: Colors.blue.shade100,
                      ),
                      if (widget.config.markDownbeat)
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Chip(
                            label: Text('Downbeat'),
                            backgroundColor: Colors.orange,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    'Cell Sequence: ${widget.config.cellSequence.map((cell) => cell.pulses).join(' + ')}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                if (widget.config.useCountdownTimer) ...[
                  const SizedBox(height: 8.0),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      'Timer: ${_formatDuration(widget.config.countdownDurationSeconds)}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Text(widget.config.id ?? Uuid().v4()),
          // Play/Stop button
          Positioned(
            top: 8.0,
            right: 8.0,
            child: FloatingActionButton(
              heroTag: "btn_${widget.config.id}",
              // Add this line to make the hero tag unique
              onPressed: _togglePlayback,
              mini: true,
              backgroundColor: _isPlaying ? Colors.red : Colors.green,
              child: Icon(
                _isPlaying ? Icons.stop : Icons.play_arrow,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
