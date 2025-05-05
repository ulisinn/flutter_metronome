
// Widget for selecting cell types
import 'package:flutter/material.dart';

import '../models/cell_config.dart';

class CellSelectorWidget extends StatelessWidget {
  final List<CellConfig> availableCells;
  final Function(int) onCellSelected;

  const CellSelectorWidget({
    super.key,
    required this.availableCells,
    required this.onCellSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
            for (var cell in availableCells)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ElevatedButton(
                  onPressed: () => onCellSelected(cell.pulses),
                  child: Text('${cell.pulses} Pulses'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
