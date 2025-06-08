import 'package:flame/components.dart';
import 'package:new_era/Games/craby_saves_game.dart';

class Crab extends SpriteComponent with HasGameRef<CrabGuardianGame> {
  int direction = 0; // -1: left, 1: right, 0: idle
  final double speed = 200; // pixels per second

  Crab() : super(size: Vector2(64, 64));

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('craby.png'); // Ensure correct asset path
    position = Vector2(100, 400); // starting position
  }

  void setDirection(int dir) {
    direction = dir;
  }

  void updateMovement(double dt) {
    position.x += direction * speed * dt;

    // Clamp position to keep crab within screen bounds
    position.x = position.x.clamp(0, gameRef.size.x - size.x);
  }
}
