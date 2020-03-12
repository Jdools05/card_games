import 'dart:math';
import 'package:cardgames/playingcard.dart';
import 'package:cardgames/provider_widget.dart';
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

  List<PlayingCard> _cardDeckClosed = [];
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
  }

  void populateCards() {
    CardSuit.values.forEach((suit) {
      CardType.values.forEach((type) {
        allCards.add(new PlayingCard(
          cardType: type,
          cardSuit: suit,
          faceUp: false,
        ));
      });
    });

    for (int i = 0; i < 7; i++) {
      for (int w = 0; w < 7; w++) {
        if (w >= i) {
          int randomInt = random.nextInt(allCards.length);
          PlayingCard card = allCards[randomInt];
          cardColumns[i].add(card..faceUp = true);
          allCards.removeAt(randomInt);
        }
      }
    }
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

  List<PlayingCard> get cardDeckClosed => _cardDeckClosed;
  set cardDeckClosed(List<PlayingCard> value) {
    _cardDeckClosed = value;
    notifyListeners();
  }


}