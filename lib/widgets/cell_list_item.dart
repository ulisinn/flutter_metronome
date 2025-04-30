// Widget for individual cell items in the list
import 'package:flutter/material.dart';

import '../models/cell_config.dart';

class CellListItem extends StatelessWidget {
  final CellConfig cell;
  final int index;
  final bool isCurrentCell;
  final VoidCallback onRemove;

  const CellListItem({
    Key? key,
    required this.cell,
    required this.index,
    required this.isCurrentCell,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        'Cell ${index + 1}: ${cell.pulses} pulses',
        style: TextStyle(
          fontWeight: isCurrentCell ? FontWeight.bold : FontWeight.normal,
          color: isCurrentCell ? Theme.of(context).colorScheme.primary : null,
        ),
      ),
      trailing: IconButton(icon: const Icon(Icons.delete), onPressed: onRemove),
    );
  }
}
