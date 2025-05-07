// Widget for displaying the sequence of cells
import 'package:flutter/material.dart';

import '../../models/cell_config.dart';
import 'cell_list_item.dart';

class SequenceListWidget extends StatelessWidget {
  final List<CellConfig> sequence;
  final int currentCell;
  final bool isPlaying;
  final Function(int) onRemoveCell;

  const SequenceListWidget({
    Key? key,
    required this.sequence,
    required this.currentCell,
    required this.isPlaying,
    required this.onRemoveCell,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sequence (${sequence.length}/7 cells):',
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
                itemCount: sequence.length,
                itemBuilder: (context, index) {
                  return CellListItem(
                    cell: sequence[index],
                    index: index,
                    isCurrentCell: isPlaying && index == currentCell,
                    onRemove: () => onRemoveCell(index),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
