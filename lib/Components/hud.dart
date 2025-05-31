import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

class Hud extends TextComponent {
  int _lives;
  int _score;

  Hud({required int lives, required int score})
      : _lives = lives,
        _score = score,
        super(
          position: Vector2(10, 10),
          priority: 1,
        ) {
    text = 'Lives: $_lives   Score: $_score';
    textRenderer = TextPaint(
      style: const TextStyle(
        fontSize: 24,
        color: Color(0xFFFFFFFF),
      ),
    );
  }

  set updateLives(int value) {
    _lives = value;
    _updateText();
  }

  set updateScore(int value) {
    _score = value;
    _updateText();
  }

  void _updateText() {
    text = 'Lives: $_lives   Score: $_score';
  }
}
