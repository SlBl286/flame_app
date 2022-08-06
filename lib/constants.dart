enum CardSuit { hearts, diamonds, clubs, spades, back }

extension CardSuitNameExtension on CardSuit {
  String get name {
    switch (this) {
      case CardSuit.hearts:
        return "Hearts";
      case CardSuit.diamonds:
        return "Diamonds";
      case CardSuit.clubs:
        return "Clubs";
      case CardSuit.spades:
        return "Spades";
      default:
        return "CardBack";
    }
  }
}

extension CardSuitIsYellowExtension on CardSuit {
  bool get isYellow {
    switch (this) {
      case CardSuit.hearts:
      case CardSuit.diamonds:
        return true;
      case CardSuit.clubs:
      case CardSuit.spades:
        return false;
      default:
        return false;
    }
  }
}
