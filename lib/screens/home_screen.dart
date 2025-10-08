import 'package:flutter/material.dart';
import 'catch_food_screen.dart';
// (Later we'll add the other two mini-games: burger_stack_screen.dart, memory_match_screen.dart)

class HomeScreen extends StatefulWidget {
  final Function(int) onPointsEarned;
  const HomeScreen({super.key, required this.onPointsEarned});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _openCatchFoodGame() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CatchFoodScreen(
          onGameEnd: (points) {
            // ✅ points are added when the game ends
            widget.onPointsEarned(points);
          },
        ),
      ),
    );
  }

  // We'll add these two later
  void _openBurgerStack() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Burger Stack coming soon 🍔")),
    );
  }

  void _openMemoryMatch() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Memory Match coming soon 🧠")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("🍟 McPlay Rewards")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Choose a Game!",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: _openCatchFoodGame,
                icon: const Icon(Icons.fastfood),
                label: const Text("Catch the Food"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _openBurgerStack,
                icon: const Icon(Icons.lunch_dining),
                label: const Text("Burger Stack"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _openMemoryMatch,
                icon: const Icon(Icons.extension),
                label: const Text("Memory Match"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
