import 'package:agac_game/game/agac_game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class TreeComponent extends SpriteComponent
    with HasGameReference<AgacGame>, TapCallbacks {
  final VoidCallback? onPicked;
  late Sprite bosAgac;
  late Sprite doluAgac;
  late Timer progressTimer;
  bool hasFruit = false;

  late RectangleComponent progressBarBackground;
  late RectangleComponent progressBarForeground;

  TreeComponent({
    required Vector2 position,
    required Vector2 size,
    this.onPicked,
  }) : super(position: position, size: Vector2(200, 200));

  @override
  Future<void> onLoad() async {
    bosAgac = await game.loadSprite('agac_bos.png');
    doluAgac = await game.loadSprite('agac_dolu.png');
    sprite = bosAgac;

    progressTimer = Timer(
      3,
      onTick: () {
        hasFruit = true;
        sprite = doluAgac;
      },
    );
    progressTimer.start();

    progressBarBackground = RectangleComponent(
      position: Vector2(0, size.y + 5),
      size: Vector2(size.x, 5),
      paint: Paint()..color = const Color.fromARGB(255, 255, 0, 0),
    );

    progressBarForeground = RectangleComponent(
      position: Vector2(0, size.y + 5),
      size: Vector2(0, 5),
      paint: Paint()..color = const Color.fromARGB(255, 255, 255, 255),
    );

    add(progressBarBackground);
    add(progressBarForeground);
  }

  @override
  void update(double dt) {
    progressTimer.update(dt);
    super.update(dt);
    final double progress = hasFruit ? 1.0 : progressTimer.progress;
    progressBarForeground.size.x = size.x * progress;
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (hasFruit) {
      hasFruit = false;
      sprite = bosAgac;
      progressTimer.stop();
      progressTimer.start();

      if (onPicked != null) {
        onPicked!();
      }
    }
  }
}
