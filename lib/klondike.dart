import 'dart:io';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_app/components/card.dart';
import 'package:flame_app/components/foundation.dart';
import 'package:flame_app/components/pile.dart';
import 'package:flame_app/components/stock.dart';
import 'package:flame_app/components/waste.dart';
import 'package:flame_app/constants.dart';
import 'package:flame_app/sprite_map.dart';
import 'package:xml/xml.dart';
import 'dart:math';

class Klondike extends FlameGame {
  static const double cardGap = 17.50;
  static const double cardWidth = 100;
  static const double cardHeight = 140;
  static const double cardRadius = 10;
  static final Vector2 cardSize = Vector2(cardWidth, cardHeight);

  static late final List<SpriteMap> spriteMap;
  @override
  bool get debugMode => true;
  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    await Flame.images.load('klondike-sprites.png');
    final file = File('assets/spritesheets.xml');
    var document = XmlDocument.parse(file.readAsStringSync());
    var spritesheet = document.findAllElements('SubTexture').toList();
    List<SpriteMap> loadedSpriteMap = [];
    for (var e in spritesheet) {
      loadedSpriteMap.add(SpriteMap.fromXml(e));
    }
    spriteMap = loadedSpriteMap;
    final stock = Stock()
      ..size = cardSize
      ..position = Vector2(cardGap, cardGap);

    final waste = Waste()
      ..size = cardSize
      ..position = Vector2(cardGap * 2 + cardWidth, cardGap);
    final foundations = List.generate(
      4,
      (i) => Foundation()
        ..size = cardSize
        ..position =
            Vector2((i + 3) * (cardWidth + cardGap) + cardGap, cardGap),
    );
    final piles = List.generate(
      7,
      (i) => Pile()
        ..size = cardSize
        ..position = Vector2(
          cardGap + i * (cardWidth + cardGap),
          cardHeight + 2 * cardGap,
        ),
    );
    final world = World();

    final camera = CameraComponent(world: world)
      ..viewfinder.visibleGameSize =
          Vector2(cardWidth * 7 + cardGap * 8, 4 * cardHeight + 3 * cardGap)
      ..viewfinder.position = Vector2(cardWidth * 3.5 + cardGap * 4, 0)
      ..viewfinder.anchor = Anchor.topCenter;
    add(stock);
    add(waste);
    addAll(foundations);
    addAll(piles);
    final random = Random();
    for (var i = 0; i < 7; i++) {
      for (var j = 0; j < 4; j++) {
        final card = Card((random.nextInt(13) + 1).toString(),
            CardSuit.values[random.nextInt(4)])
          ..position = Vector2(100 + i * 1150, 100 + j * 1500);
        add(card);
        // flip the card face-up with 90% probability
        if (random.nextDouble() < 0.9) {
          card.flip();
        }
      }
    }
  }
}

List<Sprite> klondikeSprite(String cardRank, CardSuit suit) {
  if (suit == CardSuit.hearts || suit == CardSuit.diamonds) {
    cardRank += "y";
  } else if (suit == CardSuit.spades || suit == CardSuit.clubs) {
    cardRank += "b";
  }
  var cardrankSprite =
      Klondike.spriteMap.where((element) => element.name == cardRank).first;
  var suitSprite =
      Klondike.spriteMap.where((element) => element.name == suit.name).first;
  if (suit != CardSuit.back) {
    return [
      Sprite(
        Flame.images.fromCache('klondike-sprites.png'),
        srcPosition: Vector2(cardrankSprite.x, cardrankSprite.y),
        srcSize: Vector2(cardrankSprite.width, cardrankSprite.height),
      ),
      Sprite(
        Flame.images.fromCache('klondike-sprites.png'),
        srcPosition: Vector2(suitSprite.x, suitSprite.y),
        srcSize: Vector2(suitSprite.width, suitSprite.height),
      ),
    ];
  } else {
    return [
      Sprite(
        Flame.images.fromCache('klondike-sprites.png'),
        srcPosition: Vector2(suitSprite.x, suitSprite.y),
        srcSize: Vector2(suitSprite.width, suitSprite.height),
      ),
    ];
  }
}
