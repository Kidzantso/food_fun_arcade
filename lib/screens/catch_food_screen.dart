import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class CatchFoodScreen extends StatefulWidget {
  final Function(int) onGameEnd;
  const CatchFoodScreen({super.key, required this.onGameEnd});

  @override
  State<CatchFoodScreen> createState() => _CatchFoodScreenState();
}

class _CatchFoodScreenState extends State<CatchFoodScreen> {
  double basketX = 0;
  double foodX = 0;
  double foodY = -1;
  int score = 0;
  int timeLeft = 30;
  bool isPlaying = false;
  Timer? gameTimer;
  Timer? dropTimer;
  Random random = Random();

  final List<String> foodImages = [
    'assets/burger.png',
    'assets/fries.png',
    'assets/drink.png',
  ];
  late String currentFood;

  @override
  void initState() {
    super.initState();
    currentFood = foodImages[random.nextInt(foodImages.length)];
  }

  void startGame() {
    setState(() {
      score = 0;
      timeLeft = 30;
      isPlaying = true;
      foodY = -1;
      foodX = (random.nextDouble() * 2) - 1;
      currentFood = foodImages[random.nextInt(foodImages.length)];
    });

    gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        setState(() => timeLeft--);
      } else {
        endGame();
      }
    });

    dropTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (!isPlaying) return;
      setState(() {
        foodY += 0.04;
      });

      // Collision detection
      if (foodY > 0.75 && (foodX - basketX).abs() < 0.18) {
        score += 10;
        resetFood();
      } else if (foodY > 1) {
        score = max(0, score - 5);
        resetFood();
      }
    });
  }

  void resetFood() {
    foodY = -1;
    foodX = (random.nextDouble() * 2) - 1;
    currentFood = foodImages[random.nextInt(foodImages.length)];
  }

  void endGame() {
    gameTimer?.cancel();
    dropTimer?.cancel();
    setState(() => isPlaying = false);

    // Show popup dialog with score
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          "🎉 Game Over!",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
        ),
        content: Text(
          "Your final score is: $score ⭐",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade700,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              widget.onGameEnd(score);
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("🏠 Home", style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    dropTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onHorizontalDragUpdate: (details) {
              if (isPlaying) {
                setState(() {
                  basketX +=
                      details.delta.dx / MediaQuery.of(context).size.width * 2;
                  basketX = basketX.clamp(-1.0, 1.0);
                });
              }
            },
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Stack(
                children: [
                  // Timer & Score
                  Positioned(
                    top: 40,
                    left: 60,
                    child: Text(
                      "⏰ $timeLeft s",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    right: 20,
                    child: Text(
                      "⭐ $score",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),

                  // Food
                  Align(
                    alignment: Alignment(foodX, foodY),
                    child: Image.asset(currentFood, width: 60),
                  ),

                  // 🍟 Basket replaced with Happy Meal box
                  Align(
                    alignment: Alignment(basketX, 0.9),
                    child: Image.asset(
                      'assets/happy_meal_box.png',
                      width: 100,
                      height: 80,
                      fit: BoxFit.contain,
                    ),
                  ),

                  // Start button
                  if (!isPlaying)
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade700,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 15,
                          ),
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: startGame,
                        child: const Text("Start Game 🍟"),
                      ),
                    ),
                ],
              ),
            ),
          ),
          // Back button
          Positioned(
            top: 32,
            left: 8,
            child: SafeArea(
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.red, size: 32),
                onPressed: () {
                  Navigator.pop(context);
                },
                tooltip: "Back to Home",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
