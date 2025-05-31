import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:new_era/Games/craby_saves_game.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    final game = CrabGuardianGame();

    return GameWidget(
      game: game,
      overlayBuilderMap: {
        'GameOver': (context, _) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Game Over', style: TextStyle(fontSize: 32, color: Colors.white)),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Kembali ke menu
                  },
                  child: const Text('Kembali ke Menu'),
                ),
              ],
            ),
          );
        },
      },
    );
  }
}
