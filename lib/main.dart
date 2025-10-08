import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(FoodFunArcade());
}

class FoodFunArcade extends StatefulWidget {
  const FoodFunArcade({super.key});

  @override
  _FoodFunArcadeState createState() => _FoodFunArcadeState();
}

class _FoodFunArcadeState extends State<FoodFunArcade> {
  int totalPoints = 0;

  void addPoints(int points) {
    setState(() {
      totalPoints += points;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Fun Arcade',
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.orange.shade50,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('🍔 Food Fun Arcade'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  '⭐ $totalPoints',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: HomeScreen(
          onPointsEarned: (points) {
            addPoints(points);
          },
        ),
      ),
    );
  }
}
