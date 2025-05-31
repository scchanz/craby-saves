import 'package:flame/components.dart';
import 'package:flame/game.dart';

class Crab extends SpriteComponent with HasGameRef {
  Crab() : super(size: Vector2(64, 64));

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('crab.png');
    position = Vector2(100, gameRef.size.y - 80);
  }

  void moveTo(double x) {
    position.x = x;
  }
}
