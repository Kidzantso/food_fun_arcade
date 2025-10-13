import 'package:flutter/material.dart';
import 'catch_food_screen.dart';
import 'memory_match_screen.dart'; // ✅ Import the new screen

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
            widget.onPointsEarned(points);
          },
        ),
      ),
    );
  }

  void _openBurgerStack() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Burger Stack coming soon 🍔")),
    );
  }

  void _openMemoryMatch() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MemoryMatchScreen(
          onGameEnd: (points) {
            widget.onPointsEarned(points);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🍟 McPlay Rewards"),
        backgroundColor: Colors.yellow[700],
        foregroundColor: Colors.red[800],
        elevation: 0,
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Choose a Game!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 198, 40, 40),
                  shadows: [
                    Shadow(
                      blurRadius: 2,
                      color: Colors.black54,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: _openCatchFoodGame,
                icon: const Icon(Icons.fastfood, color: Colors.red),
                label: const Text("Catch the Food"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  backgroundColor: Colors.yellow[700],
                  foregroundColor: const Color.fromARGB(255, 198, 40, 40),
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _openBurgerStack,
                icon: const Icon(Icons.lunch_dining, color: Colors.red),
                label: const Text("Burger Stack"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  backgroundColor: Colors.yellow[700],
                  foregroundColor: Colors.red[800],
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _openMemoryMatch,
                icon: const Icon(Icons.extension, color: Colors.red),
                label: const Text("Memory Match"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  backgroundColor: Colors.yellow[700],
                  foregroundColor: Colors.red[800],
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
