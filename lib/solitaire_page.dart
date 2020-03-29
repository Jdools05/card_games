import 'package:cardgames/playing_card.dart';
import 'package:cardgames/playing_card_drag_target.dart';
import 'package:cardgames/provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cardgames/solitaire_provider.dart';

class SolitairePage extends StatefulWidget {


  SolitairePage({Key key}) : super(key: key);

  @override
  _SolitairePageState createState() => _SolitairePageState();
}


class _SolitairePageState extends State<SolitairePage> {

  final cont = Container(
    width: 50,
    height: 70,
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(3)),
      color: Colors.blue,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SolitaireProvider>(
      create: (context) => SolitaireProvider(random: Provider.of<MainProvider>(context, listen: false).random),
      child: Builder(
        builder: (context) {
          SolitaireProvider pageProvider = Provider.of<SolitaireProvider>(context);
          return Scaffold(
            backgroundColor: Colors.lightGreen,
            appBar: AppBar(
              title: Text('Solitare'),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox.fromSize(
                  size: Size.fromHeight(80),
                  child: Flex(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    direction: Axis.horizontal,
                    children: [
                      Flexible(flex: 1, child: Stack(children: pageProvider.cardDeckClosed,)),
                      Spacer(),
                      ...List.filled(4, Flexible(flex: 1, child: PlayingCardDragTarget(child: cont))),
                    ],
                  ),
                ),
                SizedBox.fromSize(
                  size: Size.fromHeight(120),
                  child: Flex(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    direction: Axis.horizontal,
                    children: [
                      ...List.filled(7, Flexible(flex: 1, child: PlayingCardDragTarget(child: cont))),
                    ],
                  ),
                ),
              ],
            )
          );
        },
      ),
    );
  }
}

//Draggable<String>(
//child: pageProvider.cardDeckOpened[0].image,
//feedback: pageProvider.cardDeckOpened[0].image,
//childWhenDragging: Container(),
//data: 'Card',
//),

//Container(
//child: DragTarget<String>(
//builder: (context, List<String> candidateData, rejectedData) {
//return accepted ? Padding(
//padding: EdgeInsets.only(top: 100.0),
//child: Container(
//width: 100,
//height: 200,
//color: Colors.black,
//child: pageProvider.cardDeckOpened[0].image,
//),
//) : Container(
//width: 100,
//height: 200,
//color: Colors.blue,
//);
//}, onWillAccept: (data) {
//return true;
//}, onAccept: (data) {
//setState(() {
//accepted = true;
//});
//},
//),
//),

