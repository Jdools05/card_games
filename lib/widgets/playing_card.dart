import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayingCardWidget extends StatefulWidget {
  final double width;
  final double height;
  final PlayingCard card;
  final VoidCallback onTap;

  PlayingCardWidget({Key key, this.width: 50, this.height: 70, @required this.card, this.onTap}) : super(key: key);
  bool get faceUp => card.faceUp;
  bool get opened => card.opened;

  @override
  _PlayingCardWidgetState createState() => _PlayingCardWidgetState(card: card);
}

class _PlayingCardWidgetState extends State<PlayingCardWidget> {
  final PlayingCard card;

  _PlayingCardWidgetState({this.card});

  @override Widget build(BuildContext context) {
    var size = Size(widget.width, widget.height);
    var image = Image.asset("assets/cards/${card.suit.name}.png", fit: BoxFit.fitWidth, width: size.width / 5);
    var micro = size.width / 10;

    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: const BorderRadius.all(Radius.circular(3)),
      ),
      child: GestureDetector(
        onTap: widget.onTap ?? () => setState(() => card.faceUp = !card.faceUp),
        child: card.faceUp ? Stack(
          children: <Widget>[
            Positioned(
              top: micro,
              left: micro,
              child: image,
            ),
            Center(child: Text(card.value.name, style: Theme.of(context).textTheme.caption,)),
            Positioned(
              bottom: micro,
              right: micro,
              child: image,
            )
          ],
        ) : Image.asset("assets/cards/yellow_back.png", width: 50, height: 70),
      ),
    );
  }
}

class PlayingCard {
  final CardSuit suit;
  final CardValue value;
  bool faceUp;
  bool opened;

  PlayingCard({@required this.suit, @required this.value, this.faceUp: false, this.opened: false});

  void flip() => faceUp = !faceUp;
  void open() => opened = true;

  PlayingCardWidget toWidget({double width: 50, double height: 70, VoidCallback onTap}) {
    return PlayingCardWidget(
      card: this,
      width: width,
      height: height,
      onTap: onTap ?? () {},
    );
  }
}

enum CardSuit {
  diamonds,
  hearts,
  spades,
  clubs,
}

extension metadata on CardSuit {
  static const Map<CardSuit, String> names = {
    CardSuit.diamonds: "Diamonds",
    CardSuit.hearts: "Hearts",
    CardSuit.spades: "Spades",
    CardSuit.clubs: "Clubs",
  };
  String get name => names[this];

  static const Map<CardSuit, Color> colors = {
    CardSuit.diamonds: const Color(0xFFFF0000),
    CardSuit.spades: const Color(0xFF000000),
    CardSuit.hearts: const Color(0xFFFF0000),
    CardSuit.clubs: const Color(0xFF000000),
  };
  Color get color => colors[this];
}

enum CardValue {
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
  ace
}

extension data on CardValue {
  static const Map<CardValue, String> names = {
    CardValue.two: "Two",
    CardValue.three: "Three",
    CardValue.four: "Four",
    CardValue.five: "Five",
    CardValue.six: "Six",
    CardValue.seven: "Seven",
    CardValue.eight: "Eight",
    CardValue.nine: "Nine",
    CardValue.ten: "Ten",
    CardValue.jack: "Jack",
    CardValue.queen: "Queen",
    CardValue.king: "King",
    CardValue.ace: "Ace",
  };
  String get name => names[this];

  static const Map<CardValue, String> values = {
    CardValue.two: "2",
    CardValue.three: "3",
    CardValue.four: "4",
    CardValue.five: "5",
    CardValue.six: "6",
    CardValue.seven: "7",
    CardValue.eight: "8",
    CardValue.nine: "9",
    CardValue.ten: "10",
    CardValue.jack: "J",
    CardValue.queen: "Q",
    CardValue.king: "K",
    CardValue.ace: "A",
  };
  String get value => values[this];
}