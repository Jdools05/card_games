import 'dart:math';
import 'package:cardgames/widgets/playing_card.dart';
import 'package:cardgames/providers/provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SolitaireProvider with ChangeNotifier {

  Random random;

  SolitaireProvider({@required this.random}) {
    populateCards();
  }

  List<PlayingCard> _allCards = [];

// each list is a column in the solitaire field
  List<List<PlayingCard>> _cardColumns = List.filled(7, []);

  List<PlayingCard> _unknownCards = [];
  List<PlayingCard> _cardDeckOpened = [];

  List<PlayingCard> _finalHeartDeck = [];
  List<PlayingCard> _finalDiamondDeck = [];
  List<PlayingCard> _finalSpadesDeck = [];
  List<PlayingCard> _finalClubsDeck = [];

  int _rand = 0;

  int get rand => _rand;
  set rand(int value) {
    _rand = value;
    notifyListeners();
  }

  void randomizeCard() {
    _rand = random.nextInt(allCards.length);
    notifyListeners();
  }

  void populateCards() {
    CardSuit.values.forEach((suit) {
      CardValue.values.forEach((value) {
        allCards.add(new PlayingCard(
          value: value,
          suit: suit,
          faceUp: true,
        ));
      });
    });
    shuffle(allCards);

    for (int i = 0; i < 7; i++) {
      for (int w = 0; w < 7; w++) {
        if (w >= i) {
          int randomInt = random.nextInt(allCards.length);
          PlayingCard card = allCards[randomInt];
          cardColumns[i].add(card..open());
          allCards.removeAt(randomInt);
        }
      }
    }

    unknownCards = allCards;
    cardDeckOpened.add(
      unknownCards.removeLast()
          ..open()
          ..flip()
    );

    cardColumns.forEach((column) {
      column.elementAt(column.length - 1)..faceUp = true;
    });

    notifyListeners();
  }

  List<PlayingCard> get allCards => _allCards;
  set allCards(List<PlayingCard> value) {
    _allCards = value;
    notifyListeners();
  }

  List<List<PlayingCard>> get cardColumns => _cardColumns;
  set cardColumns(List<List<PlayingCard>> value) {
    _cardColumns = value;
    notifyListeners();
  }

  List<PlayingCard> get finalClubsDeck => _finalClubsDeck;
  set finalClubsDeck(List<PlayingCard> value) {
    _finalClubsDeck = value;
    notifyListeners();
  }

  List<PlayingCard> get finalSpadesDeck => _finalSpadesDeck;
  set finalSpadesDeck(List<PlayingCard> value) {
    _finalSpadesDeck = value;
    notifyListeners();
  }

  List<PlayingCard> get finalDiamondDeck => _finalDiamondDeck;
  set finalDiamondDeck(List<PlayingCard> value) {
    _finalDiamondDeck = value;
    notifyListeners();
  }

  List<PlayingCard> get finalHeartDeck => _finalHeartDeck;
  set finalHeartDeck(List<PlayingCard> value) {
    _finalHeartDeck = value;
    notifyListeners();
  }

  List<PlayingCard> get cardDeckOpened => _cardDeckOpened;
  set cardDeckOpened(List<PlayingCard> value) {
    _cardDeckOpened = value;
    notifyListeners();
  }

  List<PlayingCard> get unknownCards => _unknownCards;
  set unknownCards(List<PlayingCard> value) {
    _unknownCards = value;
    notifyListeners();
  }

  void removeLastCard(List<PlayingCard> list) {
    list.removeLast();
    notifyListeners();
  }

  void shuffle(List<PlayingCard> cards) {
    for (int i = 0; i < 7; i++) cards.shuffle(random);
    notifyListeners();
  }

  void transferCard(PlayingCard card, List<PlayingCard> moveTo) {
    for (int i = 0; i < 13; i++) {
      switch (i) {
        case 7:
          if (unknownCards.contains(card)) unknownCards.remove(card);
          break;
        case 8:
          if (cardDeckOpened.contains(card)) cardDeckOpened.remove(card);
          break;
        case 9:
          if (finalClubsDeck.contains(card)) finalClubsDeck.remove(card);
          break;
        case 10:
          if (finalDiamondDeck.contains(card)) finalDiamondDeck.remove(card);
          break;
        case 11:
          if (finalHeartDeck.contains(card)) finalHeartDeck.remove(card);
          break;
        case 12:
          if (finalSpadesDeck.contains(card)) finalSpadesDeck.remove(card);
          break;
        default:
          for (int j = 0; j < cardColumns.length; j++) {
            var column = cardColumns[j];
            if (column.contains(card)) column.remove(card);
          }
      }
    }
    moveTo.add(card);
  }

}