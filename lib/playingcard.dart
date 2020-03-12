import 'package:flutter/cupertino.dart';



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

String findAsset(CardSuit s, CardType t) {
  String str;
  switch (t) {
    case CardType.one:
      str = 'A';
      break;
    case CardType.two:
      str = '2';
      break;
    case CardType.three:
      str = '3';
      break;
    case CardType.four:
      str = '4';
      break;
    case CardType.five:
      str = '5';
      break;
    case CardType.six:
      str = '6';
      break;
    case CardType.seven:
      str = '7';
      break;
    case CardType.eight:
      str = '8';
      break;
    case CardType.nine:
      str = '9';
      break;
    case CardType.ten:
      str = '10';
      break;
    case CardType.jack:
      str = 'J';
      break;
    case CardType.queen:
      str = 'Q';
      break;
    case CardType.king:
      str = 'K';
      break;
    default: 
      str = 'A';
      break;
  }
  switch (s) {
    case CardSuit.spades:
      str += 'S';
      break;
    case CardSuit.hearts:
      str += 'H';
      break;
    case CardSuit.diamonds:
      str += 'D';
      break;
    case CardSuit.clubs:
      str += 'C';
      break;
  }
  return 'assets/cards/' + str + '.png';
}

class PlayingCard {
  CardSuit cardSuit;
  CardType cardType;
  Image image;
  bool faceUp;
  bool opened;

  PlayingCard({
    @required this.cardSuit,
    @required this.cardType,
    this.image,
    this.faceUp = false,
    this.opened = false, // may be subject to change
  }) {
    this.image = Image.asset(findAsset(this.cardSuit, this.cardType), scale: 8);
  }

  CardColor get cardColor => cardSuit == CardSuit.hearts || cardSuit == CardSuit.diamonds ? CardColor.red : CardColor.black;
}