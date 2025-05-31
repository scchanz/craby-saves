import 'package:flame/components.dart';

class Trash extends SpriteComponent with HasGameRef {
  final double startX;
  final double speed = 150; // kecepatan turun sampah

  Trash(this.startX) : super(size: Vector2(32, 32));

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('trash.png');
    position = Vector2(startX, 0);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += speed * dt;

    // Hilangkan sampah jika sudah melewati bawah layar
    if (position.y > gameRef.size.y) {
      removeFromParent();
    }
  }
}
