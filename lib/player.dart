import 'package:flame/cache.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:game_2d/enemy.dart';
import 'package:game_2d/my_game.dart';

class Player extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<MyGame> {
  Images images;
  double startX = 0.0;
  double startY = 0.0;
  double speedY = 0.0;
  bool isCrash = false;

  Player(this.images);

  @override
  Future<void> onLoad() async {
    animation = SpriteAnimation.fromFrameData(
        images.fromCache('run.png'),
        SpriteAnimationData.sequenced(
            amount: 22, stepTime: 0.15, textureSize: Vector2(128, 163)));

    add(SpriteAnimationComponent(animation: animation));
  }

  @override
  void onMount() {
    y = startY;
    x = startX;
    add(RectangleHitbox());
    super.onMount();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoint, PositionComponent other) {
    if ((other is Enemy) && (!isCrash)) {
      crash();
    }
    super.onCollision(intersectionPoint, other);
  }

  crash() {
    isCrash = true;
    gameRef.pauseEngine();
  }

  @override
  void onGameResize(Vector2 size) {
    startY = size.y - (size.y / 5);
    startX = 100;
    // TODO: implement onGameResize
    super.onGameResize(size);
  }

  jump() {
    if (isOnGround) {
      speedY = 20;
    }
  }

  @override
  void update(double dt) {
    y -= speedY;
    speedY = speedY - 1;
    if (isOnGround) {
      y = startY;
      speedY = 0.0;
    }
    super.update(dt);
  }

  bool get isOnGround => (y >= startY);
}
