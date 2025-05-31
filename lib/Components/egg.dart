import 'package:flame/components.dart';
import 'package:flame/game.dart';

class Egg extends SpriteComponent with HasGameRef {
  Egg() : super(size: Vector2(48, 48));

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('egg.png');
    position = Vector2(175, gameRef.size.y - 120);
  }
}
