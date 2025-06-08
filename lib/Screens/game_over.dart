import 'package:flutter/material.dart';
import 'game_page.dart';
import 'game_menu.dart';

class GameOverPage extends StatelessWidget {
  final int score;

  const GameOverPage({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Belajar lagi ya dek",
              style: TextStyle(
                fontSize: 36,
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Skor Akhir: $score",
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            SizedBox(height: 30),
            
             
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const GamePage()),
                );
              },
              child: Text("Main Lagi"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const GameMenuPage()),
                );
              },
              child: Text("Kembali ke Menu"),
            ),
          ],
        ),
      ),
    );
  }
}
