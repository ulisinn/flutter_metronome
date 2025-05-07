import 'package:flutter/material.dart';

import '../screens/save_metronome_setting_simple.dart';

/// Function to show the save metronome settings dialog
Future<bool?> showSaveMetronomeDialog({
  required BuildContext context,
  required int bpm,
  String timeSignature = '4/4',
  String initialTitle = '',
  Function(String title)? onSave,
}) {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController(text: initialTitle);

  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Save Metronome Settings'),
        content: SaveMetronomeSettingSimple(
          formKey: formKey,
          titleController: titleController,
          bpm: bpm,
          timeSignature: timeSignature,
          initialTitle: initialTitle,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                // print(titleController.value.text);
                Navigator.of(context).pop(true);
              } else {
                // Form is invalid, display error messages
              }

              // if (title != null) {
              //   if (onSave != null) {
              //     onSave(title);
              //   }
              //   Navigator.of(context).pop(true);
              // }
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}
