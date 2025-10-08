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
        foodY += 0.04; // slightly slower and more natural drop
      });

      // Collision detection — closer to basket
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
      barrierDismissible: false, // must click "Home"
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
              Navigator.pop(context); // close dialog
              Navigator.pop(context); // return to home
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
      body: GestureDetector(
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
                left: 20,
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

              // Basket (red & yellow like McDonald’s)
              Align(
                alignment: Alignment(basketX, 0.9),
                child: Container(
                  width: 90,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.red.shade700,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.yellow.shade600, width: 4),
                  ),
                  child: const Icon(
                    Icons.shopping_basket,
                    color: Colors.white,
                    size: 40,
                  ),
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
    );
  }
}
