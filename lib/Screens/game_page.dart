import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:new_era/Screens/game_over.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  double crabyX = 0;
  double eggX = 0;
  double eggY = -1;
  int score = 0;
  int lives = 3;
  bool isGameOver = false;

  Timer? gameTimer;
  Timer? moveLeftTimer;
  Timer? moveRightTimer;

  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    startEggDrop();
  }

  Future<void> playCatchSound() async {
    await _audioPlayer.play(AssetSource('assets/sounds/catch.wav'));
  }

  Future<void> playGameOverSound() async {
    await _audioPlayer.play(AssetSource('assets/sounds/gameover.mp3'));
  }

  void startEggDrop() {
    resetEgg();
    gameTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (!mounted || isGameOver) return;

      setState(() {
        eggY += 0.02;

        // Tangkap saat telur dekat Craby (posisi lebih ke atas, jadi eggY threshold lebih rendah)
        if ((eggX - crabyX).abs() < 0.3 && eggY >= 0.50) {
          score++;
          playCatchSound();
          resetEgg(); // langsung hilang
          return;
        }

        // Telur jatuh ke bawah (tidak tertangkap)
        if (eggY >= 1) {
          lives--;
          if (lives <= 0) {
            isGameOver = true;
            timer.cancel();
            playGameOverSound();
            // pindah ke halaman GameOver dengan skor
            Future.delayed(const Duration(milliseconds: 500), () {
              if (mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => GameOverPage(score: score)),
                );
              }
            });
            return;
          }
          resetEgg();
        }
      });
    });
  }

  void resetEgg() {
    final random = Random();
    eggX = (random.nextDouble() * 2) - 1; // -1 to 1
    eggY = -1;
  }

  void moveLeft() {
    setState(() {
      crabyX -= 0.1; // Increase speed
      if (crabyX < -1) crabyX = -1;
    });
  }

  void moveRight() {
    setState(() {
      crabyX += 0.1; // Increase speed
      if (crabyX > 1) crabyX = 1;
    });
  }

  void startHoldLeft() {
    moveLeft();
    moveLeftTimer = Timer.periodic(
      const Duration(milliseconds: 40),
      (_) => moveLeft(),
    );
  }

  void startHoldRight() {
    moveRight();
    moveRightTimer = Timer.periodic(
      const Duration(milliseconds: 50),
      (_) => moveRight(),
    );
  }

  void stopHold() {
    moveLeftTimer?.cancel();
    moveRightTimer?.cancel();
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    moveLeftTimer?.cancel();
    moveRightTimer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Stack(
        children: [
          // Telur
          if (!isGameOver)
            Positioned(
              left: MediaQuery.of(context).size.width * (eggX + 1) / 2 - 20,
              top: MediaQuery.of(context).size.height * (eggY + 1) / 2 - 20,
              child: Image.asset(
                'assets/images/egg.png',
                width: 40,
                height: 40,
              ),
            ),

          // Craby (posisi lebih ke atas)
          Align(
            alignment: Alignment(0, 0.6),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              alignment: Alignment(crabyX, 0.6),
              child: Image.asset(
                'assets/images/craby.png',
                width: 100,
                height: 100,
              ),
            ),
          ),

          // Tombol Kiri & Kanan
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: moveLeft,
                    onLongPressStart: (_) => startHoldLeft(),
                    onLongPressEnd: (_) => stopHold(),
                    child: ElevatedButton(
                      onPressed: moveLeft,
                      child: const Icon(Icons.arrow_left),
                    ),
                  ),
                  GestureDetector(
                    onTap: moveRight,
                    onLongPressStart: (_) => startHoldRight(),
                    onLongPressEnd: (_) => stopHold(),
                    child: ElevatedButton(
                      onPressed: moveRight,
                      child: const Icon(Icons.arrow_right),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Skor & Nyawa
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Skor: $score", style: const TextStyle(fontSize: 20)),
                  Text("❤️ $lives", style: const TextStyle(fontSize: 20)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
