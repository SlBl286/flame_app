import 'package:flame/game.dart';
import 'package:flame_app/klondike.dart';
import 'package:flutter/material.dart';

void main() {
  final klondike = Klondike();
  runApp(
    GameWidget(
      game: klondike,
    ),
  );
}
