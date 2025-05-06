import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Playground extends StatelessWidget {
  const Playground({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Playground'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => context.go('/'),  // Navigate back to home
          ),
        ),
        body: const Placeholder());
  }
}
