import 'package:flutter/material.dart';

class SaveMetronomeSettingSimple extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final int bpm;
  final String timeSignature;
  final String initialTitle;

  // Add the getTitle property as a callback function
  final String? Function()? getTitle;

  const SaveMetronomeSettingSimple({
    super.key,
    required this.bpm,
    this.timeSignature = '4/4',
    this.initialTitle = '',
    this.getTitle,
    required this.formKey,
    required this.titleController, // Add this parameter
  });

  @override
  State<SaveMetronomeSettingSimple> createState() =>
      _SaveMetronomeSettingSimpleState();
}

class _SaveMetronomeSettingSimpleState
    extends State<SaveMetronomeSettingSimple> {
  // late final TextEditingController _titleController = widget;

  @override
  void initState() {
    super.initState();
    // _titleController = TextEditingController(text: widget.initialTitle);
  }

  @override
  void dispose() {
    widget.titleController.dispose();
    super.dispose();
  }

  // Validator for the title field
  String? _validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Title is required';
    }

    // Check if the value contains only alphanumeric characters
    final alphanumericRegex = RegExp(r'^[a-zA-Z0-9 ]+$');
    if (!alphanumericRegex.hasMatch(value)) {
      return 'Only alphanumeric characters are allowed';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: widget.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: widget.titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                hintText: 'Enter a name for these settings',
                errorMaxLines: 2,
              ),
              validator: _validateTitle,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            const SizedBox(height: 16),
            Text('BPM: ${widget.bpm}'),
            const SizedBox(height: 8),
            Text('Time Signature: ${widget.timeSignature}'),
          ],
        ),
      ),
    );
  }
}
