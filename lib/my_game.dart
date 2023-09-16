import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:game_2d/enemy.dart';
import 'package:game_2d/player.dart';

class MyGame extends FlameGame with TapDetector, HasCollisionDetection {
  static const ImageAssets = ['run.png', 'bug.png'];
  late Player player;

  Color backgroundColor() => Colors.red;

  @override
  Future<void> onLoad() async {
    await images.loadAll(ImageAssets);

    final parallaxBackGround = await loadParallaxComponent(
        [ParallaxImageData("parallax/cartoon_parallax_2d.png")],
        baseVelocity: Vector2(50, 0),
        repeat: ImageRepeat.repeatX,
        velocityMultiplierDelta: Vector2(1, 4));

    player = Player(images);
    Enemy enemy = Enemy(images);

    add(parallaxBackGround);
    add(player
      ..size = (Vector2.all(100))
      ..anchor = Anchor.center);

    add(enemy
      ..size = Vector2.all(100)
      ..anchor = Anchor.bottomRight);
  }

  @override
  void onTap() {
    player.jump();
  }
}
