import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../components/tree_component.dart';

class AgacGame extends FlameGame {
  int totalApricots = 0;
  late TextComponent scoreText;
  @override
  Color backgroundColor() => const Color(0xFF8BC34A);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    scoreText = TextComponent(
      text: 'Toplanan Kayısı: 0',
      position: Vector2(size.x / 2, 20),
      anchor: Anchor.topCenter,
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    add(scoreText);

    final double treeSize = size.x * 0.25;

    addAll([
      TreeComponent(
        position: Vector2(20, 20),
        size: Vector2.all(treeSize),
        onPicked: _incrementScore,
      ), // Sol üst
      TreeComponent(
        position: Vector2(20, size.y - treeSize - 20),
        size: Vector2.all(treeSize),
        onPicked: _incrementScore,
      ), // Sol alt
      TreeComponent(
        position: Vector2(size.x - treeSize - 20, 20),
        size: Vector2.all(treeSize),
        onPicked: _incrementScore,
      ), // Sağ üst
      TreeComponent(
        position: Vector2(size.x - treeSize - 20, size.y - treeSize - 20),
        size: Vector2.all(treeSize),
        onPicked: _incrementScore,
      ), // Sağ alt
    ]);
  }

  void _incrementScore() {
    totalApricots += 5;
    scoreText.text = 'Toplanan Kayısı: $totalApricots';
  }
}
