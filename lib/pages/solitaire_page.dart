import 'dart:math';

import 'package:cardgames/widgets/animated_flippable_widget.dart';
import 'package:cardgames/widgets/draggable_playing_card.dart';
import 'package:cardgames/widgets/playing_card.dart';
import 'package:cardgames/widgets/playing_card_drag_target.dart';
import 'package:cardgames/providers/provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:cardgames/providers/solitaire_provider.dart';

class SolitairePage extends StatefulWidget {


  SolitairePage({Key key}) : super(key: key);

  @override
  _SolitairePageState createState() => _SolitairePageState();
}


class _SolitairePageState extends State<SolitairePage> with SingleTickerProviderStateMixin {

  AnimationController _controller;

  final cont = Container(
    width: 50,
    height: 70,
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(3)),
      color: Colors.blue,
    ),
  );

  @override
  void initState(){
    _controller = new AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var unknownDeck = _getFaceDownDeck(context);
    var openDeck = _getFaceUpDeck(context);
    return ChangeNotifierProvider<SolitaireProvider>(
      create: (context) => SolitaireProvider(random: Provider.of<MainProvider>(context, listen: false).random),
      child: Builder(
        builder: (context) {
          SolitaireProvider pageProvider = Provider.of<SolitaireProvider>(context);
          return Scaffold(
            backgroundColor: Colors.lightGreen,
            appBar: AppBar(
              title: Text('Solitare'),
              actions: <Widget>[
                FlatButton(onPressed: () {
                  if (_controller.status == AnimationStatus.dismissed) _controller.forward();
                  else if (_controller.status == AnimationStatus.completed) _controller.reverse();
                },
                  child: Text("Flip Card")
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: LayoutBuilder(
                builder: (context, constraints) => Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      left: 50,
                      child: unknownDeck,
                    ),
                    Positioned(
                      top: 0,
                      left: 60,
                      child: openDeck,
                    )
                  ].reversed.toList(),
                ),
              ),
            )
          );
        },
      ),
    );
  }

  Widget _getFaceDownDeck(BuildContext context) {
    return Consumer<SolitaireProvider>(
      builder: (context, pageProvider, child) {
        PlayingCard currentCard = pageProvider.unknownCards.last;
        return AnimatedFlippableWidget(
          alignment: Alignment.centerLeft,
          key: ValueKey(currentCard.suit.name + currentCard.value.value),
          builder: (context, rotationZ, offset) {
            currentCard.faceUp = rotationZ.value < -3*pi/2;
            if (_controller.status == AnimationStatus.completed) {
              pageProvider.transferCard(currentCard, pageProvider.cardDeckOpened);
              print("Transfered card!");
            }
            return currentCard.toWidget();
          },
          position: Tween<Offset>(
            begin: Offset.zero,
            end: const Offset(10, 0),
          ),
          controller: _controller,
        );
      },
    );
  }

  Widget _getFaceUpDeck(BuildContext context) {
    return Consumer<SolitaireProvider>(
      builder: (context, pageProvider, child) {
        PlayingCard currentCard = pageProvider.cardDeckOpened.last;
        currentCard.flip();
        return currentCard.toWidget();
      },
    );
  }
}
