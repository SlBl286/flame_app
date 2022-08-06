import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame_app/constants.dart';
import 'package:flame_app/klondike.dart';
import 'dart:math' as math;

class Card extends PositionComponent {
  final String rank;
  final CardSuit suit;
  bool _faceUp;
  Card(String cardRank, CardSuit cardSuit)
      : rank = (cardSuit == CardSuit.diamonds || cardSuit == CardSuit.hearts)
            ? "${cardRank}y"
            : "${cardRank}b",
        suit = cardSuit,
        _faceUp = false,
        super(size: Klondike.cardSize);
  bool get isFaceUp => _faceUp;

  void flip() => _faceUp = !_faceUp;
  @override
  String toString() => "$rank $suit";
  @override
  void render(Canvas canvas) {
    if (_faceUp) {
      _renderFront(canvas);
    } else {
      _renderBack(canvas);
    }
  }

  static final Paint backBackgroundPaint = Paint()
    ..color = const Color(0xff380c02);
  static final Paint backBorderPaint1 = Paint()
    ..color = const Color(0xffdbaf58)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 10;
  static final Paint backBorderPaint2 = Paint()
    ..color = const Color(0x5CEF971B)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 35;
  static final RRect cardRRect = RRect.fromRectAndRadius(
    Klondike.cardSize.toRect(),
    const Radius.circular(Klondike.cardRadius),
  );
  static final RRect backRRectInner = cardRRect.deflate(40);
  static late final Sprite flameSprite =
      klondikeSprite("null", CardSuit.back).first;

  void _renderBack(Canvas canvas) {
    canvas.drawRRect(cardRRect, backBackgroundPaint);
    canvas.drawRRect(cardRRect, backBorderPaint1);
    canvas.drawRRect(backRRectInner, backBorderPaint2);
    flameSprite.render(canvas, position: size / 2, anchor: Anchor.center);
  }

  static final Paint frontBackgroundPaint = Paint()
    ..color = const Color(0xff000000);
  static final Paint yellowBorderPaint = Paint()
    ..color = const Color(0xffece8a3)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 10;
  static final Paint blueBorderPaint = Paint()
    ..color = const Color(0xff7ab2e8)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 10;
  static final blueFilter = Paint()
    ..colorFilter = const ColorFilter.mode(
      Color(0x880d8bff),
      BlendMode.srcATop,
    );

  void _renderFront(Canvas canvas) {
    canvas.drawRRect(cardRRect, frontBackgroundPaint);
    canvas.drawRRect(
      cardRRect,
      suit.isYellow ? yellowBorderPaint : blueBorderPaint,
    );

    _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.1, 0.08);
    _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.1, 0.18, scale: 0.5);
    _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.1, 0.08, rotate: true);
    _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.1, 0.18,
        scale: 0.5, rotate: true);
    switch (rank) {
      case "A":
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.5, 0.5,
            scale: 2.5);
        break;
      case "2":
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.5, 0.25);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.5, 0.25,
            rotate: true);
        break;
      case "3":
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.5, 0.2);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.5, 0.5);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.5, 0.2,
            rotate: true);
        break;
      case "4":
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.3, 0.25);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.7, 0.25);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.3, 0.25,
            rotate: true);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.7, 0.25,
            rotate: true);
        break;
      case "5":
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.3, 0.25);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.7, 0.25);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.3, 0.25,
            rotate: true);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.7, 0.25,
            rotate: true);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.5, 0.5);
        break;
      case "6":
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.3, 0.25);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.7, 0.25);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.3, 0.5);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.7, 0.5);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.3, 0.25,
            rotate: true);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.7, 0.25,
            rotate: true);
        break;
      case "7":
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.3, 0.2);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.7, 0.2);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.5, 0.35);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.3, 0.5);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.7, 0.5);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.3, 0.2,
            rotate: true);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.7, 0.2,
            rotate: true);
        break;
      case "8":
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.3, 0.2);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.7, 0.2);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.5, 0.35);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.3, 0.5);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.7, 0.5);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.3, 0.2,
            rotate: true);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.7, 0.2,
            rotate: true);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.5, 0.35,
            rotate: true);
        break;
      case "9":
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.3, 0.2);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.7, 0.2);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.5, 0.3);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.3, 0.4);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.7, 0.4);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.3, 0.2,
            rotate: true);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.7, 0.2,
            rotate: true);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.3, 0.4,
            rotate: true);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.7, 0.4,
            rotate: true);
        break;
      case "10":
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.3, 0.2);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.7, 0.2);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.5, 0.3);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.3, 0.4);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.7, 0.4);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.3, 0.2,
            rotate: true);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.7, 0.2,
            rotate: true);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.5, 0.3,
            rotate: true);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.3, 0.4,
            rotate: true);
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.7, 0.4,
            rotate: true);
        break;
      case "J":
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.5, 0.5);
        break;
      case "Q":
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.5, 0.5);
        break;
      case "K":
        _drawSprite(canvas, klondikeSprite(rank, suit)[1], 0.5, 0.5);
        break;
    }
  }

  void _drawSprite(
    Canvas canvas,
    Sprite sprite,
    double relativeX,
    double relativeY, {
    double scale = 1,
    bool rotate = false,
  }) {
    if (rotate) {
      canvas.save();
      canvas.translate(size.x / 2, size.y / 2);
      canvas.rotate(math.pi);
      canvas.translate(-size.x / 2, -size.y / 2);
    }
    sprite.render(
      canvas,
      position: Vector2(relativeX * size.x, relativeY * size.y),
      anchor: Anchor.center,
      size: sprite.srcSize.scaled(scale),
    );
    if (rotate) {
      canvas.restore();
    }
  }
}
