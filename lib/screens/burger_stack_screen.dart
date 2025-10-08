import 'package:flutter/material.dart';

class BurgerStackScreen extends StatelessWidget {
  final Function(int) onPointsEarned;

  const BurgerStackScreen({required this.onPointsEarned, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Burger Stack 🍔')),
      body: const Center(child: Text('Burger Stack game coming soon!')),
    );
  }
}
