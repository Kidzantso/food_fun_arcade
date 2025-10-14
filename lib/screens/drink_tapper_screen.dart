import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class DrinkTapperScreen extends StatefulWidget {
  final Function(int) onGameEnd;
  const DrinkTapperScreen({super.key, required this.onGameEnd});

  @override
  State<DrinkTapperScreen> createState() => _DrinkTapperScreenState();
}

class _DrinkTapperScreenState extends State<DrinkTapperScreen> {
  int score = 0;
  int timeLeft = 30;
  bool isPlaying = false;
  double drinkX = 0;
  double drinkY = 0;
  bool showDrink = false;
  Timer? gameTimer;
  Timer? drinkTimer;
  Random random = Random();

  final List<String> drinkImages = [
    'assets/drink.png',
    'assets/fries.png',
    'assets/burger.png',
  ];
  late String currentDrink;

  @override
  void initState() {
    super.initState();
    currentDrink = drinkImages[random.nextInt(drinkImages.length)];
  }

  void startGame() {
    setState(() {
      score = 0;
      timeLeft = 30;
      isPlaying = true;
    });

    spawnDrink();

    gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        setState(() => timeLeft--);
      } else {
        endGame();
      }
    });
  }

  double drinkVisibleTime = 800; // milliseconds
  int drinkSpawnRate = 1000; // milliseconds

  void spawnDrink() {
    drinkTimer?.cancel();

    drinkTimer = Timer.periodic(Duration(milliseconds: drinkSpawnRate), (
      timer,
    ) {
      if (!isPlaying) return;

      setState(() {
        drinkX = (random.nextDouble() * 2) - 1;
        drinkY = (random.nextDouble() * 1.5) - 0.75;
        currentDrink = drinkImages[random.nextInt(drinkImages.length)];
        showDrink = true;
      });

      Future.delayed(Duration(milliseconds: drinkVisibleTime.toInt()), () {
        if (mounted && isPlaying && showDrink) {
          setState(() => showDrink = false);
        }
      });
    });
  }

  void onTapDown(TapDownDetails details) {
    if (!isPlaying || !showDrink) return;

    final box = context.findRenderObject() as RenderBox;
    final localPos = box.globalToLocal(details.globalPosition);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final drinkPosX = (drinkX + 1) / 2 * screenWidth;
    final drinkPosY = (drinkY + 1) / 2 * screenHeight;
    const drinkSize = 100.0;
    const tolerance = 60.0;

    final dx = (localPos.dx - drinkPosX).abs();
    final dy = (localPos.dy - drinkPosY).abs();

    if (dx < drinkSize / 2 + tolerance && dy < drinkSize / 2 + tolerance) {
      setState(() {
        score += 10;
        showDrink = false;

        // 🔄 Gradual difficulty scaling
        drinkSpawnRate = max((drinkSpawnRate * 0.98).toInt(), 450);
        drinkVisibleTime = max((drinkVisibleTime * 0.985), 450.0);

        spawnDrink();
      });
    }
  }

  void endGame() {
    gameTimer?.cancel();
    drinkTimer?.cancel();
    setState(() => isPlaying = false);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.yellow[50],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          "🎉 Great Job!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF8B0000),
            fontSize: 24,
          ),
        ),
        content: Text(
          "Your final score is: $score ⭐",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18, color: Colors.black87),
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
    drinkTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text("🥤 Drink Tapper"),
        backgroundColor: Colors.yellow[700],
        foregroundColor: Colors.red[800],
      ),
      body: GestureDetector(
        onTapDown: onTapDown,
        child: Stack(
          children: [
            if (isPlaying) ...[
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "⭐ $score",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 0, 0),
                      ),
                    ),
                    Text(
                      "⏰ $timeLeft s",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 0, 0),
                      ),
                    ),
                  ],
                ),
              ),
              if (showDrink)
                Align(
                  alignment: Alignment(drinkX, drinkY),
                  child: Image.asset(currentDrink, width: 100),
                ),
            ],
            if (!isPlaying)
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow[700],
                    foregroundColor: Colors.red[800],
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: startGame,
                  child: const Text("Start Game 🎮"),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
