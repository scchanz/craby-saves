import 'dart:math';

import 'package:flame/game.dart';
import 'package:flame/events.dart';
import 'package:new_era/Components/crabs.dart';
import 'package:new_era/Components/egg.dart';
import 'package:new_era/Components/hud.dart';
import 'package:new_era/Components/trash.dart';


class CrabGuardianGame extends FlameGame with TapDetector, HasCollisionDetection {
  late Crab crab;
  late Egg egg;
  late Hud hud;

  int lives = 5;
  int score = 0;
  double spawnTimer = 0.0;
  double spawnInterval = 2.0; // sampah muncul setiap 2 detik
  final Random random = Random();

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'crab.png',
      'egg.png',
      'trash.png',
    ]);

    crab = Crab();
    egg = Egg();
    hud = Hud(lives: lives, score: score);

    await add(crab);
    await add(egg);
    await add(hud);
  }

  @override
  void update(double dt) {
    super.update(dt);

    spawnTimer += dt;
    if (spawnTimer >= spawnInterval) {
      spawnTimer = 0;
      spawnTrash();
    }

    // Cek tabrakan antara trash dan egg
    for (final component in children) {
      if (component is Trash) {
        if (component.toRect().overlaps(egg.toRect())) {
          component.removeFromParent();
          lives--;
          hud.updateLives = lives;
          if (lives <= 0) {
            overlays.add('GameOver');
            pauseEngine();
          }
        }
      }
    }

    // Tambahkan score jika trash melewati crab
    for (final component in children) {
      if (component is Trash && component.position.y > size.y) {
        component.removeFromParent();
        score++;
        hud.updateScore = score;
      }
    }
  }

  void spawnTrash() {
    double x = random.nextDouble() * (size.x - 32);
    add(Trash(x));
  }

  @override
  void onTapDown(TapDownInfo info) {
    final tapX = info.eventPosition.global.x;
    crab.moveTo(tapX);
  }
}
