// Try to use material.dart over cupertino.dart, there are some minor differences between the two
import 'package:flutter/material.dart';
// In fact a good practice is to import all three.
// import 'package:flutter/cupertino.dart'; // Cupertino is IOS mechanics
// import 'package:flutter/material.dart'; // Material is android mechanics
// import 'package:flutter/foundation.dart'; // Foundation is the base library

enum CardSuit {
  spades,
  hearts,
  diamonds,
  clubs,
}

enum CardType {
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  ten,
  jack,
  queen,
  king,
}

enum CardColor {
  red,
  black,
}

class PlayingCard {
  CardSuit cardSuit;
  CardType cardType;
  bool faceUp;
  bool opened;

  PlayingCard({
    @required this.cardSuit,
    @required this.cardType,
    this.faceUp = false,
    this.opened = false, // may be subject to change
  });

  CardColor get cardColor => cardSuit == CardSuit.hearts || cardSuit == CardSuit.diamonds ? CardColor.red : CardColor.black;
}
