import 'dart:math';
import 'package:flutter/material.dart';
import 'playingCard.dart';

List<PlayingCard> allCards = [];

// each list is a column in the solitaire field
List<List<PlayingCard>> cardColumns = [[]];

List<PlayingCard> cardDeckClosed = [];
List<PlayingCard> cardDeckOpened = [];

List<PlayingCard> finalHeartDeck = [];
List<PlayingCard> finalDiamondDeck = [];
List<PlayingCard> finalSpadesDeck = [];
List<PlayingCard> finalClubsDeck = [];


void populateCards() {
  Random random = Random();

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
      print('$i $w');
      if (w >= i) {
        int randomInt = random.nextInt(allCards.length);
        PlayingCard card = allCards[randomInt];
        cardColumns[i].add(card..faceUp = true);
        allCards.removeAt(randomInt);
      }
    }
  }
}

class SolitairePage extends StatefulWidget {


  SolitairePage({Key key}) : super(key: key);

  @override
  _SolitairePageState createState() => _SolitairePageState();
}


class _SolitairePageState extends State<SolitairePage> {

  int _rand = 0;

  void randomizeCard() {
    setState(() {
      _rand = Random().nextInt(allCards.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    populateCards();
    return Scaffold(
      appBar: AppBar(
        title: Text('Solitare'),
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 3 / 2,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  allCards[_rand].image,
//                  Text(
//                    cardColumns.toString()
//                  ),
                ]
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: randomizeCard,
        tooltip: 'Random Card',
        child: Icon(Icons.swap_calls),
      ),
    );
  }
}
