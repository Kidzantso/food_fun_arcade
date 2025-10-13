import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class MemoryMatchScreen extends StatefulWidget {
  final Function(int) onGameEnd;
  const MemoryMatchScreen({super.key, required this.onGameEnd});

  @override
  State<MemoryMatchScreen> createState() => _MemoryMatchScreenState();
}

class _MemoryMatchScreenState extends State<MemoryMatchScreen> {
  List<String> icons = ['🍔', '🍟', '🥤', '🍦', '🍩', '🍪'];

  late List<String> cards;
  late List<bool> revealed;
  int score = 0;
  int timeLeft = 60;
  bool isPlaying = false;
  int? firstIndex;
  bool isLocked = false; // prevents tapping new cards while waiting to close
  Timer? timer;

  @override
  void initState() {
    super.initState();
    // Initialize empty cards so no late initialization error occurs
    cards = [];
    revealed = [];
  }

  void startGame() {
    cards = [...icons, ...icons]..shuffle(Random());
    revealed = List.filled(cards.length, false);
    score = 0;
    timeLeft = 60;
    firstIndex = null;
    isPlaying = true;
    isLocked = false;

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (timeLeft > 0) {
        setState(() => timeLeft--);
      } else {
        endGame();
      }
    });
    setState(() {});
  }

  void onCardTap(int index) {
    if (!isPlaying || revealed[index] || isLocked) return;

    setState(() {
      revealed[index] = true;
    });

    if (firstIndex == null) {
      firstIndex = index;
    } else {
      if (cards[firstIndex!] == cards[index]) {
        score += 10;
        firstIndex = null;
      } else {
        isLocked = true;
        Future.delayed(const Duration(milliseconds: 700), () {
          setState(() {
            revealed[firstIndex!] = false;
            revealed[index] = false;
            firstIndex = null;
            isLocked = false;
          });
        });
      }
    }

    if (revealed.isNotEmpty && revealed.every((r) => r)) {
      endGame();
    }
  }

  void endGame() {
    timer?.cancel();
    isPlaying = false;
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
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text("🧠 Memory Match"),
        backgroundColor: Colors.yellow[700],
        foregroundColor: Colors.red[800],
      ),
      body: isPlaying
          ? Column(
              children: [
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
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                    itemCount: cards.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => onCardTap(index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            color: revealed[index]
                                ? Colors.yellow[700]
                                : Colors.red[900],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.yellow.shade300,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              revealed[index] ? cards[index] : "❓",
                              style: const TextStyle(
                                fontSize: 32,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
          : Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow[700],
                  foregroundColor: Colors.red[800],
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
                child: const Text("Start Game 🎯"),
              ),
            ),
    );
  }
}
