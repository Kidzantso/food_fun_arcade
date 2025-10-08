import 'package:flutter/material.dart';

class MemoryMatchScreen extends StatelessWidget {
  final Function(int) onPointsEarned;

  const MemoryMatchScreen({required this.onPointsEarned, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Memory Match 🧠')),
      body: const Center(child: Text('Memory Match game coming soon!')),
    );
  }
}
