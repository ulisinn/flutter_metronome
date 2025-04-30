# flutter_metronome

## Original Prompt:
I want to build a metronome app with flutter. If shall :
1. favor exact timing
2. it shall allow cells of 2, 3, and 4 pulses
3. the first of these shall be designated 'strong' the others as 'weak'
4. I want to arbitrarily string cells together to a maximum of seven
```agsl
custom_metronome/
├── lib/
│   └── main.dart         # Main application code
├── assets/
│   └── sounds/
│       ├── strong_beat.wav  # Sound for strong beats
│       └── weak_beat.wav    # Sound for weak beats
```
# Key Features

## Exact Timing

Uses Flutter's Timer.periodic with precise calculations based on BPM
Recalculates timing when BPM changes


## Cell System

Supports cells of 2, 3, and 4 pulses as requested
First pulse in each cell is marked as "strong" (both visually and aurally)
Remaining pulses are marked as "weak"


## Custom Sequences

Allows adding up to 7 cells in any order
You can mix and match different cell types (2, 3, and 4 pulses)
Easy-to-use interface for adding and removing cells


## Visual Feedback

Current cell and beat are highlighted during playback
Strong beats are shown in red, weak beats in green
Active beats are brightly colored, while inactive beats are dimmed
